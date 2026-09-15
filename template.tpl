___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Country Name to ISO Code",
  "description": "Criada por @igor.tracker",
  "categories": [
    "UTILITY"
  ],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "countryName",
    "displayName": "Nome do país",
    "simpleValueType": true,
    "help": "Nome do país em português, inglês ou variação comum. Pode ser uma variável, ex.: {{DLV - country}} ou uma variável baseada em getEventData."
  },
  {
    "type": "TEXT",
    "name": "defaultValue",
    "displayName": "Valor padrão (fallback)",
    "simpleValueType": true,
    "help": "Valor retornado quando o país não for encontrado ou a entrada estiver vazia. Deixe em branco para retornar undefined."
  }
]


___SANDBOXED_JS_FOR_SERVER___

const makeString = require('makeString');

// ---------------------------------------------------------------------------
// Normaliza a entrada, nesta ordem:
//   1. converte para minúsculo
//   2. remove acentos
//   3. remove TUDO que não for letra (a-z) ou número (0-9):
//      espaços, hifens, apostrofos, pontos e qualquer caractere especial
// Só depois disso a consulta na tabela é feita, evitando erros de digitacao,
// pontuacao ou espacamento.
// ---------------------------------------------------------------------------
function normalize(str) {
  let s = makeString(str);
  s = s.toLowerCase();

  // remove acentos
  s = s.split('á').join('a').split('à').join('a').split('â').join('a').split('ã').join('a').split('ä').join('a');
  s = s.split('é').join('e').split('è').join('e').split('ê').join('e').split('ë').join('e');
  s = s.split('í').join('i').split('ì').join('i').split('î').join('i').split('ï').join('i');
  s = s.split('ó').join('o').split('ò').join('o').split('ô').join('o').split('õ').join('o').split('ö').join('o');
  s = s.split('ú').join('u').split('ù').join('u').split('û').join('u').split('ü').join('u');
  s = s.split('ç').join('c');
  s = s.split('ñ').join('n');

  // mantem apenas a-z e 0-9 (remove espacos, pontuacao e caracteres especiais)
  const allowed = 'abcdefghijklmnopqrstuvwxyz0123456789';
  let out = '';
  for (let i = 0; i < s.length; i++) {
    const ch = s.charAt(i);
    if (allowed.indexOf(ch) !== -1) {
      out = out + ch;
    }
  }
  return out;
}

