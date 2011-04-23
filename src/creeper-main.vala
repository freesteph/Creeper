/* Creeper - a creepy application for your GNOME desktop
 * © 2011 Stéphane Maniaci <stephane.maniaci@gmail.
 * Licensed under GPLv3+.
 */

using Wnck;
using Gee;
using Gtk;

class Creeper.MainWindow {

	private Gtk.Builder builder;
	private Gtk.Window window;
	private Gtk.TreeView tree;

	private Gtk.ListStore store;

	private Wnck.Screen screen;
	private Creeper.ActivitiesTree view;

	private Timer timer_today;

	private Activity current_activity;
	private Gee.ArrayList<Activity> activities;

	const string UI_FILE = Config.PACKAGE_DATA_DIR + "/creeper/ui/main.ui";

	public MainWindow () {
		activities = new Gee.ArrayList<Activity> ();

		builder = new Gtk.Builder ();
		try {
			if (Utils.on_development ()) {
				builder.add_from_file ("main.ui");
			} else {
				builder.add_from_file (UI_FILE);
			}
		} catch (Error e) {
			error ("Unable to load UI file: " + e.message);
		}

		window = builder.get_object ("window1") as Gtk.Window;
		tree   = builder.get_object ("treeview1") as Gtk.TreeView;
		store = builder.get_object ("activitiesstore") as Gtk.ListStore;

		window.destroy.connect (Gtk.main_quit);

		view = new ActivitiesTree (builder);
		timer_today = new Timer ();

		screen = Wnck.Screen.get_default ();
		screen.active_window_changed.connect (_on_active_window_changed);
		screen.window_stacking_changed.connect ( (screen) =>
			{
				//FIXME: null is bad
				_on_active_window_changed (screen, null);
			});
	}

	public void _on_active_window_changed (Wnck.Screen screen, Wnck.Window? prev) {
		// stop previous activity
		if (current_activity != null) {
			current_activity.pause ();
		}

		// get current application
		var win = screen.get_active_window ();
		if (win == null) return;

		var app = win.get_application ();

		int i = 0;
		bool found = false;
		while (i < activities.size && !found) {
			var a = activities.get (i);
			if (a.app.get_name () == app.get_name ()) {
				current_activity = a;
				found = true;
			}
			i++;
		}

		if (!found) {
			current_activity = new Activity.from_app (app);
			add_activity (current_activity);
		}

		current_activity.start ();
		update_store ();
		return;
	}

	public void update_store () {
		store.clear ();
		activities.sort ((CompareFunc) compare_activities);
		foreach (Activity a in activities) {
			Gtk.TreeIter iter;
			store.append (out iter);
			store.set (iter,
					   0, activities.index_of (a) + 1,
					   1, a.icon,
					   2, "<b>" + a.name + "</b>",
					   3, a.strtime,
					   4, (a.timer.elapsed () / timer_today.elapsed () ) * 100,
					   -1);

		}

	}

	public bool add_activity (Activity a) {
		activities.add (a);
		activities.sort ((CompareFunc) compare_activities);
		update_store ();
		return true;
	}

	public static int compare_activities (Activity a, Activity b) {
		if (a.timer.elapsed () > b.timer.elapsed ()) {
			return -1;
		} else if (a.timer.elapsed () < b.timer.elapsed ()) {
			return 1;
		} else {
			return 0;
		}
	}

	public void run () {
		window.show_all ();
		Gtk.main ();
	}

	public static int main(string []args) {
		var app = new Gtk.Application ("org.gnome.Creeper", 0);
		app.activate.connect ( () => {
				weak GLib.List list = app.get_windows ();
				if (list == null) {
					var mainwindow = new MainWindow ();
					mainwindow.run ();
				} else {
					debug ("already running!");
				}
			});
		return app.run (args);
	}
}
