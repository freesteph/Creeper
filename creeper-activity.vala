
class Creeper.Activity {

	public string name         { get; private set; }
	public string icon_name    { get; private set; }	
	public string command_name { get; private set; }
	public Timer timer;
	public static ulong time;
	public float percentage    { get; private set; default=0.5f; }

	public Activity (string n, ulong t) {
		timer = new Timer ();
		timer.stop ();
		percentage = (float)(t)/(float)time;
		name = n;
		debug (@"Percentage = $percentage");
	}

	public Activity.from_app (Wnck.Application app) {
		timer = new Timer ();
		timer.stop ();
		name = app.get_name ();
		icon_name = app.get_icon_name ();
	}

	public void start () {
		timer.start ();
	}

	public void pause () {
		timer.stop ();
	}

	public string to_string () {
		return @"$(this.name) - icon: $(this.icon_name)";
	}
}