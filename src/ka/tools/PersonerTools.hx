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
		html += '<table class="personer" width="100%" border="0">';
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
			html += '<td valign="top">';
			html += '<p class="name">' + Tools.replaceNullString(person.efternamn) + ', ' + Tools.replaceNullString(person.fornamn) + '</p>';
			html += '</p>';
			html += '</td>';			
			html += '<td valign="top">';
			html += '<p>' + Tools.replaceNullString(person.personnr) + '</p>';
			html += '<p>' + Tools.replaceNullString(person.epost) + '</p>';
			html += '<p>' + Tools.replaceNullString(person.gatuadr) + ', ' + Tools.replaceNullString(person.postnr) + ' ' + Tools.replaceNullString(person.postadr) + '</p>';
			html += '</td>';

			html += '<td valign="top" align="right">';
			html += '<p class="expl" >Terminer:</p>';
			html += '<p class="expl" >Kör:</p>';
			html += '<p class="expl" >Roll:</p>';
			html += '<p class="expl" >Adm-grupp:</p>';
			html += '</td>';
			
			
			html += '<td valign="top">';
			html += '<p>' + Tools.replaceNullString(person.studieterminer.join(', ')) + '</p>';
			html += '<p>' + Tools.replaceNullString(person.kor) + '</p>';
			html += '<p>' + Tools.replaceNullString(person.roll) + '</p>';
			html += '<p>' + Tools.replaceNullString(person.admgrupp) + '</p>';
			html += '</td>';
			
			
			/*
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
			*/
			
			
			html += '</tr>';
		}
		html += '</table>';		
		html += '<style>';
		html += '.personer {font-family:"Arial"}' ;
		html += '.personer p {color:red; margin-bottom: 4px; margin-top:4px;}' ;
		html += '.personer p.name {color:blue; font-size:16pt; font-weight:bold; margin-bottom: 4px; margin-top:4px;}' ;
		html += '.personer p.expl {color:gray; margin-bottom: 4px; margin-top:4px;}' ;
		html += '.personer td {border-bottom:1px solid #ddd;}' ;
		html += '</style>';
		
		
		
		return html;		
	}
	
	
}