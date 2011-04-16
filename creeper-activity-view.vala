
class Creeper.ActivitiesView : Gtk.Table {

	private Gtk.Table table;

	private Gee.ArrayList<Activity> activities;

	public ActivitiesView (Gtk.Table t) {
		table = t;
		activities = new Gee.ArrayList<Activity> ();
	}

	public void add_activity (Activity a) {
		activities.add (a);
		render_row (a);
	}

	public void render_row (Activity a) {
		var iconset = new Gtk.IconTheme ();
		iconset.get_default ();
		Gdk.Pixbuf pix = null;
		try {
			pix = iconset.load_icon ("google-chrome", 32, 0);
		} catch (Error e) {
			debug ("Cannot load icon file");
		}

		/* Label + icon for the application */
		var app_box   = new Gtk.HBox (false, 0);
		var app_label = new Gtk.Label (a.name);
		var app_icon  = new Gtk.Image.from_pixbuf (pix);
		app_label.set_alignment (1, 0);
		app_label.xpad = 12;
		app_label.ypad = 6;

		app_box.pack_start (app_label, true, true, 0);
		app_box.pack_start (app_icon, false, false, 0);

		/* progress bar and percentage */
		var area   = new Gtk.DrawingArea ();
		var label  = new Gtk.Label (@"$(a.percentage*100)");

		/* attach them all */
		table.attach (app_box, 0, 1, activities.size, activities.size+1,
					  Gtk.AttachOptions.FILL | Gtk.AttachOptions.SHRINK,
					  Gtk.AttachOptions.SHRINK,
					  12, 12);
		table.attach (area, 1, 2, activities.size, activities.size+1,
					  Gtk.AttachOptions.EXPAND | Gtk.AttachOptions.FILL,
					  Gtk.AttachOptions.FILL,
					  0, 12);
		table.attach (label, 2, 3, activities.size, activities.size+1,
					  Gtk.AttachOptions.SHRINK,
					  Gtk.AttachOptions.SHRINK,
					  12, 12);
		area.draw.connect ( (w, cr ) => {
				return render_progress (w, cr, a);
			});
	}

	public bool render_progress (Gtk.Widget widget, Cairo.Context cr, Activity a) {
		int w = widget.get_allocated_width ();
		int h = widget.get_allocated_height ();

		int radius = w / 40;
		cr.set_source_rgb (0.3, 0.3, 0.3);
		cr.line_to  (w*a.percentage - radius, 0);
		cr.curve_to (w*a.percentage - radius, 0,
					 w*a.percentage, 0,
					 w*a.percentage, radius);
		cr.line_to  (w*a.percentage, h - radius);
		cr.curve_to (w*a.percentage, h - radius,
					 w*a.percentage, h,
					 w*a.percentage - radius, h);
		cr.line_to  (0, h);
		cr.line_to  (0, 0);
		cr.fill ();
	 	return false;
	 }
}