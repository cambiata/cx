package ka.tools;
import cx.ExcelTools;
import cx.RandomTools;
import cx.ValidationTools;
import ka.types.Avantifields;
import ka.types.Avantiperson;
import ka.types.Avantipersoner;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class AvantiTools 
{

	static public function nisse() {
		
	}
	
	static public function getAvantiersonNull() :Avantiperson
	{
		
		return {
			efternamn:'', 
			fornamn:'', 
			kursNr:'', 
			klass:'', 
			adress:'', 
			postnr:'', 
			ort:'', 
			personnr:'', 
			telefon:'', 
			mobil:'', 
			epost:'', 
			anhoriguppgift1:'', 
			anhoriguppgift2:'', 
			anteckningarBas:'', 
			pMBas:'', 
			ansokning:'', 
			antagning:'', 
			bekraftelse:'', 
			hemlan:'', 
			utbildningsbakgrund:'', 
			anteckningarKurs:'', 
			pMKurs:'', 
			specialkost:'',	
			
			//
		};
	}	
	
	static public function valideraAvantipersoner(personer:Avantipersoner) :Avantipersoner {
		
		var result:Avantipersoner = [];
		
		for (person in personer) {
			
			if (!ValidationTools.isValidPersonnrLong(person.personnr)) {
				trace('Invalid PERSONNUMMER');				
				trace(person);
				continue;
			}
			
			if (!ValidationTools.isValidEmail(person.epost)) {
				trace('Invalid EPOST');	
				trace(person);
				continue;				
			}
			
			if (!ValidationTools.isValidFornamn(person.fornamn)) {
				trace('Invalid FORNAMN');				
				trace(person);
				continue;				
			}

			if (!ValidationTools.isValidEfternamn(person.efternamn)) {
				trace('Invalid EFTERNAMN');				
				trace(person);
				continue;				
			}
			
			result.push(person);
		}
		
		return result;
	}	
	
	static public function avantipersonerTillExcel(personer:Avantipersoner, xlsFilename:String) {
		
		var now = Date.now();
		var dateString = now.toString().replace(' ', '_').replace(':', '-');
		var filename = xlsFilename + '.' + dateString + '.xls';
		
		ExcelTools.start(filename);
		
		var cell = 0;
		for (field in Avantifields.fields) {
			ExcelTools.writeString(0, cell, field);
			cell++;
		}
		
		var row = 1;
		for (person in personer){
			ExcelTools.writeString(row, 0	, person.efternamn);
			ExcelTools.writeString(row, 1	, person.fornamn);
			ExcelTools.writeString(row, 2	, person.kursNr);
			ExcelTools.writeString(row, 3	, person.klass);
			ExcelTools.writeString(row, 4	, person.adress);
			ExcelTools.writeString(row, 5	, person.postnr);
			ExcelTools.writeString(row, 6	, person.ort);
			ExcelTools.writeString(row, 7	, person.personnr);
			ExcelTools.writeString(row, 8	, person.telefon);
			ExcelTools.writeString(row, 9	, person.mobil);
			ExcelTools.writeString(row, 10	, person.epost);
			ExcelTools.writeString(row, 11	, person.anhoriguppgift1);
			ExcelTools.writeString(row, 12	, person.anhoriguppgift2);
			ExcelTools.writeString(row, 13	, person.anteckningarBas);
			ExcelTools.writeString(row, 14	, person.pMBas);
			ExcelTools.writeString(row, 15	, person.ansokning);
			ExcelTools.writeString(row, 16	, person.antagning);
			ExcelTools.writeString(row, 17	, person.bekraftelse);
			ExcelTools.writeString(row, 18	, person.hemlan);
			ExcelTools.writeString(row, 19	, person.utbildningsbakgrund);
			ExcelTools.writeString(row, 20	, person.anteckningarKurs);
			ExcelTools.writeString(row, 21	, person.pMKurs);
			ExcelTools.writeString(row, 22	, person.specialkost);			
			row++;
		}
		ExcelTools.finish();		
		
		
	}	
	
	
	/*
	static public function fejkgatuadress() {
		var pres = [
			'Lingon',
			'Blåbärs',
			'Hallon',
			'Svamp',
			'Kungs',
			'Drottning',
			'Regerings',
			'Fiol',
			'Cello',
			'Flöjt',
			'Mång',
			'Ingemans',
			'Vänd',
			'Återvänds',
			'Trång',
			'Bred',
			'Höjd',
			'Bergs',
			'Dal',
			'Norr',
			'Söder',
			'Väster',
			'Öster',
			'Mellan',
			'Bagar',
			'Sotar',
			'Stuvar',
			'Ren',
			'Älg',
			'Rip',
			'Tjäder',
			'Sparv',
			'Hök',
			'Järv',
			'Lo',
			'Varg',
			
		];

		var posts = [
			'vägen',
			'stigen',
			'gränd',
			'slingan',
			'avenyn',
			'allén',
			'svängen',
			'byn',
			'staden',
			'gården',
			'höjden',
			'byn',
		];

		var pre = RandomTools.fromArray(pres);
		var post = RandomTools.fromArray(posts);
		var nr = RandomTools.int(1, 30);
		var lgh = RandomTools.fromArray(['', '', '', '', '', '', '', '', ' A', ' B', ' C', ' D']);
		
		return pre + post + ' ' + nr + lgh;
		
	}
	
	static public function fejkpostadress(grupp:String) {
		
		var result = { postnr:'', postort:'' };
		
		switch (grupp) {
			case 'Domsjö Kyrkokör': 
				result.postnr = '892 00';
				result.postort = 'DOMSJÖ';
			case 'Gudmundrå Kyrkokör': 
				result.postnr = '872 00';
				result.postort = 'KRAMFORS';
			case 'KAK03': 
				result.postnr = '820 40';
				result.postort = 'JÄRVSÖ';
			case 'KAK04': 
				result.postnr = '710 41';
				result.postort = 'ARBOGA';
			case 'KAK05': 
				result.postnr = '360 30';
				result.postort = 'SÄVSJÖ';
			case 'KAK06': 
				result.postnr = '360 73';
				result.postort = 'LENHOVDA';
			case 'KAK07': 
				result.postnr = '650 12';
				result.postort = 'KARLSTAD';
			case 'KAK08': 
				result.postnr = '650 12';
				result.postort = 'KARLSTAD';			
			case 'KAK09': 
				result.postnr = '548 74';
				result.postort = 'ÖREBRO';
			default:
				throw 'Ej existerande kod: ' + kod;
		}
		
		return result;		
	}
	*/
	
	static public function personerAddFejk(personer:Avantipersoner)
	{
		for (person in personer) {
			
			/*
			person.adress = fejkgatuadress();
			var postadress = fejkpostadress(person.kursNr);
			person.postnr = postadress.postnr;
			person.ort = postadress.postort;
			*/	
			
			person.adress 	= '#ERROR';
			person.postnr 	= '#ERROR';
			person.ort 			= '#ERROR';
			
		}
	}
	
	static public function personerSorteraKursEfternamnFornamn(personer:Avantipersoner) {		
		personer.sort(function (a, b) {
			if (a.kursNr < b.kursNr) return -1;
			if (a.kursNr > b.kursNr) return 1;
			//------------------------------------------
			if (a.kursNr == b.kursNr) {
				if (a.efternamn < b.efternamn) return -1;
				if (a.efternamn > b.efternamn) return 1;
				if (a.efternamn == b.efternamn) {
					if (a.fornamn < b.fornamn) return -1;
					if (a.fornamn > b.fornamn) return 1;
				}
			}
			return 0;
		});
	}
	
	static public function personerSorteraEfternamnFornamn(personer:Avantipersoner) {		
		personer.sort(function (a, b) {
			if (a.efternamn < b.efternamn) return -1;
			if (a.efternamn > b.efternamn) return 1;
			if (a.efternamn == b.efternamn) {
				if (a.fornamn < b.fornamn) return -1;
				if (a.fornamn > b.fornamn) return 1;
			}
			return 0;
		});
	}

	static public function avantiExport() {
		
		var personer = AdminGdata.getAvantipersoner();		
		personer = AvantiTools.valideraAvantipersoner(personer);

		// Add #ERROR for adresses...
		AvantiTools.personerAddFejk(personer);
		
		// Sort KursNr, Efternamn, Förnamn
		AvantiTools.personerSorteraKursEfternamnFornamn(personer);		
		
		// Export
		AvantiTools.avantipersonerTillExcel(personer, 'kalle-avanti-erroradresser');	
		
		trace(personer.length);
	}
	
	
	
}