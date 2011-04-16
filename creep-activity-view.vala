
class Creeper.ActivityView : Gtk.HBox {

	private Activity activity;

	private Gtk.Button      button;
	private Gtk.Icon        icon;
	private Gtk.DrawingArea surface;

	public ActivityView (Activity a) {
		activity = a;

		button = new Gtk.Button.with_label (a.name);
		surface = new Gtk.DrawingArea ();

		this.pack_start (button, false, false, 12);
		this.pack_start (surface, true, true, 12);

		this.homogeneous = false;
	}

	public void render () {

	}
}