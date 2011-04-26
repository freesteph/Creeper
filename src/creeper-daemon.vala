using Wnck;

[DBus (name = "org.gnome.Creeper")]
interface Creeper.DaemonInterface {

	public abstract string[] get_activity_time_since (string classname, string time);
	public abstract string[] get_all_activities      ();
}


class Creeper.Daemon : DaemonInterface {

	public string[] get_activity_time_since (string classname, string time) {
		string result[1] = { "test", "value" };
		return result;
	}

	public string[] get_all_activities () {
		string result[2] = { "a", "b", "c" };
		return result;
	}

	private Activity current_activity;
	private Gee.ArrayList<string> activities;
	private Timer timer_today;
	private Wnck.Screen screen;

	public Daemon () {
		activities = new Gee.ArrayList<string> ();

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
		/*
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

		current_activity.start ();*/
		return;
	}

	public bool add_activity (Activity a) {
		//\activities.add (a);
		activities.sort ((CompareFunc) compare_activities);
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

	private void on_bus_acquired (DBusConnection conn) {
		try {
			conn.register_object ("/org/gnome/Creeper", this);
		} catch (IOError e) {
			error ("Unable to register service: " + e.message);
		}
	}

	public static void main (string []args) {
		return;
	}
}