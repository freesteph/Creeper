
class Creeper.Activity {

	public string name         { get; private set; }
	public string icon_name    { get; private set; }	
	public string command_name { get; private set; }
	public Timer timer;
	public static ulong time;
	public float percentage     { get; private set; default=0.5f; }
	public Wnck.Application app { get; private set; }

	public Activity.from_app (Wnck.Application a) {
		app = a;
		timer = new Timer ();
		timer.stop ();
		name = app.get_name ();
		debug ("Resource: " + a.get_icon_name ());
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