// ---------------------------------------------------------------------------
// TABELA DE-PARA
// Chaves ja normalizadas (minusculo, sem acento, sem espacos/caracteres
// especiais), em PT, EN e variacoes comuns.
// Valor = codigo ISO 3166-1 alpha-2 em minusculo.
// ---------------------------------------------------------------------------
const map = {
  'afeganistao': 'af', 'afghanistan': 'af',
  'albania': 'al',
  'argelia': 'dz', 'algeria': 'dz', 'algerie': 'dz',
  'andorra': 'ad',
  'angola': 'ao',
  'antiguaebarbuda': 'ag', 'antiguaandbarbuda': 'ag', 'antigua': 'ag',
  'argentina': 'ar',
  'armenia': 'am',
  'australia': 'au',
  'austria': 'at',
  'azerbaijao': 'az', 'azerbaijan': 'az',
  'bahamas': 'bs',
  'bahrein': 'bh', 'bahrain': 'bh',
  'bangladesh': 'bd',
  'barbados': 'bb',
  'bielorrussia': 'by', 'belarus': 'by',
  'belgica': 'be', 'belgium': 'be', 'belgique': 'be',
  'belize': 'bz',
  'benin': 'bj',
  'butao': 'bt', 'bhutan': 'bt',
  'bolivia': 'bo',
  'bosniaeherzegovina': 'ba', 'bosnia': 'ba', 'bosniaherzegovina': 'ba', 'bosniaandherzegovina': 'ba',
  'botsuana': 'bw', 'botswana': 'bw',
  'brasil': 'br', 'brazil': 'br',
  'brunei': 'bn',
  'bulgaria': 'bg',
  'burkinafaso': 'bf', 'burquinafaso': 'bf',
  'burundi': 'bi',
  'caboverde': 'cv', 'capeverde': 'cv',
  'camboja': 'kh', 'cambodia': 'kh',
  'camaroes': 'cm', 'cameroon': 'cm', 'cameroun': 'cm',
  'canada': 'ca',
  'republicacentroafricana': 'cf', 'centralafricanrepublic': 'cf',
  'chade': 'td', 'chad': 'td', 'tchad': 'td',
  'chile': 'cl',
  'china': 'cn',
  'colombia': 'co',
  'comores': 'km', 'comoros': 'km',
  'congo': 'cg', 'republicadocongo': 'cg', 'congobrazzaville': 'cg',
  'republicademocraticadocongo': 'cd', 'rdcongo': 'cd', 'congokinshasa': 'cd', 'drcongo': 'cd', 'drc': 'cd',
  'costarica': 'cr',
  'croacia': 'hr', 'croatia': 'hr', 'hrvatska': 'hr',
  'cuba': 'cu',
  'chipre': 'cy', 'cyprus': 'cy',
  'republicatcheca': 'cz', 'tchequia': 'cz', 'chequia': 'cz', 'czechrepublic': 'cz', 'czechia': 'cz',
  'dinamarca': 'dk', 'denmark': 'dk',
  'djibuti': 'dj', 'djibouti': 'dj',
  'dominica': 'dm',
  'republicadominicana': 'do', 'dominicanrepublic': 'do',
  'equador': 'ec', 'ecuador': 'ec',
  'egito': 'eg', 'egipto': 'eg', 'egypt': 'eg',
  'elsalvador': 'sv',
  'guineequatorial': 'gq', 'equatorialguinea': 'gq',
  'eritreia': 'er', 'eritrea': 'er',
  'estonia': 'ee',
  'essuatini': 'sz', 'eswatini': 'sz', 'suazilandia': 'sz', 'swaziland': 'sz',
  'etiopia': 'et', 'ethiopia': 'et',
  'fiji': 'fj', 'fidji': 'fj',
  'finlandia': 'fi', 'finland': 'fi',
  'franca': 'fr', 'france': 'fr',
  'gabao': 'ga', 'gabon': 'ga',
  'gambia': 'gm',
  'georgia': 'ge',
  'alemanha': 'de', 'germany': 'de', 'deutschland': 'de',
  'gana': 'gh', 'ghana': 'gh',
  'grecia': 'gr', 'greece': 'gr',
  'granada': 'gd', 'grenada': 'gd',
  'guatemala': 'gt',
  'guine': 'gn', 'guinea': 'gn', 'guinee': 'gn',
  'guinebissau': 'gw', 'guineabissau': 'gw',
  'guiana': 'gy', 'guyana': 'gy',
  'haiti': 'ht',
  'honduras': 'hn',
  'hungria': 'hu', 'hungary': 'hu',
  'islandia': 'is', 'iceland': 'is',
  'india': 'in',
  'indonesia': 'id',
  'ira': 'ir', 'iran': 'ir',
  'iraque': 'iq', 'iraq': 'iq',
  'irlanda': 'ie', 'ireland': 'ie',
  'israel': 'il',
  'italia': 'it', 'italy': 'it',
  'costadomarfim': 'ci', 'ivorycoast': 'ci', 'cotedivoire': 'ci',
  'jamaica': 'jm',
  'japao': 'jp', 'japan': 'jp',
  'jordania': 'jo', 'jordan': 'jo',
  'cazaquistao': 'kz', 'kazakhstan': 'kz',
  'quenia': 'ke', 'kenya': 'ke',
  'kiribati': 'ki',
  'kuwait': 'kw', 'kuweit': 'kw',
  'quirguistao': 'kg', 'kyrgyzstan': 'kg',
  'laos': 'la',
  'letonia': 'lv', 'latvia': 'lv',
  'libano': 'lb', 'lebanon': 'lb',
  'lesoto': 'ls', 'lesotho': 'ls',
  'liberia': 'lr',
  'libia': 'ly', 'libya': 'ly',
  'liechtenstein': 'li',
  'lituania': 'lt', 'lithuania': 'lt',
  'luxemburgo': 'lu', 'luxembourg': 'lu',
  'madagascar': 'mg',
  'malawi': 'mw', 'malaui': 'mw',
  'malasia': 'my', 'malaysia': 'my',
  'maldivas': 'mv', 'maldives': 'mv',
  'mali': 'ml',
  'malta': 'mt',
  'ilhasmarshall': 'mh', 'marshallislands': 'mh',
  'mauritania': 'mr',
  'mauricio': 'mu', 'ilhasmauricio': 'mu', 'mauritius': 'mu',
  'mexico': 'mx',
  'micronesia': 'fm',
  'moldova': 'md', 'moldavia': 'md',
  'monaco': 'mc',
  'mongolia': 'mn',
  'montenegro': 'me',
  'marrocos': 'ma', 'morocco': 'ma', 'maroc': 'ma',
  'mocambique': 'mz', 'mozambique': 'mz',
  'myanmar': 'mm', 'mianmar': 'mm', 'birmania': 'mm', 'burma': 'mm',
  'namibia': 'na',
  'nauru': 'nr',
  'nepal': 'np',
  'holanda': 'nl', 'paisesbaixos': 'nl', 'netherlands': 'nl', 'holland': 'nl',
  'novazelandia': 'nz', 'newzealand': 'nz',
  'nicaragua': 'ni',
  'niger': 'ne',
  'nigeria': 'ng',
  'coreiadonorte': 'kp', 'northkorea': 'kp',
  'macedoniadonorte': 'mk', 'northmacedonia': 'mk', 'macedonia': 'mk',
  'noruega': 'no', 'norway': 'no',
  'oma': 'om', 'oman': 'om',
  'paquistao': 'pk', 'pakistan': 'pk',
  'palau': 'pw',
  'palestina': 'ps', 'palestine': 'ps',
  'panama': 'pa',
  'papuanovaguine': 'pg', 'papuanewguinea': 'pg',
  'paraguai': 'py', 'paraguay': 'py',
  'peru': 'pe',
  'filipinas': 'ph', 'philippines': 'ph',
  'polonia': 'pl', 'poland': 'pl',
  'portugal': 'pt',
  'catar': 'qa', 'qatar': 'qa',
  'romenia': 'ro', 'romania': 'ro',
  'russia': 'ru', 'russianfederation': 'ru',
  'ruanda': 'rw', 'rwanda': 'rw',
  'saocristovaoenevis': 'kn', 'saintkittsandnevis': 'kn', 'stkittsandnevis': 'kn',
  'santalucia': 'lc', 'saintlucia': 'lc', 'stlucia': 'lc',
  'saovicenteegranadinas': 'vc', 'saintvincentandthegrenadines': 'vc', 'stvincent': 'vc',
  'samoa': 'ws',
  'sanmarino': 'sm',
  'saotomeeprincipe': 'st', 'saotomeandprincipe': 'st',
  'arabiasaudita': 'sa', 'saudiarabia': 'sa',
  'senegal': 'sn',
  'servia': 'rs', 'serbia': 'rs',
  'seicheles': 'sc', 'seychelles': 'sc',
  'serraleoa': 'sl', 'sierraleone': 'sl',
  'singapura': 'sg', 'singapore': 'sg',
  'eslovaquia': 'sk', 'slovakia': 'sk',
  'eslovenia': 'si', 'slovenia': 'si',
  'ilhassalomao': 'sb', 'solomonislands': 'sb',
  'somalia': 'so',
  'africadosul': 'za', 'southafrica': 'za',
  'coreiadosul': 'kr', 'southkorea': 'kr', 'coreia': 'kr', 'korea': 'kr',
  'sudaodosul': 'ss', 'southsudan': 'ss',
  'espanha': 'es', 'spain': 'es', 'espana': 'es',
  'srilanka': 'lk',
  'sudao': 'sd', 'sudan': 'sd',
  'suriname': 'sr',
  'suecia': 'se', 'sweden': 'se',
  'suica': 'ch', 'switzerland': 'ch', 'suisse': 'ch',
  'siria': 'sy', 'syria': 'sy',
  'taiwan': 'tw', 'formosa': 'tw',
  'tadjiquistao': 'tj', 'tajikistan': 'tj',
  'tanzania': 'tz',
  'tailandia': 'th', 'thailand': 'th',
  'timorleste': 'tl', 'easttimor': 'tl', 'timor': 'tl',
  'togo': 'tg',
  'tonga': 'to',
  'trinidadetobago': 'tt', 'trinidadandtobago': 'tt', 'trinidad': 'tt',
  'tunisia': 'tn',
  'turquia': 'tr', 'turkey': 'tr', 'turkiye': 'tr',
  'turcomenistao': 'tm', 'turkmenistan': 'tm',
  'tuvalu': 'tv',
  'uganda': 'ug',
  'ucrania': 'ua', 'ukraine': 'ua',
  'emiradosarabesunidos': 'ae', 'emiradosarabes': 'ae', 'unitedarabemirates': 'ae', 'uae': 'ae',
  'reinounido': 'gb', 'unitedkingdom': 'gb', 'uk': 'gb', 'inglaterra': 'gb', 'greatbritain': 'gb', 'grabretanha': 'gb',
  'estadosunidos': 'us', 'estadosunidosdaamerica': 'us', 'unitedstates': 'us', 'usa': 'us', 'eua': 'us', 'america': 'us',
  'uruguai': 'uy', 'uruguay': 'uy',
  'uzbequistao': 'uz', 'uzbekistan': 'uz',
  'vanuatu': 'vu',
  'vaticano': 'va', 'vatican': 'va', 'vaticancity': 'va', 'santase': 'va',
  'venezuela': 've',
  'vietna': 'vn', 'vietnam': 'vn',
  'iemen': 'ye', 'yemen': 'ye',
  'zambia': 'zm',
  'zimbabue': 'zw', 'zimbabwe': 'zw'
};

