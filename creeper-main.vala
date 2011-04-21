using Wnck;
using Gee;
using Gtk;

class Creeper.MainWindow {

	private Gtk.Builder builder;
	private Gtk.Window window;
	private Gtk.TreeView tree;

	private Gtk.ListStore activities_store;

	private Wnck.Screen screen;
	private Creeper.ActivitiesTree view;

	private Timer timer_today;

	private Activity current_activity;
	private Gee.ArrayList<Activity> activities;

	public MainWindow () {
		activities = new Gee.ArrayList<Activity> ();

		builder = new Gtk.Builder ();
		try {
			builder.add_from_file ("main2.ui");
		} catch (Error e) {
			error ("Unable to load UI file: " + e.message);
		}

		window = builder.get_object ("window1") as Gtk.Window;
		tree   = builder.get_object ("treeview1") as Gtk.TreeView;
		activities_store = builder.get_object ("activitiesstore") as Gtk.ListStore;

		window.destroy.connect (Gtk.main_quit);

		view = new ActivitiesTree (tree);
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
			debug (@"Pausing previous activity, ran for $(current_activity.time)");
		}

		// get current application
		var win = screen.get_active_window ();
		if (win == null) return;

		var app = win.get_application ();

		int i = 0;
		bool found = false;
		while (i < activities.size && !found) {
			var a = activities.get (i);
			if (a.app == app) {
				current_activity = a;
				found = true;
			}
			i++;
		}

		if (!found) {
			current_activity = new Activity.from_app (app);
			add_activity (current_activity);
			debug (@"Created new activity: $current_activity");
		}

		debug (@"Switched to: $current_activity");
		current_activity.start ();
		view.update ();
		return;
	}

	public bool add_activity (Activity a) {
		activities.add (a);
		activities.sort ((CompareFunc) compare_activities);

		Gtk.TreeIter iter;
		activities_store.append (out iter);
		activities_store.set (iter, 
							  0, activities.index_of (a) + 1,
							  1, a.icon,
							  2, a.name,
							  3, make_time_look_good (a.time),
							  -1);
		return true;
	}

	public string make_time_look_good (double time) {
		var h = (int) time/3600;
		var m = (int) ((time - h * 3600)/60);
		var s = (int) (time - (h*3600) - (m*60));

		string result = "";
		if (h != 0) result += @"$(h)h";
		if (m != 0) result += @"$(m)m";
		result += @"$(s)s";
		return result;
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
		var app = new Gtk.Application ("org.gnome.creeper", 0);
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
