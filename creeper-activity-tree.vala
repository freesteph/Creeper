
class Creeper.ActivitiesTree {

	private Gtk.TreeView tree;

	private Gtk.TreeViewColumn rank;
	private Gtk.TreeViewColumn app_name;
	private Gtk.TreeViewColumn app_icon;
	private Gtk.TreeViewColumn app_time;

	public ActivitiesTree (Gtk.TreeView t) {
		tree = t;

		var render_rank = new Gtk.CellRendererText ();
		rank = new Gtk.TreeViewColumn.with_attributes ("Rank",
													   render_rank,
													   "text",
													   0,
													   null);
		var render_app_name = new Gtk.CellRendererText ();
		app_name = new Gtk.TreeViewColumn.with_attributes ("Application",
														   render_app_name,
														   "text",
														   2,
														   null);
		var render_app_icon = new Gtk.CellRendererPixbuf ();
		app_icon = new Gtk.TreeViewColumn.with_attributes ("Icon",
														   render_app_icon,
														   "pixbuf",
														   1,
														   null);
		tree.append_column (rank);
		tree.append_column (app_icon);
		tree.append_column (app_name);
	}

	public void update () {
		
	}
}