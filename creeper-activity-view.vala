
class Creeper.ActivitiesView {

	private Gtk.Table table;

	public ActivitiesView (Gtk.Table t) {
		table = t;
	}

	public void resize (int rows, int columns) {
		table.resize (rows, columns);
	}

	public void render_row (Activity a, int index, double percentage) {

		/* Label + icon for the application */
		var app_box   = new Gtk.HBox (false, 0);
		var app_label = new Gtk.Label (a.name);
		var app_icon  = new Gtk.Image.from_pixbuf (a.icon);

		app_label.set_alignment (1, 0);
		app_label.xpad = 12;
		app_label.ypad = 6;

		app_box.pack_start (app_label, true, true, 0);
		app_box.pack_start (app_icon, false, false, 0);

		/* progress bar and percentage */
		var area   = new Gtk.DrawingArea ();
		var elapsed = make_time_look_good (a.timer.elapsed ());
		var label  = new Gtk.Label (elapsed);
		label.set_justify (Gtk.Justification.RIGHT);

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

	public string make_time_look_good (double time) {
		var h = (int) time/3600;
		var m = (int) ((time - h * 3600)/60);
		var s = (int) (time - (h*3600) - (m*60));

		string result = "";
		if (h != 0) result += @"$(h)h";
		if (m != 0) result += @"$(m)m";
		result += @"$(s)s";
		return result;
	}

	public void refresh () {
		table.show_all ();
	}

	public bool render_progress (Gtk.Widget widget, Cairo.Context cr, Activity a, double percentage) {
		int w = widget.get_allocated_width ();
		int h = widget.get_allocated_height ();

		// printf ("%%") = "%"
		// cause not everybody knows, you know.
		var labelstr = "%3.0f%%".printf (percentage*100);

		cr.set_line_width (1);
		cr.set_source_rgb (0.5, 0.5, 0.5);
		cr.rectangle (0, 0, w*percentage, h); 
		cr.fill_preserve ();
		cr.set_source_rgb (0.3, 0.3, 0.3);
		cr.stroke ();

		cr.move_to (w*percentage + 12, h/2);
		cr.show_text (labelstr);
		return false;
	 }

	public void remove_all () {
		table.foreach ( (w) => { table.remove (w); });
		assert (table.get_children ().first () == null);
	}
}
