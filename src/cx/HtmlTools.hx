package cx;

/**
 * ...
 * @author Jonas Nyström
 */

 /*
class Main {	
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var keyTestSheet = '0Ar0dMoySp13UdE93Vno1QlJ3cklrLW5zTWItOTRZS2c';
	
	static function main() {
		var gs = new cx.GoogleTools.Spreadsheet(email, passwd, keyTestSheet);
		trace(gs.getCells());
	}		
} 
*/
 
class HtmlTools 
{
	static public function getTableFromArray(items:Array<Array<String>>) {
		var html = '';
		html += '<table width="100%" border="1">';
		for (row in items) {
			trace(row);
			html += '<tr>';
			for (cell in row) {
				html += '<td>';
				html += cell;
				html += '</td>';
				
			}
			html += '</tr>';
		}
		html += '</table>';
		return html;
	}
	
	static public function getMeta() {
		return '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
	}	
	
}