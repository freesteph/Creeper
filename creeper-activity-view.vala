
class Creeper.ActivityView : Gtk.HBox {

	private Activity activity;

	private Gtk.Button      button;
	private Gtk.Image       icon;
	private Gtk.DrawingArea surface;

	private static int width;

	public ActivityView (Activity a) {
		activity = a;

		button = new Gtk.Button.with_label (a.name);
		surface = new Gtk.DrawingArea ();
		surface.draw.connect ( (widget, cairo) => {
				render (widget, cairo);
				return false;
			});

		this.pack_start (button, false, false, 12);
		this.pack_start (surface, true, true, 12);

		this.homogeneous = false;
		this.show_all ();
	}

	public bool render (Gtk.Widget w, Cairo.Context cr) {
		int wi = w.width_request;
		debug (@"Width request: $wi");
		return false;
	}

	public string toString () {
		return "Rendering activity: " + activity.name + "\n";
	}
}