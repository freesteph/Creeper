
class Creeper.ActivitiesTree {

	private Gtk.TreeView tree;

	private Gtk.TreeViewColumn app_rank;
	private Gtk.TreeViewColumn app_name;
	private Gtk.TreeViewColumn app_icon;
	private Gtk.TreeViewColumn app_time;

	public ActivitiesTree (Gtk.Builder builder) {
		tree = builder.get_object ("treeview1") as Gtk.TreeView;
		app_rank = builder.get_object ("rank-column") as Gtk.TreeViewColumn;

		var render_rank = new Gtk.CellRendererText ();
		app_rank.add_attribute (render_rank,
								"text",
								0);
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
		var render_app_time = new Gtk.CellRendererText ();
		app_time = new Gtk.TreeViewColumn.with_attributes ("Time",
														   render_app_time,
														   "text",
														   3,
														   null);
		tree.append_column (app_rank);
		tree.append_column (app_icon);
		tree.append_column (app_name);
		tree.append_column (app_time);
	}
}