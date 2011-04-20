
class Creeper.Activity {

	public string name         { get; private set; }
	public string command_name { get; private set; }
	public Timer timer;
	public double time { get; private set; }
	public float percentage    { get; private set; default = 0.5f; }
	public Wnck.Application app { get; private set; }
	public Gdk.Pixbuf icon { get; private set; }

	public Activity.from_app (Wnck.Application a) {
		app = a;
		name = app.get_name ();
		icon = app.get_icon ();
		timer = new Timer ();
		timer.stop ();
		time = 0;
	}

	public void start () {
		timer.continue ();
	}

	public void pause () {
		timer.stop ();
		time = timer.elapsed ();
	}

	public string to_string () {
		return @"$(this.name)";
	}
}