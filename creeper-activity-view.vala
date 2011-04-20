
class Creeper.ActivitiesView {

	private Gtk.Table table;

	public ActivitiesView (Gtk.Table t) {
		table = t;
	}

	public void resize (int rows, int columns) {
		table.resize (rows, columns);
	}

	public void render_row (Activity a, int index, double percentage) {

		Gdk.Pixbuf icon = a.app.get_icon ();

		/* Label + icon for the application */
		var app_box   = new Gtk.HBox (false, 0);
		var app_label = new Gtk.Label (a.name);
		var app_icon  = new Gtk.Image.from_pixbuf (icon);

		app_label.set_alignment (1, 0);
		app_label.xpad = 12;
		app_label.ypad = 6;

		app_box.pack_start (app_label, true, true, 0);
		app_box.pack_start (app_icon, false, false, 0);

		/* progress bar and percentage */
		var area   = new Gtk.DrawingArea ();
		var labelstr = "%3.0f".printf (percentage*100);
		var label  = new Gtk.Label (labelstr);

		/* attach them all */
		table.attach (app_box, 0, 1, index, index+1,
					  Gtk.AttachOptions.FILL | Gtk.AttachOptions.SHRINK,
					  Gtk.AttachOptions.SHRINK,
					  12, 12);
		table.attach (area, 1, 2, index, index+1,
					  Gtk.AttachOptions.EXPAND | Gtk.AttachOptions.FILL,
					  Gtk.AttachOptions.FILL,
					  0, 12);
		table.attach (label, 2, 3, index, index+1,
					  Gtk.AttachOptions.SHRINK,
					  Gtk.AttachOptions.SHRINK,
					  12, 12);
		area.draw.connect ( (w, cr ) => {
				return render_progress (w, cr, a, percentage);
			});
	}

	public void refresh () {
		table.show_all ();
	}

	public bool render_progress (Gtk.Widget widget, Cairo.Context cr, Activity a, double percentage) {
		int w = widget.get_allocated_width ();
		int h = widget.get_allocated_height ();

		int radius = w / 40;
		cr.set_line_width (1);
		cr.set_source_rgb (0.5, 0.5, 0.5);
		/* since our line-width is 1, and that cairo move_to() defines
		   where the _center_ of the line is, we need to add an offset 
		   of half that line-width, otherwise Cairo will eat the pixels
		   on the side. The offset makes it use a full pixel. I think. */
		cr.move_to  (0.5, 0);
		cr.line_to  (0.5 + w*percentage - radius, 0);
		cr.curve_to (0.5 + w*percentage - radius, 0,
					 0.5 + w*percentage, 0,
					 0.5 + w*percentage, radius);
		cr.line_to  (0.5 + w*percentage, h - radius);
		cr.curve_to (0.5 + w*percentage, h - radius,
					 0.5 + w*percentage, h,
					 0.5 + w*percentage - radius, h);
		cr.line_to  (0.5, h);
		cr.line_to  (0.5, 0);
		cr.fill_preserve ();
		cr.set_source_rgb (0.3, 0.3, 0.3);
		cr.stroke ();
	 	return false;
	 }

	public void remove_all () {
		table.foreach ( (w) => { table.remove (w); });
		assert (table.get_children ().first () == null);
	}
}