
class Creeper.Activity {

	public string name         { get; private set; }
	public string command_name { get; private set; }
	public Timer timer;
	public float percentage    { get; private set; default = 0.5f; }
	public Wnck.Application app { get; private set; }

	public Activity.from_app (Wnck.Application a) {
		app = a;
		name = app.get_name ();
		timer = new Timer ();
		timer.stop ();
	}

	public void start () {
		timer.start ();
	}

	public void pause () {
		timer.stop ();
	}

	public string to_string () {
		return @"$(this.name)";
	}
}