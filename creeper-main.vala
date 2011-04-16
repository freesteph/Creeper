using Gee;
using Gtk;

class Creeper.MainWindow {

	private Gtk.Window window;
	private Gtk.Toolbar toolbar;
	private Creeper.ActivitiesView view;

	public MainWindow () {
		var builder = new Gtk.Builder ();
		try {
			builder.add_from_file ("main.ui");
		} catch (Error e) {
			error ("Unable to load UI file: " + e.message);
		}
		window = builder.get_object ("window1") as Gtk.Window;
		toolbar = builder.get_object ("toolbar1") as Gtk.Toolbar;
		var table = builder.get_object ("table2") as Gtk.Table;

		toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
		view = new ActivitiesView (table);
		window.destroy.connect (Gtk.main_quit);

		Activity.time = 100000;

		add_activity (new Activity ("Google Chrome", 50000));
		add_activity (new Activity ("Epiphany web browser", 25000));
		add_activity (new Activity ("Emacs", 10000));
	}

	public bool add_activity (Activity a) {
		debug ("Adding activity: " + a.name);
		view.add_activity (a);
		return true;
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
					debug ("Let's run");
					var mainwindow = new MainWindow ();
					mainwindow.run ();
				} else {
					debug ("already running!");
				}
			});
		return app.run (args);
	}
}		

