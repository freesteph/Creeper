
namespace Creeper.Utils {

	public static bool on_development () {
		File f = File.new_for_path (Environment.get_current_dir () + "/main.ui");
		return f.query_exists (null);
	}
}
			