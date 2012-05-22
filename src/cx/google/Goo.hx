package cx.google;

/**
 * ...
 * @author Jonas Nyström
 */

class Goo 
{

	
	static public function getAuthToken(user:String, pass:String, service='wise') {
		
		var proc = new Process ("curl", [
			'https://www.google.com/accounts/ClientLogin',
			'-d',
			'Email=' + email + '@gmail.com',
			'-d',
			'Passwd=' + pass,
			'-d',
			'accountType=HOSTED_OR_GOOGLE',
			'-d',
			'source=cURL-Example',
			'-d',
			'service=' + service,
			'-k'
		]);		
		
		
		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		
		var authToken = StringTools.replace(lines.pop(), 'Auth=', '');		
		return authToken;
		
	}
	
}