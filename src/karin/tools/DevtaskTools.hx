package karin.tools;
import karin.types.DTask;
import karin.types.DTaskComment;
import karin.types.DTasks;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;

class DevtaskTools
{
	static public function parseData(cells:Array<Array<String>>):DTasks {		
		var rows:Array<Array<String>> = new Array<Array<String>>();
		for (row in 0...cells.length) {
			if (cells[row] == null) continue;			
			var cols:Array<String> = ['', '', '', '', '', '', '', ''];
			rows.push(cols);
			for (col in 0...cells[row].length) {
				if (cells[row][col] != null) {
					var str = cells[row][col];				
					//trace([row, col, str]);
					cols[col] = str;
				}
			}
		}
		
		var dTasks:DTasks = new DTasks();
		
		var dTask:DTask = null;
		for (row in rows) {			
			var col0 = row[0];
			var col1 = row[1];
			var col2 = row[2];
			var col3 = row[3];
			var col4 = row[4];
			var col5 = row[5];
			var col6 = row[6];
			var col7 = row[7];
			
			if (Std.string(col0).trim() == '') continue;
			if (Std.string(col0).trim().charAt(0) == '#') continue;
			if (Std.string(col0).trim().charAt(0) == '-') {
				if (dTask == null) continue;
				var dTaskComment:DTaskComment = {
					info: col2,
					prio: Std.parseInt(col3),
					status : col4,
					date : col5,
					sign : col6,										
				}
				dTask.comments.push(dTaskComment);								
			} else {				
				dTask = {					
					subject : col0,
					title : col1,
					info : col2,
					prio: Std.parseInt(col3),
					status : col4,
					date : col5,
					sign : col6,
					comments: [],
				}
				dTasks.push(dTask);
			}			
		}
		return dTasks;
	}
}

