package ka.tools;
import cx.Tools;
import ka.types.Person;
import ka.types.Personer;

/**
 * ...
 * @author Jonas Nyström
 */

class PersonerTools 
{
	static public function getPersonerEmails(personer:Personer):Array<String> {
		var emails = new Array<String>();
		for (person in personer) {
			emails.push(person.epost);
		}
		return emails;
	}

	static public function getPersonerHtml(personer:Personer, ?fieldnames:Person=null):String {
		var html = '';		
		html += '<table width="100%" border="1">';
		html += '<tr>';		
		
		
		if (fieldnames != null) {
			
		}
		/*
		for (field in fieldsPersoner) {
			html += '<th>';	html += field; html += '</th>';	
		}
		*/
		
		
		
		html += '</tr>';
		for (person in personer) {
			html += '<tr>';
			html += '<td>';	html += Tools.replaceNullString(person.personnr); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.fornamn); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.efternamn); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.epost); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.gatuadr); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.postnr); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.postadr); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.lan); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.roll); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.kor); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.admgrupp); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.studieterminer.join(', ')); html += '</td>';	
			html += '<td>';	html += Tools.replaceNullString(person.studiestart); html += '</td>';
			html += '<td>';	html += Tools.replaceNullString(person.studieavslut); html += '</td>';
			html += '<td>';	html += Tools.replaceNullString(person.loggstudier); html += '</td>';
			html += '<td>';	html += Tools.replaceNullString(person.loggpersonligt); html += '</td>';
			html += '<td>';	html += Tools.replaceNullString(person.anteckningar); html += '</td>';
			html += '<td>';	html += Tools.replaceNullString(person.xpass); html += '</td>';
			html += '</tr>';
		}
		html += '</table>';
		return html;		
	}
	
	
}