// ---------------------------------------------------------------------------
// Execucao
// ---------------------------------------------------------------------------
const key = normalize(data.countryName);

if (key === '') {
  return data.defaultValue;
}

const code = map[key];

if (code) {
  return code;
}

return data.defaultValue;


___TESTS___

scenarios:
- name: Portugues com acento
  code: |-
    const mockData = { countryName: 'Brasil' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('br');
- name: Maiusculas e acento
  code: |-
    const mockData = { countryName: 'AFEGANISTAO' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('af');
- name: Nome em ingles
  code: |-
    const mockData = { countryName: 'Germany' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('de');
- name: Hifen
  code: |-
    const mockData = { countryName: 'Guine-Bissau' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('gw');
- name: Apostrofo e espacos
  code: |-
    const mockData = { countryName: "Cote d'Ivoire" };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('ci');
- name: Pontuacao no meio
  code: |-
    const mockData = { countryName: 'U.S.A.' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('us');
- name: Espacos extras
  code: |-
    const mockData = { countryName: '  Costa   Rica  ' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('cr');
- name: Variacao comum EUA
  code: |-
    const mockData = { countryName: 'EUA' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('us');
- name: Nao encontrado com fallback
  code: |-
    const mockData = { countryName: 'Narnia', defaultValue: 'xx' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo('xx');
- name: Vazio sem fallback
  code: |-
    const mockData = { countryName: '' };
    let result = runCode(mockData);
    assertThat(result).isEqualTo(undefined);


___NOTES___

Variavel server-side: recebe o nome de um pais e retorna o codigo ISO 3166-1 alpha-2 em minusculo.
A entrada e normalizada (minusculo -> remove acentos -> remove espacos e caracteres especiais) antes da consulta na tabela.
Tabela cobre PT, EN e variacoes comuns. Sem permissoes especiais (nao usa getEventData nem acessos externos).


