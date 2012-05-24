package ka.tools;
import cx.StrTools;
import cx.Tools;
import ka.types.Person;
import ka.types.Personer;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
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
			html += '<p class="name">' + person.efternamn.replaceNull() + ', ' + person.fornamn.replaceNull() + '</p>';
			html += '</p>';
			html += '</td>';			
			html += '<td valign="top">';
			html += '<p>' + person.personnr.replaceNull() + '</p>';
			html += '<p>' + person.epost.replaceNull() + '</p>';
			html += '<p>' + person.gatuadr.replaceNull() + ', ' + person.postnr.replaceNull() + ' ' + person.postadr.replaceNull() + '</p>';
			html += '</td>';

			html += '<td valign="top" align="right">';
			html += '<p class="expl" >Terminer:</p>';
			html += '<p class="expl" >Kör:</p>';
			html += '<p class="expl" >Roll:</p>';
			html += '<p class="expl" >Adm-grupp:</p>';
			html += '</td>';
			
			
			html += '<td valign="top">';
			html += '<p>' + person.studieterminer.join(', ') + '</p>';
			html += '<p>' + person.kor.replaceNull()  + '</p>';
			html += '<p>' + person.roll.replaceNull() + '</p>';
			html += '<p>' + person.admgrupp.replaceNull() + '</p>';
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