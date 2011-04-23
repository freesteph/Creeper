
class Creeper.Activity : GLib.Object {

	public string name         { get; private set; }
	public string command_name { get; private set; }
	public Timer timer;
	public double time { get; private set; }
	public string strtime { get; private set; default = "0s"; }
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
		this.notify["time"].connect ((s, p) =>
			{
				strtime = format_time (time);
			});
	}

	public void start () {
		timer.continue ();
	}

	public void pause () {
		timer.stop ();
		time = timer.elapsed ();
	}

	public string format_time (double time) {
		var h = (int) time/3600;
		var m = (int) ((time - h * 3600)/60);
		var s = (int) (time - (h*3600) - (m*60));

		string result = "";
		if (h != 0) result += @"$(h)h";
		if (m != 0) result += @"$(m)m";
		result += @"$(s)s";
		return result;
	}
}