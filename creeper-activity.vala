
class Creeper.Activity {

	public string name { get; private set; }
	public string cmdline { get; private set; }
	public string time { get; private set; }

	public Activity (string n) {
		name = n;
	}
}