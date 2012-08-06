package nx.svg;

/**
 * ...
 * @author Jonas Nyström
 */

class NoteElements 
{

	static public function clefG():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
				d="m 95.72971,266.7949 c -5.57504,2.79274 -12.48498,4.1891 -20.72511,4.1891 -9.69981,0 -18.99938,-1.66998 -27.91049,-5.00757 -8.90876,-3.33996 -16.75807,-7.86163 -23.54558,-13.56975 -6.78751,-5.70339 -12.24248,-12.38094 -16.36254,-20.03029 -4.12007,-7.64934 -6.1801,-15.78458 -6.1801,-24.40572 0,-29.26234 20.72746,-61.31506 62.18472,-96.1605 -1.3349,-5.34251 -2.33313,-10.74399 -2.99941,-16.209153 -0.66627,-5.460449 -1.00058,-11.107236 -1.00058,-16.938007 0,-8.010226 0.66392,-15.871864 1.99646,-23.582532 1.3302,-7.710668 3.23955,-14.935434 5.72336,-21.674325 2.48617,-6.738864 5.54208,-12.869193 9.17715,-18.393316 3.63272,-5.5265031 7.814,-10.1708424 12.53677,-13.9306366 16.47555,22.8253826 24.71097,44.6247216 24.71097,65.3862176 0,13.480109 -3.18069,26.321 -9.54442,38.522682 -6.36138,12.20404 -16.32959,24.07079 -29.90225,35.60967 l 7.99763,38.42834 c 4.36256,-0.35616 6.78751,-0.53307 7.2725,-0.53307 6.05767,0 11.72453,1.09209 16.99586,3.27863 5.27368,2.18418 9.88109,5.18919 13.82693,9.01269 3.94349,3.82349 7.07003,8.34517 9.37727,13.56502 2.30488,5.21986 3.4585,10.86193 3.46085,16.93329 -0.002,4.36836 -0.78869,8.68011 -2.36374,12.92581 -1.57504,4.25042 -3.814,8.28856 -6.72159,12.10969 -2.90994,3.82586 -6.36373,7.34272 -10.36137,10.55766 -3.99764,3.21965 -8.42141,5.98172 -13.26896,8.28856 0,-0.24294 0.18129,0.45523 0.54385,2.09218 0.36492,1.63932 0.8193,3.79048 1.36315,6.46291 0.5462,2.67008 1.18187,5.64443 1.90935,8.92306 0.72749,3.27626 1.36316,6.43224 1.90936,9.46556 0.5462,3.03568 1.02884,5.73878 1.45497,8.10222 0.42378,2.37052 0.63567,3.97681 0.63567,4.82595 0,5.70576 -1.21248,10.92561 -3.63508,15.65957 -2.42495,4.73396 -5.69746,8.80041 -9.81988,12.19933 -4.12006,3.39656 -8.90875,6.03833 -14.36136,7.9206 -5.45497,1.88226 -11.21364,2.82339 -17.27602,2.82339 -4.60506,0 -8.90641,-0.72885 -12.90875,-2.18654 -4,-1.45769 -7.515,-3.52157 -10.54502,-6.18929 -3.02765,-2.67244 -5.422,-5.91568 -7.18068,-9.73918 -1.75632,-3.82113 -2.63449,-8.03853 -2.63449,-12.64984 0,-3.27862 0.54621,-6.37563 1.63626,-9.2863 1.09005,-2.91066 2.60623,-5.39912 4.54384,-7.463 1.93996,-2.06389 4.3037,-3.7032 7.09122,-4.91323 2.78987,-1.21474 5.81989,-1.82329 9.09004,-1.82329 2.90994,0 5.63625,0.66988 8.18127,2.00492 2.54502,1.33503 4.72748,3.06634 6.54502,5.18919 1.81754,2.12521 3.27251,4.5547 4.36491,7.2861 1.09005,2.72905 1.63626,5.49111 1.63626,8.28384 0,6.31431 -2.33314,11.4752 -7.00176,15.48267 -4.66627,4.00512 -10.51205,6.37328 -17.54441,7.09976 5.57504,2.79509 11.329,4.19146 17.2666,4.1891 4.8452,0.002 9.57268,-0.87745 14.17773,-2.64177 4.6027,-1.75961 8.62859,-4.12777 12.08474,-7.10212 3.45379,-2.97436 6.24131,-6.43932 8.3602,-10.38547 2.11889,-3.94614 3.18069,-8.16354 3.18069,-12.65692 0,-1.70299 -0.18365,-3.58526 -0.54385,-5.64914 L 95.72971,266.7949 z M 95.18821,27.488123 c -1.21483,-0.243068 -2.30724,-0.365597 -3.27486,-0.365597 -3.75986,0 -7.24661,1.912917 -10.46026,5.738777 -3.21365,3.823478 -6.00352,8.80275 -8.36726,14.933079 -2.36374,6.132684 -4.21188,13.022518 -5.54914,20.671856 -1.33254,7.649365 -2.00117,15.298698 -2.00117,22.948042 0,3.158334 0.12478,6.194011 0.36492,9.10704 0.24485,2.91538 0.67333,5.70811 1.2831,8.37819 24.73216,-21.976242 37.09942,-41.768292 37.09942,-59.373819 0,-8.378205 -3.03237,-15.723276 -9.09475,-22.037568 z m 3.814,231.850857 c 5.94467,-4.37072 10.46026,-9.16837 13.55619,-14.39058 3.09123,-5.21986 4.63802,-10.86429 4.63802,-16.93801 0,-3.76216 -0.63802,-7.4347 -1.91171,-11.01996 -1.27134,-3.57818 -3.08887,-6.76718 -5.45497,-9.56227 -2.36609,-2.78801 -5.18657,-5.03588 -8.46143,-6.7318 -3.27486,-1.69828 -6.85108,-2.54506 -10.72865,-2.54506 -0.24249,0 -0.72749,0.0307 -1.45497,0.0873 -0.72513,0.0613 -1.75633,0.15097 -3.08887,0.2689 l 12.90639,60.83151 z M 81.56374,199.26225 c -3.75749,0.48354 -7.2725,1.42468 -10.545,2.82104 -3.27251,1.39637 -6.08828,3.12767 -8.45202,5.19155 -2.36374,2.06389 -4.24249,4.43205 -5.63625,7.10212 -1.39376,2.67244 -2.09064,5.58546 -2.09064,8.7438 0,9.34762 4.96527,17.11962 14.88874,23.31127 -8.24013,-1.33503 -14.84636,-4.52167 -19.81634,-9.56227 -4.96997,-5.03823 -7.45378,-11.38084 -7.45378,-19.03255 0,-4.49101 0.93937,-8.83106 2.81812,-13.02016 1.87875,-4.18909 4.39317,-7.95598 7.54325,-11.30065 3.15479,-3.34703 6.85108,-6.23647 11.09121,-8.66595 4.24249,-2.43421 8.72748,-4.13721 13.45261,-5.10664 l -7.63507,-36.42579 c -17.08768,12.86684 -30.02468,25.49546 -38.81101,37.88112 -8.78633,12.38567 -13.1795,24.64868 -13.1795,36.79139 0,6.67755 1.48322,12.99421 4.45438,18.94292 2.97115,5.95106 6.9735,11.14026 12.00469,15.5723 5.03119,4.4344 10.85107,7.92531 17.45966,10.47274 6.60623,2.55214 13.60563,3.82821 20.9982,3.82821 4.24249,0 8.18127,-0.39627 11.81634,-1.18408 3.63743,-0.79017 7.03001,-2.03558 10.1801,-3.73386 L 81.56374,199.26225 z" />
				</g></svg>';
	}
	
	static public function noteBlack():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
				d = "m 20.557649,250.57631 c -5.81753,-0.002 -10.6650905,-1.36806 -14.5450105,-4.0971 -3.87756,-2.73612 -5.81516995,-6.6516 -5.81516995,-11.74881 0,-4.12777 1.30193995,-8.10458 3.90816995,-11.92807 2.60387,-3.82585 5.9069905,-7.19411 9.9070005,-10.1095 3.99998,-2.91302 8.452014,-5.24816 13.360774,-7.01013 4.90876,-1.7596 9.66448,-2.63941 14.2719,-2.63941 6.1801,0 11.17834,1.42467 14.99703,4.27637 3.81636,2.85406 5.72572,6.70821 5.72572,11.56483 0,4.00747 -1.30195,7.92295 -3.90817,11.7488 -2.60623,3.8235 -5.93761,7.19412 -9.99882,10.10714 -4.05885,2.91303 -8.54382,5.27883 -13.45258,7.10448 -4.90878,1.81858 -9.72573,2.72905 -14.450844,2.7314 z" />
				</g></svg>';		
	}	
	
	static public function noteWhite():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
				d="m -0.01820308,235.29885 c 0,-4.12777 1.15125988,-8.19421 3.45376988,-12.20168 2.30253,-4.00747 5.3325496,-7.55735 9.0900592,-10.65436 3.7575,-3.09701 7.96936,-5.58546 12.63565,-7.46772 4.66627,-1.88227 9.30428,-2.8234 13.90934,-2.8234 7.63741,0 13.69743,1.60865 18.18243,4.82831 4.48262,3.2173 6.72393,7.73898 6.72863,13.56739 -0.005,4.25042 -1.21482,8.25553 -3.63977,12.02006 -2.4226,3.76452 -5.57504,7.04315 -9.4526,9.83588 -3.87756,2.79037 -8.30134,5.00522 -13.27367,6.64689 -4.96763,1.63695 -10.06001,2.45779 -15.27249,2.46015 -6.18245,-0.002 -11.45615,-1.42939 -15.8186992,-4.28109 -4.36254,-2.85641 -6.54264988,-6.83322 -6.54264988,-11.93043 z M 49.439026,207.62158 c -1.93759,0 -4.39551,0.48589 -7.3643,1.45769 -2.97117,0.96944 -6.15186,2.2455 -9.54915,3.82113 -3.39257,1.57799 -6.75924,3.39893 -10.09297,5.46517 -3.33606,2.06388 -6.36843,4.18438 -9.09475,6.37091 -2.731,2.18182 -4.9417295,4.39902 -6.6391792,6.64453 -1.69512,2.24787 -2.54502,4.28109 -2.54738,6.10202 0.002,5.7034 3.4561299,8.55746 10.3684392,8.55746 3.27486,0 7.45849,-1.06143 12.55087,-3.18664 5.09241,-2.12285 10.0624,-4.73396 14.91464,-7.82861 4.84756,-3.097 9.03119,-6.34497 12.54619,-9.74153 3.51735,-3.40128 5.27603,-6.4346 5.27603,-9.10468 0,-5.7034 -3.45377,-8.55745 -10.36844,-8.55745 z" />
				</g></svg>';		
	}

	static public function noteWhole():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
				d="m 0.14197458,226.9183 c 0,-3.64187 1.21011002,-6.97946 3.63271012,-10.01514 2.4226,-3.03568 5.66217,-5.64679 9.7233503,-7.83569 4.0565,-2.18182 8.692204,-3.85179 13.899944,-5.00757 5.21012,-1.15106 10.54031,-1.72894 15.99057,-1.7313 5.09006,0.002 10.08827,0.64157 14.99232,1.91292 4.9064,1.27843 9.32782,3.00738 13.26661,5.19156 3.93643,2.18653 7.11712,4.76698 9.54208,7.74133 2.42025,2.97671 3.63271,6.22468 3.63271,9.74389 0,3.88718 -1.0312,7.34743 -3.08885,10.38311 -2.06004,3.03568 -4.99825,5.58546 -8.81461,7.64935 -3.81636,2.06388 -8.38843,3.67253 -13.71862,4.8283 -5.33019,1.15106 -11.26544,1.72895 -17.8081,1.73131 -5.81517,-0.002 -11.23482,-0.58025 -16.26603,-1.73131 -5.026479,-1.15577 -9.389044,-2.79508 -13.082984,-4.9203 -3.6962903,-2.12521 -6.6015203,-4.70565 -8.7204103,-7.73897 -2.1212401,-3.03568 -3.18069012,-6.43696 -3.18069012,-10.20149 z m 65.06407442,9.28158 c 0,-4.00511 -1.39376,-8.80276 -4.18363,-14.38822 -1.33254,-2.67007 -2.75691,-5.00757 -4.27074,-7.01248 -1.51618,-2.00256 -3.18305,-3.61121 -5.00057,-4.82595 -1.81754,-1.21239 -3.90817,-2.12522 -6.27193,-2.73141 -2.36373,-0.60619 -5.06179,-0.91047 -8.09181,-0.91047 -11.63506,0 -17.452602,4.675 -17.452602,14.02498 0,3.51922 0.696896,6.88984 2.090662,10.10714 1.39376,3.2173 3.24189,6.10202 5.54443,8.6518 2.30253,2.54978 4.84756,4.583 7.63508,6.09966 2.78751,1.51902 5.63859,2.27853 8.54853,2.27853 2.6651,0 5.17951,-0.12266 7.54324,-0.3656 2.36376,-0.24296 4.485,-0.72885 6.36375,-1.45769 1.8811,-0.72649 3.48674,-1.8516 4.81694,-3.36826 1.33489,-1.51666 2.24367,-3.55224 2.72865,-6.10203 z" />
				</g></svg>';		
	}
	
	static public function signNatural():String {
		return '<svg><g><path 
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline"
				d="m 27.763524,289.1105 0,-36.43051 -27.82574358,9.65191 0,-97.8116 4.52499988,0 0.0183,36.60977 27.8092637,-9.83589 0,97.81632 -4.52736,0 z m -23.3007437,-42.80378 23.3007437,-8.38055 -0.0157,-30.60209 -23.2842537,8.55981 0,30.42283 z" />	
				</g></svg>';		
	}
	
	static public function signSharp():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline"
				d="m 31.526296,208.23455 -17.48556,5.8284 0.0157,31.51021 17.46908,-5.82841 0,-31.5102 z m 4.52736,-43.89588 0.0131,26.0474 9.44083,-3.09464 0,16.5724 -9.4526,3.097 0,31.50785 9.4526,-3.09701 0,16.57476 -9.4526,3.09701 0,28.59482 -4.52736,0 0,-27.32111 -17.48556,5.82841 0,27.31875 -4.52736,0 0,-26.04268 -9.4526,3.09464 0,-16.57239 9.4526,-3.09701 -0.0131,-31.50785 -9.43847,3.09465 0,-16.5724 9.4526,-3.09701 0,-28.59482 4.52736,0 0.0157,27.32111 17.46908,-5.82841 0,-27.32347 4.52736,0 z" />	
				</g></svg>';		
	}
	
	static public function signFlat():String {
		return '<svg><g><path
				style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline"
				d="m 0.119631,150.69109 5.81283,0 -1.25721,57.37598 c 3.63742,-5.96993 9.26898,-8.95607 16.901689,-8.95371 2.66507,-0.002 5.23835,0.45287 7.72451,1.3657 2.48383,0.91046 4.63332,2.15823 6.45084,3.73622 1.8152,1.58034 3.27018,3.46025 4.36022,5.64914 1.09004,2.18654 1.63625,4.55234 1.63625,7.10684 -0.24254,3.52158 -1.54679,7.44178 -3.90817,11.75353 -2.36373,4.3141 -6.39435,8.53622 -12.08944,12.66399 l -25.631519,18.95235 0,-109.65004 z m 16.901689,55.71308 c -5.082969,0 -8.960559,2.55214 -11.620919,7.65407 -0.71102,6.92521 -1.06652,12.87863 -1.06652,17.86026 0,8.62586 0.29665,14.63825 0.88758,18.03953 2.30253,-1.45769 4.75337,-3.61121 7.35491,-6.46763 2.603867,-2.85641 4.991139,-5.89445 7.171249,-9.11175 2.17775,-3.21966 3.96469,-6.43696 5.35609,-9.65898 1.39141,-3.21966 2.08592,-6.04541 2.08827,-8.47254 -0.002,-2.79509 -0.96997,-5.13494 -2.90523,-7.0172 -1.93762,-1.88463 -4.35784,-2.82576 -7.26543,-2.82576 z" />
				</g></svg>';		
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	
	
	static public function pauseNv4():String {
		return 
		'
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="pausFjardedel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.90509668"
     inkscape:cx="332.02825"
     inkscape:cy="27517.578"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="stroke:none;fill:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     visibility="visible"
     id="page1"
     transform="matrix(0.03910046,0,0,0.03910046,5.6878036,-12.269993)"
     style="visibility:visible">
    <desc
       id="desc12">Slide</desc>
    <g
       id="g14">
      <desc
         id="desc16">Group</desc>
      <g
         id="g18">
        <desc
           id="desc20">Group</desc>
        <g
           id="g22">
          <desc
             id="desc24">Drawing</desc>
          <g
             id="g26">
            <g
               style="fill:#000000;stroke:none"
               id="g28">
              <path
                 d="m 1253,7028 c -144,-63 -280,-95 -407,-95 -122,0 -224,29 -308,89 -83,59 -124,144 -124,256 0,170 100,352 302,547 -6,19 -19,28 -38,29 -29,-1 -80,-24 -154,-70 C 450,7738 374,7677 294,7602 214,7527 144,7444 83,7355 22,7265 -8,7177 -8,7091 c 0,-70 11,-139 34,-206 22,-67 54,-127 95,-180 42,-53 92,-95 151,-127 59,-32 126,-48 199,-48 90,0 186,27 288,81 -38,-57 -80,-116 -125,-175 -44,-59 -96,-124 -156,-194 -59,-70 -126,-150 -201,-238 -75,-88 -159,-189 -251,-304 329,-301 493,-576 493,-826 0,-64 -18,-135 -55,-213 -37,-79 -77,-152 -120,-221 -43,-69 -83,-125 -120,-170 -36,-45 -55,-67 -55,-67 0,-32 27,-53 82,-63 l 854,1171 c -301,361 -451,627 -451,796 0,64 22,133 67,206 45,74 98,151 161,231 62,80 127,160 196,242 69,82 127,162 175,242 z"
                 id="path30"
                 inkscape:connector-curvature="0" />
            </g>
            <g
               style="fill:none;stroke:none"
               id="g32">
              <rect
                 x="-8"
                 y="4140"
                 width="1263"
                 height="3715"
                 id="rect34" />
            </g>
            <g
               id="g36" />
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>



';
	}
	
	
	
	static public function pauseNv8():String {
		return 
		'
 
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="pausAttondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.90509668"
     inkscape:cx="132.50909"
     inkscape:cy="27753.591"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-100,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <flowRoot
     xml:space="preserve"
     id="flowRoot2999"
     style="font-size:40px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Myriad Pro;-inkscape-font-specification:Myriad Pro"
     transform="translate(-100,0)"><flowRegion
       id="flowRegion3001"><rect
         id="rect3003"
         width="1096.875"
         height="940.625"
         x="118.75"
         y="703.375" /></flowRegion><flowPara
       id="flowPara3005" /></flowRoot>  <g
     style="fill-rule:evenodd"
     id="g3105"
     transform="matrix(0.03118678,0,0,0.03118678,9.2648369,24.734188)">
    <g
       id="Default-1"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3010">Master slide</desc>
      <g
         id="g3012"
         style="fill:none;stroke:none">
        <rect
           id="rect3014"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-7"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3017">Slide</desc>
      <g
         id="g3019">
        <desc
           id="desc3021">Group</desc>
        <g
           id="g3023">
          <desc
             id="desc3025">Group</desc>
          <g
             id="g3027">
            <desc
               id="desc3029">Group</desc>
            <g
               id="g3031">
              <desc
                 id="desc3033">Drawing</desc>
              <g
                 id="g3035">
                <g
                   id="g3037"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3039"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3041" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3043">
          <desc
             id="desc3045">Group</desc>
          <g
             id="g3047">
            <desc
               id="desc3049">Group</desc>
            <g
               id="g3051">
              <desc
                 id="desc3053">Group</desc>
              <g
                 id="g3055">
                <desc
                   id="desc3057">Group</desc>
                <g
                   id="g3059">
                  <desc
                     id="desc3061">Drawing</desc>
                  <g
                     id="g3063">
                    <g
                       id="g3065"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3067"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3069" />
                  </g>
                </g>
              </g>
              <g
                 id="g3071">
                <desc
                   id="desc3073">Group</desc>
                <g
                   id="g3075">
                  <desc
                     id="desc3077">Group</desc>
                  <g
                     id="g3079">
                    <desc
                       id="desc3081">Group</desc>
                    <g
                       id="g3083">
                      <desc
                         id="desc3085">Drawing</desc>
                      <g
                         id="g3087">
                        <g
                           id="g3089"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3091"
                             d="m 591,7765 -215,0 819,-1802 c -273,89 -493,133 -660,133 -317,0 -476,-124 -476,-373 0,-75 38,-138 113,-187 75,-50 155,-74 240,-74 195,0 292,83 292,250 0,79 -28,168 -82,266 14,11 36,16 66,16 226,0 468,-114 727,-343 L 591,7765 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3093"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3095"
                             height="2306"
                             width="1358"
                             y="5461"
                             x="59" />
                        </g>
                        <g
                           id="g3097" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>



		
		
		
		';
	}
	
	static public function pauseNv16():String {
		return 
		'
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="pausSextondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.90509668"
     inkscape:cx="132.50909"
     inkscape:cy="27561.739"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-100,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <flowRoot
     xml:space="preserve"
     id="flowRoot2999"
     style="font-size:40px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Myriad Pro;-inkscape-font-specification:Myriad Pro"
     transform="translate(-100,0)"><flowRegion
       id="flowRegion3001"><rect
         id="rect3003"
         width="1096.875"
         height="940.625"
         x="118.75"
         y="703.375" /></flowRegion><flowPara
       id="flowPara3005" /></flowRoot>  <g
     style="fill-rule:evenodd"
     id="g3251"
     transform="matrix(0.02912614,0,0,0.03232438,5.1969064,17.463769)">
    <g
       id="Default-4"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3156">Master slide</desc>
      <g
         id="g3158"
         style="fill:none;stroke:none">
        <rect
           id="rect3160"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-0"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3163">Slide</desc>
      <g
         id="g3165">
        <desc
           id="desc3167">Group</desc>
        <g
           id="g3169">
          <desc
             id="desc3171">Group</desc>
          <g
             id="g3173">
            <desc
               id="desc3175">Group</desc>
            <g
               id="g3177">
              <desc
                 id="desc3179">Drawing</desc>
              <g
                 id="g3181">
                <g
                   id="g3183"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3185"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3187" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3189">
          <desc
             id="desc3191">Group</desc>
          <g
             id="g3193">
            <desc
               id="desc3195">Group</desc>
            <g
               id="g3197">
              <desc
                 id="desc3199">Group</desc>
              <g
                 id="g3201">
                <desc
                   id="desc3203">Group</desc>
                <g
                   id="g3205">
                  <desc
                     id="desc3207">Drawing</desc>
                  <g
                     id="g3209">
                    <g
                       id="g3211"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3213"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3215" />
                  </g>
                </g>
              </g>
              <g
                 id="g3217">
                <desc
                   id="desc3219">Group</desc>
                <g
                   id="g3221">
                  <desc
                     id="desc3223">Group</desc>
                  <g
                     id="g3225">
                    <desc
                       id="desc3227">Group</desc>
                    <g
                       id="g3229">
                      <desc
                         id="desc3231">Drawing</desc>
                      <g
                         id="g3233">
                        <g
                           id="g3235"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3237"
                             d="m 617,8917 -236,0 747,-1679 c -194,85 -392,127 -593,127 -314,0 -471,-117 -471,-353 0,-85 39,-154 118,-207 78,-53 167,-79 266,-79 191,0 286,80 286,240 0,75 -25,161 -76,256 17,4 36,5 56,5 20,0 39,0 56,0 62,0 200,-39 415,-117 l 522,-1162 c -236,86 -447,128 -635,128 -321,0 -481,-109 -481,-327 0,-93 36,-166 108,-220 71,-55 155,-82 250,-82 185,0 277,83 277,250 0,82 -26,171 -77,267 34,6 63,10 87,10 140,0 375,-114 706,-343 L 617,8917 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3239"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3241"
                             height="3473"
                             width="1880"
                             y="5446"
                             x="64" />
                        </g>
                        <g
                           id="g3243" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>


		
		
		
		
		';
	}
	
	/*
	
	static public function flaggor():String {
		return '
		
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="flaggor.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.64"
     inkscape:cx="761.74"
     inkscape:cy="27390.999"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="stroke:none;fill:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     visibility="visible"
     id="page1"
     transform="matrix(0.03910046,0,0,0.03910046,5.6878036,-12.269993)"
     style="visibility:visible">
    <desc
       id="desc12">Slide</desc>
    <g
       id="g14">
      <desc
         id="desc16">Group</desc>
      <g
         id="g18">
        <desc
           id="desc20">Group</desc>
        <g
           id="g22">
          <desc
             id="desc24">Drawing</desc>
          <g
             id="g26">
            <g
               style="fill:#000000;stroke:none"
               id="g28">
              <path
                 d="m 1253,7028 c -144,-63 -280,-95 -407,-95 -122,0 -224,29 -308,89 -83,59 -124,144 -124,256 0,170 100,352 302,547 -6,19 -19,28 -38,29 -29,-1 -80,-24 -154,-70 C 450,7738 374,7677 294,7602 214,7527 144,7444 83,7355 22,7265 -8,7177 -8,7091 c 0,-70 11,-139 34,-206 22,-67 54,-127 95,-180 42,-53 92,-95 151,-127 59,-32 126,-48 199,-48 90,0 186,27 288,81 -38,-57 -80,-116 -125,-175 -44,-59 -96,-124 -156,-194 -59,-70 -126,-150 -201,-238 -75,-88 -159,-189 -251,-304 329,-301 493,-576 493,-826 0,-64 -18,-135 -55,-213 -37,-79 -77,-152 -120,-221 -43,-69 -83,-125 -120,-170 -36,-45 -55,-67 -55,-67 0,-32 27,-53 82,-63 l 854,1171 c -301,361 -451,627 -451,796 0,64 22,133 67,206 45,74 98,151 161,231 62,80 127,160 196,242 69,82 127,162 175,242 z"
                 id="path30"
                 inkscape:connector-curvature="0" />
            </g>
            <g
               style="fill:none;stroke:none"
               id="g32">
              <rect
                 x="-8"
                 y="4140"
                 width="1263"
                 height="3715"
                 id="rect34" />
            </g>
            <g
               id="g36" />
          </g>
        </g>
      </g>
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3097"
     transform="matrix(0.03305148,0,0,0.03305148,102.70057,15.922)">
    <g
       id="Default-1"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3002">Master slide</desc>
      <g
         id="g3004"
         style="fill:none;stroke:none">
        <rect
           id="rect3006"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-7"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3009">Slide</desc>
      <g
         id="g3011">
        <desc
           id="desc3013">Group</desc>
        <g
           id="g3015">
          <desc
             id="desc3017">Group</desc>
          <g
             id="g3019">
            <desc
               id="desc3021">Group</desc>
            <g
               id="g3023">
              <desc
                 id="desc3025">Drawing</desc>
              <g
                 id="g3027">
                <g
                   id="g3029"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3031"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3033" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3035">
          <desc
             id="desc3037">Group</desc>
          <g
             id="g3039">
            <desc
               id="desc3041">Group</desc>
            <g
               id="g3043">
              <desc
                 id="desc3045">Group</desc>
              <g
                 id="g3047">
                <desc
                   id="desc3049">Group</desc>
                <g
                   id="g3051">
                  <desc
                     id="desc3053">Drawing</desc>
                  <g
                     id="g3055">
                    <g
                       id="g3057"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3059"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3061" />
                  </g>
                </g>
              </g>
              <g
                 id="g3063">
                <desc
                   id="desc3065">Group</desc>
                <g
                   id="g3067">
                  <desc
                     id="desc3069">Group</desc>
                  <g
                     id="g3071">
                    <desc
                       id="desc3073">Group</desc>
                    <g
                       id="g3075">
                      <desc
                         id="desc3077">Drawing</desc>
                      <g
                         id="g3079">
                        <g
                           id="g3081"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3083"
                             d="m 110,5212 c 48,0 70,1 67,5 -4,7 -5,20 -5,41 0,20 1,35 5,46 153,406 341,750 563,1033 276,348 435,556 476,625 123,194 185,402 185,624 l 0,26 c 0,163 -14,308 -41,435 -28,126 -60,231 -96,317 -36,85 -71,150 -105,194 -34,45 -58,67 -71,67 -28,0 -41,-14 -41,-41 0,-17 10,-50 30,-97 35,-75 61,-137 80,-185 19,-47 32,-98 41,-151 8,-52 14,-113 18,-181 3,-68 6,-161 10,-277 l 0,-25 c 0,-355 -208,-679 -624,-972 -38,-28 -73,-53 -105,-77 -33,-24 -67,-45 -103,-64 -35,-19 -76,-34 -120,-46 -44,-12 -99,-18 -164,-18 l 0,-1279 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3085"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3087"
                             height="3415"
                             width="1292"
                             y="5211"
                             x="110" />
                        </g>
                        <g
                           id="g3089" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3243"
     transform="matrix(0.03305148,0,0,0.03305148,165.60197,15.922)">
    <g
       id="Default-4"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3148">Master slide</desc>
      <g
         id="g3150"
         style="fill:none;stroke:none">
        <rect
           id="rect3152"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-0"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3155">Slide</desc>
      <g
         id="g3157">
        <desc
           id="desc3159">Group</desc>
        <g
           id="g3161">
          <desc
             id="desc3163">Group</desc>
          <g
             id="g3165">
            <desc
               id="desc3167">Group</desc>
            <g
               id="g3169">
              <desc
                 id="desc3171">Drawing</desc>
              <g
                 id="g3173">
                <g
                   id="g3175"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3177"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3179" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3181">
          <desc
             id="desc3183">Group</desc>
          <g
             id="g3185">
            <desc
               id="desc3187">Group</desc>
            <g
               id="g3189">
              <desc
                 id="desc3191">Group</desc>
              <g
                 id="g3193">
                <desc
                   id="desc3195">Group</desc>
                <g
                   id="g3197">
                  <desc
                     id="desc3199">Drawing</desc>
                  <g
                     id="g3201">
                    <g
                       id="g3203"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3205"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3207" />
                  </g>
                </g>
              </g>
              <g
                 id="g3209">
                <desc
                   id="desc3211">Group</desc>
                <g
                   id="g3213">
                  <desc
                     id="desc3215">Group</desc>
                  <g
                     id="g3217">
                    <desc
                       id="desc3219">Group</desc>
                    <g
                       id="g3221">
                      <desc
                         id="desc3223">Drawing</desc>
                      <g
                         id="g3225">
                        <g
                           id="g3227"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3229"
                             d="m 1189,9127 c -27,0 -41,-14 -41,-41 0,-20 6,-55 16,-105 10,-49 22,-105 36,-166 13,-62 25,-123 35,-185 11,-61 16,-115 16,-163 -4,-62 -14,-117 -31,-167 -17,-49 -49,-102 -95,-158 -46,-57 -110,-121 -194,-192 -84,-72 -194,-161 -330,-266 -65,-51 -119,-92 -161,-121 -43,-29 -80,-51 -113,-66 -32,-15 -65,-25 -100,-28 -34,-4 -73,-5 -117,-5 l 0,-2252 15,0 c 21,0 32,7 36,23 3,15 8,38 15,69 89,331 278,674 568,1029 75,102 156,200 243,294 87,94 170,193 248,299 79,103 136,219 172,348 36,130 54,260 54,389 0,191 -27,341 -82,451 17,44 30,95 39,153 8,58 14,126 18,205 l 0,25 c 0,48 -8,108 -23,180 -16,71 -36,140 -62,207 -26,66 -53,124 -82,171 -29,48 -56,72 -80,72 z m 97,-1382 c 0,-232 -68,-431 -205,-599 -7,-7 -39,-39 -97,-97 -58,-58 -128,-122 -210,-192 -82,-70 -168,-137 -258,-202 -91,-65 -168,-107 -233,-128 65,147 135,284 210,412 75,128 157,247 245,356 11,13 40,43 90,89 49,46 104,100 164,162 59,61 117,122 174,184 56,61 94,114 115,158 3,-27 5,-52 5,-74 0,-22 0,-45 0,-69 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3231"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3233"
                             height="3917"
                             width="1353"
                             y="5211"
                             x="109" />
                        </g>
                        <g
                           id="g3235" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3389"
     transform="matrix(0.03305148,0,0,0.03305148,228.50337,15.922)">
    <g
       id="Default-9"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3294">Master slide</desc>
      <g
         id="g3296"
         style="fill:none;stroke:none">
        <rect
           id="rect3298"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-4"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3301">Slide</desc>
      <g
         id="g3303">
        <desc
           id="desc3305">Group</desc>
        <g
           id="g3307">
          <desc
             id="desc3309">Group</desc>
          <g
             id="g3311">
            <desc
               id="desc3313">Group</desc>
            <g
               id="g3315">
              <desc
                 id="desc3317">Drawing</desc>
              <g
                 id="g3319">
                <g
                   id="g3321"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3323"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3325" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3327">
          <desc
             id="desc3329">Group</desc>
          <g
             id="g3331">
            <desc
               id="desc3333">Group</desc>
            <g
               id="g3335">
              <desc
                 id="desc3337">Group</desc>
              <g
                 id="g3339">
                <desc
                   id="desc3341">Group</desc>
                <g
                   id="g3343">
                  <desc
                     id="desc3345">Drawing</desc>
                  <g
                     id="g3347">
                    <g
                       id="g3349"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3351"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3353" />
                  </g>
                </g>
              </g>
              <g
                 id="g3355">
                <desc
                   id="desc3357">Group</desc>
                <g
                   id="g3359">
                  <desc
                     id="desc3361">Group</desc>
                  <g
                     id="g3363">
                    <desc
                       id="desc3365">Group</desc>
                    <g
                       id="g3367">
                      <desc
                         id="desc3369">Drawing</desc>
                      <g
                         id="g3371">
                        <g
                           id="g3373"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3375"
                             d="m 110,6491 c 55,0 99,-2 133,-5 34,-3 69,-14 105,-31 36,-17 78,-42 125,-77 48,-34 111,-83 190,-148 249,-198 397,-321 445,-368 225,-253 338,-534 338,-845 0,-225 -89,-503 -266,-834 -21,-34 -31,-66 -31,-97 0,-31 7,-46 20,-46 31,0 66,27 105,82 39,54 78,122 115,202 38,80 72,164 103,251 31,87 55,163 72,227 34,133 52,270 52,410 0,129 -24,261 -72,394 -49,133 -122,259 -221,379 -96,112 -194,221 -294,327 -101,106 -197,215 -289,328 -113,139 -215,296 -308,470 -92,174 -177,362 -255,563 -4,10 -5,26 -5,46 0,21 1,34 5,41 3,4 -19,5 -67,5 l 0,-1274 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3377"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3379"
                             height="3728"
                             width="1507"
                             y="4039"
                             x="110" />
                        </g>
                        <g
                           id="g3381" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3535"
     transform="matrix(0.03305148,0,0,0.03305148,291.40476,15.922)">
    <g
       id="Default-8"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3440">Master slide</desc>
      <g
         id="g3442"
         style="fill:none;stroke:none">
        <rect
           id="rect3444"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-8"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3447">Slide</desc>
      <g
         id="g3449">
        <desc
           id="desc3451">Group</desc>
        <g
           id="g3453">
          <desc
             id="desc3455">Group</desc>
          <g
             id="g3457">
            <desc
               id="desc3459">Group</desc>
            <g
               id="g3461">
              <desc
                 id="desc3463">Drawing</desc>
              <g
                 id="g3465">
                <g
                   id="g3467"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3469"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3471" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3473">
          <desc
             id="desc3475">Group</desc>
          <g
             id="g3477">
            <desc
               id="desc3479">Group</desc>
            <g
               id="g3481">
              <desc
                 id="desc3483">Group</desc>
              <g
                 id="g3485">
                <desc
                   id="desc3487">Group</desc>
                <g
                   id="g3489">
                  <desc
                     id="desc3491">Drawing</desc>
                  <g
                     id="g3493">
                    <g
                       id="g3495"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3497"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3499" />
                  </g>
                </g>
              </g>
              <g
                 id="g3501">
                <desc
                   id="desc3503">Group</desc>
                <g
                   id="g3505">
                  <desc
                     id="desc3507">Group</desc>
                  <g
                     id="g3509">
                    <desc
                       id="desc3511">Group</desc>
                    <g
                       id="g3513">
                      <desc
                         id="desc3515">Drawing</desc>
                      <g
                         id="g3517">
                        <g
                           id="g3519"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3521"
                             d="m 1581,4398 c 0,136 -16,257 -46,363 54,109 81,259 81,450 0,133 -24,267 -72,402 -47,135 -122,262 -224,381 -96,110 -194,216 -295,320 -100,104 -195,213 -284,325 -122,154 -230,317 -322,489 -92,172 -172,354 -240,545 -4,10 -6,26 -6,46 0,21 2,34 6,41 0,4 -23,5 -67,5 l 0,-2252 c 102,0 211,-26 325,-79 114,-53 221,-113 320,-179 99,-67 185,-132 258,-197 74,-65 120,-111 141,-138 157,-178 235,-378 235,-599 0,-191 -53,-405 -158,-640 -21,-44 -31,-77 -31,-97 0,-28 14,-41 41,-41 44,0 87,39 128,117 41,79 77,169 107,269 31,101 56,197 74,289 19,92 29,152 29,180 z m -140,731 c 0,-17 0,-36 0,-58 0,-23 -2,-51 -5,-85 -21,44 -66,101 -136,169 -70,68 -143,138 -220,210 -77,71 -148,136 -215,194 -66,58 -108,99 -125,123 -184,242 -336,498 -456,768 41,-14 88,-36 141,-67 53,-30 112,-73 177,-128 167,-143 297,-254 391,-332 94,-79 151,-130 172,-154 184,-198 276,-411 276,-640 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3523"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3525"
                             height="4225"
                             width="1505"
                             y="3542"
                             x="112" />
                        </g>
                        <g
                           id="g3527" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>
		
		
		
		
		';
	}
	
	*/
	static public function flagUp8():String {
		return '

<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="flagga-upp-attondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.64"
     inkscape:cx="761.74"
     inkscape:cy="27390.999"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-96,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3097"
     transform="matrix(0.03305148,0,0,0.03305148,6.70057,15.922)">
    <g
       id="Default-1"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3002">Master slide</desc>
      <g
         id="g3004"
         style="fill:none;stroke:none">
        <rect
           id="rect3006"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-7"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3009">Slide</desc>
      <g
         id="g3011">
        <desc
           id="desc3013">Group</desc>
        <g
           id="g3015">
          <desc
             id="desc3017">Group</desc>
          <g
             id="g3019">
            <desc
               id="desc3021">Group</desc>
            <g
               id="g3023">
              <desc
                 id="desc3025">Drawing</desc>
              <g
                 id="g3027">
                <g
                   id="g3029"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3031"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3033" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3035">
          <desc
             id="desc3037">Group</desc>
          <g
             id="g3039">
            <desc
               id="desc3041">Group</desc>
            <g
               id="g3043">
              <desc
                 id="desc3045">Group</desc>
              <g
                 id="g3047">
                <desc
                   id="desc3049">Group</desc>
                <g
                   id="g3051">
                  <desc
                     id="desc3053">Drawing</desc>
                  <g
                     id="g3055">
                    <g
                       id="g3057"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3059"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3061" />
                  </g>
                </g>
              </g>
              <g
                 id="g3063">
                <desc
                   id="desc3065">Group</desc>
                <g
                   id="g3067">
                  <desc
                     id="desc3069">Group</desc>
                  <g
                     id="g3071">
                    <desc
                       id="desc3073">Group</desc>
                    <g
                       id="g3075">
                      <desc
                         id="desc3077">Drawing</desc>
                      <g
                         id="g3079">
                        <g
                           id="g3081"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3083"
                             d="m 110,5212 c 48,0 70,1 67,5 -4,7 -5,20 -5,41 0,20 1,35 5,46 153,406 341,750 563,1033 276,348 435,556 476,625 123,194 185,402 185,624 l 0,26 c 0,163 -14,308 -41,435 -28,126 -60,231 -96,317 -36,85 -71,150 -105,194 -34,45 -58,67 -71,67 -28,0 -41,-14 -41,-41 0,-17 10,-50 30,-97 35,-75 61,-137 80,-185 19,-47 32,-98 41,-151 8,-52 14,-113 18,-181 3,-68 6,-161 10,-277 l 0,-25 c 0,-355 -208,-679 -624,-972 -38,-28 -73,-53 -105,-77 -33,-24 -67,-45 -103,-64 -35,-19 -76,-34 -120,-46 -44,-12 -99,-18 -164,-18 l 0,-1279 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3085"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3087"
                             height="3415"
                             width="1292"
                             y="5211"
                             x="110" />
                        </g>
                        <g
                           id="g3089" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>
		
		
		
		';
	}

	static public function flagUp16():String {
		return '
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="flagga-upp-attondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.64"
     inkscape:cx="761.74"
     inkscape:cy="27390.999"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-158,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3243"
     transform="matrix(0.03305148,0,0,0.03305148,7.60197,15.922)">
    <g
       id="Default-4"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3148">Master slide</desc>
      <g
         id="g3150"
         style="fill:none;stroke:none">
        <rect
           id="rect3152"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-0"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3155">Slide</desc>
      <g
         id="g3157">
        <desc
           id="desc3159">Group</desc>
        <g
           id="g3161">
          <desc
             id="desc3163">Group</desc>
          <g
             id="g3165">
            <desc
               id="desc3167">Group</desc>
            <g
               id="g3169">
              <desc
                 id="desc3171">Drawing</desc>
              <g
                 id="g3173">
                <g
                   id="g3175"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3177"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3179" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3181">
          <desc
             id="desc3183">Group</desc>
          <g
             id="g3185">
            <desc
               id="desc3187">Group</desc>
            <g
               id="g3189">
              <desc
                 id="desc3191">Group</desc>
              <g
                 id="g3193">
                <desc
                   id="desc3195">Group</desc>
                <g
                   id="g3197">
                  <desc
                     id="desc3199">Drawing</desc>
                  <g
                     id="g3201">
                    <g
                       id="g3203"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3205"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3207" />
                  </g>
                </g>
              </g>
              <g
                 id="g3209">
                <desc
                   id="desc3211">Group</desc>
                <g
                   id="g3213">
                  <desc
                     id="desc3215">Group</desc>
                  <g
                     id="g3217">
                    <desc
                       id="desc3219">Group</desc>
                    <g
                       id="g3221">
                      <desc
                         id="desc3223">Drawing</desc>
                      <g
                         id="g3225">
                        <g
                           id="g3227"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3229"
                             d="m 1189,9127 c -27,0 -41,-14 -41,-41 0,-20 6,-55 16,-105 10,-49 22,-105 36,-166 13,-62 25,-123 35,-185 11,-61 16,-115 16,-163 -4,-62 -14,-117 -31,-167 -17,-49 -49,-102 -95,-158 -46,-57 -110,-121 -194,-192 -84,-72 -194,-161 -330,-266 -65,-51 -119,-92 -161,-121 -43,-29 -80,-51 -113,-66 -32,-15 -65,-25 -100,-28 -34,-4 -73,-5 -117,-5 l 0,-2252 15,0 c 21,0 32,7 36,23 3,15 8,38 15,69 89,331 278,674 568,1029 75,102 156,200 243,294 87,94 170,193 248,299 79,103 136,219 172,348 36,130 54,260 54,389 0,191 -27,341 -82,451 17,44 30,95 39,153 8,58 14,126 18,205 l 0,25 c 0,48 -8,108 -23,180 -16,71 -36,140 -62,207 -26,66 -53,124 -82,171 -29,48 -56,72 -80,72 z m 97,-1382 c 0,-232 -68,-431 -205,-599 -7,-7 -39,-39 -97,-97 -58,-58 -128,-122 -210,-192 -82,-70 -168,-137 -258,-202 -91,-65 -168,-107 -233,-128 65,147 135,284 210,412 75,128 157,247 245,356 11,13 40,43 90,89 49,46 104,100 164,162 59,61 117,122 174,184 56,61 94,114 115,158 3,-27 5,-52 5,-74 0,-22 0,-45 0,-69 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3231"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3233"
                             height="3917"
                             width="1353"
                             y="5211"
                             x="109" />
                        </g>
                        <g
                           id="g3235" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>
		
		
		
		';
	}
	
	static public function flagDown8():String {
		return '
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="flagga-upp-sextondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.64"
     inkscape:cx="761.74"
     inkscape:cy="27390.999"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-158,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3389"
     transform="matrix(0.03305148,0,0,0.03305148,6.50337,15.922)">
    <g
       id="Default-9"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3294">Master slide</desc>
      <g
         id="g3296"
         style="fill:none;stroke:none">
        <rect
           id="rect3298"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-4"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3301">Slide</desc>
      <g
         id="g3303">
        <desc
           id="desc3305">Group</desc>
        <g
           id="g3307">
          <desc
             id="desc3309">Group</desc>
          <g
             id="g3311">
            <desc
               id="desc3313">Group</desc>
            <g
               id="g3315">
              <desc
                 id="desc3317">Drawing</desc>
              <g
                 id="g3319">
                <g
                   id="g3321"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3323"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3325" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3327">
          <desc
             id="desc3329">Group</desc>
          <g
             id="g3331">
            <desc
               id="desc3333">Group</desc>
            <g
               id="g3335">
              <desc
                 id="desc3337">Group</desc>
              <g
                 id="g3339">
                <desc
                   id="desc3341">Group</desc>
                <g
                   id="g3343">
                  <desc
                     id="desc3345">Drawing</desc>
                  <g
                     id="g3347">
                    <g
                       id="g3349"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3351"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3353" />
                  </g>
                </g>
              </g>
              <g
                 id="g3355">
                <desc
                   id="desc3357">Group</desc>
                <g
                   id="g3359">
                  <desc
                     id="desc3361">Group</desc>
                  <g
                     id="g3363">
                    <desc
                       id="desc3365">Group</desc>
                    <g
                       id="g3367">
                      <desc
                         id="desc3369">Drawing</desc>
                      <g
                         id="g3371">
                        <g
                           id="g3373"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3375"
                             d="m 110,6491 c 55,0 99,-2 133,-5 34,-3 69,-14 105,-31 36,-17 78,-42 125,-77 48,-34 111,-83 190,-148 249,-198 397,-321 445,-368 225,-253 338,-534 338,-845 0,-225 -89,-503 -266,-834 -21,-34 -31,-66 -31,-97 0,-31 7,-46 20,-46 31,0 66,27 105,82 39,54 78,122 115,202 38,80 72,164 103,251 31,87 55,163 72,227 34,133 52,270 52,410 0,129 -24,261 -72,394 -49,133 -122,259 -221,379 -96,112 -194,221 -294,327 -101,106 -197,215 -289,328 -113,139 -215,296 -308,470 -92,174 -177,362 -255,563 -4,10 -5,26 -5,46 0,21 1,34 5,41 3,4 -19,5 -67,5 l 0,-1274 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3377"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3379"
                             height="3728"
                             width="1507"
                             y="4039"
                             x="110" />
                        </g>
                        <g
                           id="g3381" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>
		
		
		
		';
	}
	
	static public function flagDown16():String {
		return '
		
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   viewBox="0 0 19687 27844"
   preserveAspectRatio="xMidYMid"
   fill-rule="evenodd"
   id="svg2"
   inkscape:version="0.48.0 r9654"
   width="100%"
   height="100%"
   sodipodi:docname="flagga-ned-attondel.svg">
  <metadata
     id="metadata42">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs40" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1680"
     inkscape:window-height="1024"
     id="namedview38"
     showgrid="false"
     inkscape:zoom="0.64"
     inkscape:cx="761.74"
     inkscape:cy="27390.999"
     inkscape:window-x="1676"
     inkscape:window-y="-4"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2" />
  <g
     visibility="visible"
     id="Default"
     transform="translate(-158,0)"
     style="visibility:visible">
    <desc
       id="desc5">Master slide</desc>
    <g
       style="fill:none;stroke:none"
       id="g7">
      <rect
         x="0"
         y="0"
         width="19687"
         height="27844"
         id="rect9" />
    </g>
  </g>
  <g
     style="fill-rule:evenodd"
     id="g3535"
     transform="matrix(0.03305148,0,0,0.03305148,7.40476,15.922)">
    <g
       id="Default-8"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3440">Master slide</desc>
      <g
         id="g3442"
         style="fill:none;stroke:none">
        <rect
           id="rect3444"
           height="29700"
           width="21000"
           y="0"
           x="0" />
      </g>
    </g>
    <g
       id="page1-8"
       visibility="visible"
       style="visibility:visible">
      <desc
         id="desc3447">Slide</desc>
      <g
         id="g3449">
        <desc
           id="desc3451">Group</desc>
        <g
           id="g3453">
          <desc
             id="desc3455">Group</desc>
          <g
             id="g3457">
            <desc
               id="desc3459">Group</desc>
            <g
               id="g3461">
              <desc
                 id="desc3463">Drawing</desc>
              <g
                 id="g3465">
                <g
                   id="g3467"
                   style="fill:none;stroke:none">
                  <rect
                     id="rect3469"
                     height="29701"
                     width="21000"
                     y="0"
                     x="0" />
                </g>
                <g
                   id="g3471" />
              </g>
            </g>
          </g>
        </g>
        <g
           id="g3473">
          <desc
             id="desc3475">Group</desc>
          <g
             id="g3477">
            <desc
               id="desc3479">Group</desc>
            <g
               id="g3481">
              <desc
                 id="desc3483">Group</desc>
              <g
                 id="g3485">
                <desc
                   id="desc3487">Group</desc>
                <g
                   id="g3489">
                  <desc
                     id="desc3491">Drawing</desc>
                  <g
                     id="g3493">
                    <g
                       id="g3495"
                       style="fill:none;stroke:none">
                      <rect
                         id="rect3497"
                         height="10448"
                         width="21553"
                         y="15"
                         x="-217" />
                    </g>
                    <g
                       id="g3499" />
                  </g>
                </g>
              </g>
              <g
                 id="g3501">
                <desc
                   id="desc3503">Group</desc>
                <g
                   id="g3505">
                  <desc
                     id="desc3507">Group</desc>
                  <g
                     id="g3509">
                    <desc
                       id="desc3511">Group</desc>
                    <g
                       id="g3513">
                      <desc
                         id="desc3515">Drawing</desc>
                      <g
                         id="g3517">
                        <g
                           id="g3519"
                           style="fill:#000000;stroke:none">
                          <path
                             id="path3521"
                             d="m 1581,4398 c 0,136 -16,257 -46,363 54,109 81,259 81,450 0,133 -24,267 -72,402 -47,135 -122,262 -224,381 -96,110 -194,216 -295,320 -100,104 -195,213 -284,325 -122,154 -230,317 -322,489 -92,172 -172,354 -240,545 -4,10 -6,26 -6,46 0,21 2,34 6,41 0,4 -23,5 -67,5 l 0,-2252 c 102,0 211,-26 325,-79 114,-53 221,-113 320,-179 99,-67 185,-132 258,-197 74,-65 120,-111 141,-138 157,-178 235,-378 235,-599 0,-191 -53,-405 -158,-640 -21,-44 -31,-77 -31,-97 0,-28 14,-41 41,-41 44,0 87,39 128,117 41,79 77,169 107,269 31,101 56,197 74,289 19,92 29,152 29,180 z m -140,731 c 0,-17 0,-36 0,-58 0,-23 -2,-51 -5,-85 -21,44 -66,101 -136,169 -70,68 -143,138 -220,210 -77,71 -148,136 -215,194 -66,58 -108,99 -125,123 -184,242 -336,498 -456,768 41,-14 88,-36 141,-67 53,-30 112,-73 177,-128 167,-143 297,-254 391,-332 94,-79 151,-130 172,-154 184,-198 276,-411 276,-640 z"
                             inkscape:connector-curvature="0" />
                        </g>
                        <g
                           id="g3523"
                           style="fill:none;stroke:none">
                          <rect
                             id="rect3525"
                             height="4225"
                             width="1505"
                             y="3542"
                             x="112" />
                        </g>
                        <g
                           id="g3527" />
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>
		
		
		';
	}
	
	
}