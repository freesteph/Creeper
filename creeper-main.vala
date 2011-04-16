using Gee;
using Gtk;

class Creeper.MainWindow {

	private Gtk.Window window;
	private Gtk.VBox activity_box;

	private Gee.HashMap<Creeper.Activity, Creeper.ActivityView> activites;

	public MainWindow () {
		var builder = new Gtk.Builder ();
		try {
			builder.add_from_file ("main2.ui");
		} catch (Error e) {
			error ("Unable to load UI file: " + e.message);
		}
		window = builder.get_object ("window1") as Gtk.Window;
		activity_box = builder.get_object ("vbox2") as Gtk.VBox;

		window.destroy.connect (Gtk.main_quit);

		activites = new Gee.HashMap<Activity, ActivityView> ();
		add_activity (new Activity ("Google Chrome"));
		add_activity (new Activity ("Epiphany web browser"));
					  
	}

	public bool add_activity (Activity a) {
		debug ("Adding activity: " + a.name);
		var view = new ActivityView (a);
		activites.set (a, view);

		activity_box.pack_start (view, true, true, 6);
		return true;
	}

	public void refresh_view () {
		window.show_all ();
	}

	public void run () {
		debug ("Running");
		window.show_all ();
		Gtk.main ();
	}

	public static void main(string []args) {
		var app = new Gtk.Application ("org.gnome.creeper", 0);
		app.activate.connect ( () => {
				weak GLib.List list = app.get_windows ();
				if (list == null) {
					debug ("Let's run");
					var mainwindow = new MainWindow ();
					mainwindow.run ();
				} else {
					debug ("already running!");
				}
			});
		var status = app.run (args);
	}
}		

