clear
close all

%point A nuevos interceptos con los ejes Y generados a partir de nuevos
%datos para la curva del método empírico en línea.

q = 1;

switch q
    case 1
    %Caso para exposición de 500us desde el fit polyfit1   
    yG =3.4815;
    yR =3.5595;
    yNIR = 3.684;
    
    case 2
    %Caso para exposición de 500us desde el fit exp1    
    yG =3.1942;
    yR =3.2968;
    yNIR = 3.4738;
    
    case 3
         %Caso para exposición de 500us desde el fit exp1 ligero cambio
    yG =3.2049;
    yR =3.3011;
    yNIR = 3.4639;
    
    case 4
    %Caso para exposición de 1250us desde el fit polyfit1       
    yG =4.2577;
    yR =4.3574;
    yNIR = 4.5167;
   
    case 5
    %Caso para exposición de 1000us desde el fit polyfit1       
    yG =3.9606;
    yR =4.0046;
    yNIR = 4.2019;
    
    case 6
    %Caso para exposición de Automática desde el fit polyfit1       
    yG =3.8965;
    yR =3.995;
    yNIR = 4.235;
        
end

%seleccion del punto B para construir la curva ELM a partir del número n

n = 2;

switch n

    case 1
    %point B a partir de target de 50% exposicion de 500us
    green = 79.12; 
    red = 81.249; 
    nir = 84.415;
    
    case 2
    %point B a partir de target de 50% otra región seleccionada del target exposicion de 500us
    green = 75.551; 
    red = 78.799; 
    nir = 81.147;

    case 3
    %point B a partir de target de 70% exposicion de 500us
    green = 54.911; 
    red = 57.002; 
    nir = 60.092;

    case 4
    %point B a partir de target de 80% exposicion de 500us
    green = 45.847; 
    red = 47.119; 
    nir = 50.351;

    case 5
    %point B a partir de target de 30% exposicion de 500us
    green = 109.399; 
    red = 112.015; 
    nir = 115.724;

    case 6
    %point B a partir de target de 5% exposicion de 500us
    green = 200.750; 
    red = 199.750; 
    nir = 205.750;    

    case 7
    %Other point B a partir de target de 5% exposicion de 500us
    green = 197.792; 
    red = 197.352; 
    nir = 204.272;

    case 8
    %Other point B a partir de target de 5% exposicion de 500us
    green = 201.281; 
    red = 200.338; 
    nir = 206.310;
    
    case 9
    %Other point B a partir de target de 90% exposicion de 500us
    green = 44.142; 
    red = 46.142; 
    nir = 47.224;
    
    case 10
    %Other point B a partir de target de 50% exposicion de 1250us
    green = 153.572; 
    red = 154.398; 
    nir = 161.571;
    
    case 11
    %Other point B a partir de target de 50% exposicion automática
    green = 129; 
    red = 125; 
    nir = 139;
    
    case 12
    %Other point B a partir de target de 50% exposicion 1000us
    green = 126.356; 
    red = 127.515; 
    nir = 134.722;
    
    %Puntos B tomados de targets que están colocados en campo dentro del
    %Buggie en el CIAT.
    
    case 13    
    %Puntos B tomados del target de 50% en la escena para tiempo de
    %exposición de 500us
    green = 32.136; 
    red = 34.701; 
    nir = 37.444;
    
    case 14
    %Puntos B tomados del target de 50% en la escena para tiempo de
    %exposición de 1000us
    green = 62.736; 
    red = 59.975; 
    nir = 73.713;
    
    
    case 15    
    %Puntos B tomados del target de 50% en la escena para tiempo de
    %exposición de 1250us
    green = 72.873; 
    red = 69.894; 
    nir = 84.802;
    
end

p = 1;

switch p
    
    case 1 
        % Pendiente e intercepto con el eje Y tomados del ajuste lineal que
        % realiza matlab con la función 'fit' con opción 'poly1' para
        % exposicion de 500us
        negLogG = -0.013272*green + yG;
        negLogR = -0.013433*red + yR;
        negLogNIR = -0.01298*nir + yNIR;
    
    case 2
        %Pentiende e intercepto con el eje Y tomados de la transformación
        %logaritmo natural del ajuste exponencial con la función 'fit' con
        %opcion 'exp1' para exposicion de 500 us
        negLogG = -0.010939*green + yG;
        negLogR = -0.011249*red + yR;
        negLogNIR = -0.011161*nir + yNIR;
        
        %cambio sutil
        
%         negLogG = -0.011133*green + yG;
%         negLogR = -0.011454*red + yR;
%         negLogNIR = -0.011361*nir + yNIR;

    case 3
        % Pendiente e intercepto con el eje Y tomados del ajuste lineal que
        % realiza matlab con la función 'fit' con opción 'poly1' todo esto
        % para la exposicion de 1250 us
        negLogG = -0.01257*green + yG;
        negLogR = -0.012941*red + yR;
        negLogNIR = -0.012724*nir + yNIR;
        
        
        
    case 4
        % Pendiente e intercepto con el eje Y tomados del ajuste lineal que
        % realiza matlab con la función 'fit' con opción 'poly1' todo esto
        % para la exposicion de 1000 us
        negLogG = -0.011958*green + yG;
        negLogR = -0.011907*red + yR;
        negLogNIR = -0.012049*nir + yNIR;
        
  case 5
        % Pendiente e intercepto con el eje Y tomados del ajuste lineal que
        % realiza matlab con la función 'fit' con opción 'poly1' todo esto
        % para la exposicion de automática
        negLogG = -0.012858*green + yG;
        negLogR = -0.013075*red + yR;
        negLogNIR = -0.013103*nir + yNIR;
end


%Slope m
mG = (negLogG-yG)/green;
mR = (negLogR-yR)/red;
mNIR = (negLogNIR-yNIR)/nir;

m = 48;

switch m
    
    case 1
    % Caso target 50%
    % Datos tomados de la tabla 4 del libro de excel
    % verificacion-exp-fix.xlsx hoja 2 con ISO: 100 y tiempo de exposicion
    % de 500 us
    DNg = [78.719;
    80.594;
    76.082;
    75.286;
    72.428;
    74.415;
    74.245;
    ]'; 

    DNr = [81.338;
    82.973;
    80.512;
    78.036;
    75.363;
    77.984;
    76.258;
    ]';

    DNnir = [83.722;
    85.941;
    82.261;
    81.246;
    78.093;
    80.041;
    79.109;
    ]';


    case 2
    % Caso 5%    
    % Datos tomados de la tabla 5 del libro de excel
    % verificacion-exp-fix.xlsx hoja 2 con ISO: 100 y tiempo de exposicion de 500 us
    DNg = [198.716;
    197.531;
    199.821;
    195.983;
    198.797;
    196.898;
    198.041;
    ]'; 
    
    DNr = [197.993;
    198.423;
    200.066;
    196.045;
    199.774;
    197.907;
    196.768;
    ]';
    
    DNnir = [203.943;
    203.432;
    205.141;
    202.98;
    204.735;
    202.908;
    202.004;
    ]';


    case 3
    % Caso de taget 90%    
    % Datos tomados de la tabla 7 del libro de excel
    % verificacion-exp-fix.xlsx hoja 2 con ISO: 100 y tiempo de exposicion de 500 us
    DNg = [42.595;
    40.799;
    42.891;
    42.427;
    44.101;
    43.593;
    43.902;
    ]'; 
    
    DNr = [44.507;
    42.731;
    44.891;
    44.371;
    45.897;
    45.551;
    45.903;
    ]';
    
    DNnir = [47.386
    45.406;
    47.638;
    47.336;
    48.957;
    48.312;
    47.525;
    ]';

    case 4
    % Caso de taget 80%    
    % Datos tomados de la tabla 7 del libro de excel
    % verificacion-exp-fix.xlsx hoja 4 con ISO: 100 y tiempo de exposicion de 500 us
    DNg = [48.333;
    46.574;
    46.445;
    48.024;
    48.005;
    47.011;
    49.823;
    ]'; 
    
    DNr = [49.817;
    47.624;
    48.022;
    49.546;
    50.004;
    48.915;
    51.834;
    ]';
    
    DNnir = [52.926;
    50.904;
    51.445;
    52.963;
    52.975;
    51.945;
    54.152;
    ]';

    case 5
    % Caso de taget 90%    
    % Datos tomados de la tabla 2 del libro de excel
    % verificacion-exp-fix.xlsx hoja 5 con ISO: 100 y tiempo de exposicion de 1250 us
    DNg = [89.37;
    89.25;
    88.51;
    87.25;
    90.023;
    88.43;
    88.23;
    ]'; 
    
    DNr = [88.264;
    88.35;
    85.69;
    85.95;
    89.128;
    88.239;
    87.123;
    ]';
    
    DNnir = [95.103;
    96.253;
    94.97;
    96.246;
    97.189;
    98.475;
    95.246;
    ]';


case 6
    % Caso 5%    
    % Datos tomados de la tabla 3 del libro de excel
    % verificacion-exp-fix.xlsx hoja 5 con ISO: 100 y tiempo de exposicion de 1250 us
    DNg = [254.32;
    254.56;
    255.41;
    255.32;
    255.78;
    255.132;
    255.48;
    ]'; 
    
    DNr = [246.72;
    245.56;
    249.763;
    250.32;
    247.34;
    248.95;
    247.51;
    ]';
    
    DNnir = [251.46;
    253.78;
    252.32;
    253.41;
    254.53;
    255.12;
    254.32;
    ]';

case 7
    % Caso target 50%
    % Datos tomados de la tabla 4 del libro de excel
    % verificacion-exp-fix.xlsx hoja 2 con ISO: 100 y tiempo de exposicion
    % de 500 us
    DNg = [156.774;
    157.263;
    154.122;
    153.658;
    149.257;
    149.913;
    156.262;
    ]'; 

    DNr = [157.697;
    158.263;
    155.671;
    154.945;
    150.601;
    150.957;
    157.132;
    ]';

    DNnir = [165.057;
    164.521;
    162.181;
    161.755;
    157.376;
    157.578;
    162.317;
    ]';

case 8
    % Caso 5%    
    % Datos tomados de la tabla 3 del libro de excel
    % verificacion-exp-fix.xlsx hoja 6 con ISO: 100 y tiempo de exposicion
    % automático
    DNg = [235;
    232;
    228;
    229;
    225;
    226;
    223;
    229;
    235;
    236;
    ]'; 
    
    DNr = [236;
    233;
    229;
    230;
    225;
    226;
    223;
    230;
    236;
    237;
    ]';
    
    DNnir = [241;
    238;
    234;
    235;
    233;
    234;
    231;
    235;
    241;
    242;
    ]';

    case 9
    % Caso target 50%
    % Datos tomados de la tabla 4 del libro de excel
    % verificacion-exp-fix.xlsx hoja 2 con ISO: 100 y tiempo de exposicion
    % de automatica us
    DNg = [129;
    127;
    125;
    122;
    119;
    119;
    116;
    118;
    119;
    124;
    ]'; 

    DNr = [125;
    125;
    125;
    120;
    117;
    118;
    112;
    116;
    115;
    122;
    ]';

    DNnir = [139;
    138;
    135;
    133;
    130;
    130;
    126;
    129;
    130;
    135;
    ]';

case 10
    % Caso de taget 90%    
    % Datos tomados de la tabla 2 del libro de excel
    % verificacion-exp-fix.xlsx hoja 5 con ISO: 100 y tiempo de exposicion de automático us
    DNg = [73;
    76;
    73;
    72;
    73;
    76;
    69;
    73;
    72;
    73;
    ]'; 
    
    DNr = [71;
    74;
    69;
    68;
    71;
    70;
    66;
    71;
    70;
    71;
    ]';
    
    DNnir = [84;
    87;
    83;
    82;
    84;
    84;
    77;
    85;
    83;
    85;
    ]';

case 11
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 2 del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [231.462;
    229.306;
    225.807;
    222.612;
    217.955;
    226.5874;
    226.009;
    227.3322;
    226.882;
    235.024;
    ]'; 
    
    DNr = [194.899;
    193.972;
    190.751;
    187.2238;
    181.2616;
    189.5121;
    189.482;
    190.813;
    191.143;
    200.688;
    ]';
    
    DNnir = [245.397;
    244.052;
    242.063;
    239.724;
    236.246;
    242.871;
    242.1274;
    242.865;
    242.373;
    248.118;
    ]';


case 12
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 4 del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion Automática us
    DNg = [237.143;
    235.71;
    237.33;
    235.334;
    235.269;
    234.769;
    231.739;
    236.242;
    222.633;
    242.652;
    ]'; 
    
    DNr = [219.512;
    178.351;
    201.727;
    198.992;
    204.146;
    199.551;
    197.015;
    196.498;
    188.464;
    208.247;
    ]';
    
    DNnir = [245.125;
    245.041;
    248.246;
    247.323;
    245.229;
    241.385;
    241.112;
    240.109;
    232.172;
    248.938;
    ]';


    case 13
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 4 del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [219.823;
    215.405;
    211.674;
    207.011;
    202.463;
    202.506;
    205.871;
    214.493;
    220.208;
    216.212;
    ]'; 
    
    DNr = [184.224;
    179.664;
    175.779;
    171.891;
    166.108;
    163.002;
    168.739;
    178.845;
    185.217;
    181.244;
    ]';
    
    DNnir = [239.292;
    235.258;
    232.839;
    229.061;
    224.874;
    224.945;
    228.178;
    234.714;
    239.819;
    236.474;
    ]';


 
    case 14
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 1 con correción del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [98.81827;
    95.31627;
    93.15527;
    88.32227;
    83.36627;
    86.25027;
    84.14927;
    98.20727;
    98.26927;
    106.65327;
    ]'; 
    
    DNr = [60.12403;
    57.73103;
    56.19703;
    53.56603;
    48.91003;
    49.61103;
    48.26703;
    60.03403;
    60.65203;
    67.07103;
    ]';
    
    DNnir = [238.42551;
    234.65651;
    233.71851;
    229.10451;
    225.03551;
    226.81051;
    225.74251;
    237.29051;
    238.79351;
    246.00151;
    ]';


case 15
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 2 con correción del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [164.96703;
    162.81103;
    159.31203;
    156.11703;
    151.46003;
    160.09243;
    159.51403;
    160.83723;
    160.38703;
    168.52903;
    ]'; 
    
    DNr = [124.4649;
    123.5379;
    120.3169;
    110.8275;
    119.0780;
    119.0479;
    120.3789;
    120.7089;
    130.2539;
    ]';
    
    DNnir = [306.5841;
    305.2391;
    303.2501;
    300.9111;
    297.4331;
    304.0581;
    303.3145;
    304.0521;
    303.5601;
    309.3051;
    ]';

case 16
    % Caso de plata especie 1 NDVI = 0.75(GreenSeeker)   
    % Datos tomados de la tabla 2 con correción del libro de excel
    % verificacion-exp-fix.xlsx hoja 3 con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [141.93006;
    137.51206;
    133.78106;
    129.11806;
    124.57006;
    124.61306;
    127.97806;
    136.60006;
    142.31506;
    138.31906;
    ]'; 
    
    DNr = [101.0750;
    96.5150;
    92.6300;
    88.7420;
    82.9590;
    79.8530;
    85.5900;
    95.6960;
    102.0680;
    98.0950;
    ]';
    
    DNnir = [277.7059;
    273.6719;
    271.2529;
    267.4749;
    263.2879;
    263.3589;
    266.5919;
    273.1279;
    278.2329;
    274.8879;
    ]';

case 17
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 1 libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [105.643;
    102.446;
    117.361;
    108.389;
    118.482;
    105.958;
    117.963;
    118.893;
    111.515;
    130.014;
    116.394;
    125.217;
    128.994;
    ]'; 
    
    DNr = [78.168;
    77.478;
    83.935;
    78.293;
    87.868;
    77.744;
    88.275;
    87.724;
    81.092;
    93.833;
    83.889;
    89.112;
    94.192;
    ]';
    
    DNnir = [131.391;
    126.754;
    145.311;
    135.728;
    144.471;
    131.077;
    144.499;
    147.932;
    138.687;
    159.889;
    144.175;
    154.836;
    157.661;
    ]';


case 18
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 2 libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [168.638;
    164.561;
    183.264;
    176.365;
    179.863;
    168.671;
    177.671;
    184.618;
    171.844;
    194.646;
    178.431;
    187.627;
    189.975;
    ]'; 
    
    DNr = [130.635;
    130.222;
    140.246;
    135.680;
    142.325;
    129.691;
    140.579;
    145.981;
    131.908;
    153.019;
    137.297;
    145.223;
    150.126;
    ]';
    
    DNnir = [193.901;
    189.773;
    207.577;
    202.127;
    202.904;
    193.803;
    201.446;
    209.195;
    197.378;
    217.664;
    203.251;
    212.026;
    213.036;
    ]';

case 19
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 3 libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1250us
    DNg = [186.653;
    185.551;
    201.638;
    192.876;
    198.951;
    188.374;
    194.861;
    200.778;
    188.914;
    209.292;
    196.679;
    201.491;
    206.812;
    ]'; 
    
    DNr = [149.251;
    151.431;
    161.226;
    153.175;
    162.802;
    150.307;
    159.042;
    164.043;
    149.323;
    170.611;
    157.227;
    160.985;
    169.487;
    ]';
    
    DNnir = [209.741;
    207.948;
    223.181;
    216.017;
    219.267;
    211.212;
    216.151;
    222.626;
    212.027;
    229.821;
    218.782;
    223.541;
    227.129;
    ]';


case 20
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 4 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [42.78427;
    39.58727;
    54.50227;
    45.53027;
    55.62327;
    43.09927;
    55.10427;
    56.03427;
    48.65627;
    67.15527;
    53.53527;
    62.35827;
    66.13527;
    ]'; 
    
    DNr = [17.30703;
    16.61703;
    23.07403;
    17.43203;
    27.00703;
    16.88303;
    27.41403;
    26.86303;
    20.23103;
    32.97203;
    23.02803;
    28.25103;
    33.33103;
    ]';
    
    DNnir = [180.09251;
    175.45551;
    194.01251;
    184.42951;
    193.17251;
    179.77851;
    193.20051;
    196.63351;
    187.38851;
    208.59051;
    192.87651;
    203.53751;
    206.36251;
    ]';

case 21
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 5 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [90.745;
    86.668;
    105.371;
    98.472;
    101.970;
    90.778;
    99.778;
    106.725;
    93.951;
    116.753;
    100.538;
    109.734;
    112.082;
    ]'; 
    
    DNr = [47.486;
    47.073;
    57.097;
    52.531;
    59.176;
    46.542;
    57.430;
    62.832;
    48.759;
    69.870;
    54.148;
    62.074;
    66.977;
    ]';
    
    DNnir = [232.31486;
    228.18686;
    245.99086;
    240.54086;
    241.31786;
    232.21686;
    239.85986;
    247.60886;
    235.79186;
    256.07786;
    241.66486;
    250.43986;
    251.44986;
    ]';


case 22
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 6 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [120.158;
    119.056;
    135.143;
    126.381;
    132.456;
    121.879;
    128.366;
    134.283;
    122.419;
    142.797;
    130.184;
    134.996;
    140.317;
    ]'; 
    
    DNr = [78.817;
    80.997;
    90.792;
    82.741;
    92.368;
    79.873;
    88.608;
    93.609;
    78.889;
    100.177;
    86.793;
    90.551;
    99.053;
    ]';
    
    DNnir = [270.92811;
    269.13511;
    284.36811;
    277.20411;
    280.45411;
    272.39911;
    277.33811;
    283.81311;
    273.21411;
    291.00811;
    279.96911;
    284.72811;
    288.31611;
    ]';

case 23
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 7 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [90.4436;
    87.2466;
    102.1616;
    93.1896;
    103.2826;
    90.7586;
    102.7636;
    103.6936;
    96.3156;
    114.8146;
    101.1946;
    110.0176;
    113.7946;
    ]'; 
    
    DNr = [44.5105;
    43.8205;
    50.2775;
    44.6355;
    54.2105;
    44.0865;
    54.6175;
    54.0665;
    47.4345;
    60.1755;
    50.2315;
    55.4545;
    60.5345;
    ]';
    
    DNnir = [228.1083;
    223.4713;
    242.0283;
    232.4453;
    241.1883;
    227.7943;
    241.2163;
    244.6493;
    235.4043;
    256.6063;
    240.8923;
    251.5533;
    254.3783;
    ]';


case 24
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 8 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [131.111;
    127.034;
    145.737;
    138.838;
    142.336;
    131.144;
    140.144;
    147.091;
    134.317;
    157.119;
    140.904;
    150.100;
    152.448;
    ]'; 
        
    DNr = [77.928;
    77.515;
    87.539;
    82.973;
    89.618;
    76.984;
    87.872;
    93.274;
    79.201;
    100.312;
    84.590;
    92.516;
    97.419;

    ]';
    
    DNnir = [267.8403;
    263.7123;
    281.5163;
    276.0663;
    276.8433;
    267.7423;
    275.3853;
    283.1343;
    271.3173;
    291.6033;
    277.1903;
    285.9653;
    286.9753;
    ]';

case 25
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 9 con correcion libro de excel 
    % verificacion-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [158.561;
    157.459;
    173.546;
    164.784;
    170.859;
    160.282;
    166.769;
    172.686;
    160.822;
    181.200;
    168.587;
    173.399;
    178.720;
    ]'; 
        
    DNr = [105.775;
    107.955;
    117.750;
    109.699;
    119.326;
    106.831;
    115.566;
    120.567;
    105.847;
    127.135;
    113.751;
    117.509;
    126.011;
    ]';
    
    DNnir = [301.8283308;
    300.0353308;
    315.2683308;
    308.1043308;
    311.3543308;
    303.2993308;
    308.2383308;
    314.7133308;
    304.1143308;
    321.9083308;
    310.8693308;
    315.6283308;
    319.2163308;
    ]';

case 26
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 10 del libro de excel 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [134.579;
    108.840;
    133.355;
    129.873;
    132.803;
    127.486;
    150.948;
    133.195;
    136.252;
    133.088;
    126.824;
    ]'; 
        
    DNr = [138.640;
    107.030;
    137.908;
    133.291;
    139.064;
    125.143;
    156.633;
    130.998;
    139.386;
    133.394;
    127.997;
    ]';
    
    DNnir = [138.758;
    118.281;
    137.306;
    136.249;
    134.318;
    138.141;
    153.432;
    142.317;
    140.575;
    140.229;
    133.970;    
    ]';

   case 27
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 13 con correción 1 del libro de excel 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 500 us
    DNg = [71.72027;
    45.98127;
    70.49627;
    67.01427;
    69.94427;
    64.62727;
    88.08927;
    70.33627;
    73.39327;
    70.22927;
    63.96527;
    ]'; 
        
    DNr = [77.77903;
    46.16903;
    77.04703;
    72.43003;
    78.20303;
    64.28203;
    95.77203;
    70.13703;
    78.52503;
    72.53303;
    67.13603;
    ]';
    
    DNnir = [187.45951;
    166.98251;
    186.00751;
    184.95051;
    183.01951;
    186.84251;
    202.13351;
    191.01851;
    189.27651;
    188.93051;
    182.67151;
    ]';

case 28
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 11 del libro de excel 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [197.583;
    172.521;
    193.817;
    189.218;
    196.926;
    188.739;
    207.646;
    189.467;
    196.748;
    197.973;
    186.152;
    ]'; 
        
    DNr = [197.754;
    166.781;
    193.813;
    188.677;
    198.775;
    183.634;
    205.944;
    185.111;
    196.511;
    194.267;
    184.579;
    ]';
    
    DNnir = [201.301;
    182.456;
    197.521;
    195.357;
    198.164;
    198.411;
    208.691;
    198.001;
    200.613;
    204.336;
    193.361;
    ]';

    case 29
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 14 con corrección 1 del libro de excel 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx hoja 1 con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [119.690;
    94.628;
    115.924;
    111.325;
    119.033;
    110.846;
    129.753;
    111.574;
    118.855;
    120.080;
    108.259;
    ]'; 
        
    DNr = [114.605;
    83.632;
    110.664;
    105.528;
    115.626;
    100.485;
    122.795;
    101.962;
    113.362;
    111.118;
    101.430;
    ]';
    
    DNnir = [239.71486;
    220.86986;
    235.93486;
    233.77086;
    236.57786;
    236.82486;
    247.10486;
    236.41486;
    239.02686;
    242.74986;
    231.77486;
    ]';


 case 30
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 19 plantas que no estan sanas pero tampoco estan buenas 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 500 us
    DNg = [107.063;
    92.058;
    117.546;
    120.647;
    97.003;
    108.933;
    113.954;
    121.913;
    127.575;
    122.225;
    117.121;
    125.359;
    117.855;
    120.554;
    ]'; 
        
    DNr = [84.681;
    74.075;
    93.481;
    109.225;
    93.345;
    84.686;
    100.092;
    107.826;
    109.222;
    110.182;
    105.642;
    107.132;
    92.245;
    96.302;
    ]';
    
    DNnir = [130.539;
    112.243;
    139.599;
    135.513;
    106.851;
    132.642;
    131.947;
    138.306;
    147.641;
    138.142;
    133.698;
    144.594;
    142.891;
    141.703;
    ]';

case 31
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 20 plantas que no estan sanas pero tampoco estan buenas 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [170.451;
    175.261;
    179.963;
    182.039;
    159.548;
    170.124;
    172.879;
    184.731;
    188.781;
    183.333;
    178.495;
    191.021;
    179.125;
    178.122;
    ]'; 
        
    DNr = [139.468;
    146.052;
    149.710;
    165.941;
    150.696;
    138.451;
    154.694;
    166.888;
    166.562;
    167.521;
    162.661;
    168.972;
    147.511;
    149.683;
    ]';
    
    DNnir = [194.343;
    197.214;
    200.383;
    197.427;
    171.008;
    193.335;
    190.121;
    198.892;
    205.729;
    198.216;
    194.616;
    206.619;
    202.083;
    197.745;
    ]';

case 32
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 21 plantas que NO estan sanas NO estan malas  
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [187.073;
    195.546;
    197.787;
    198.567;
    176.832;
    188.673;
    191.104;
    201.562;
    207.616;
    200.719;
    196.151;
    208.359;
    196.694;
    199.834;
    ]'; 
        
    DNr = [156.073;
    167.772;
    168.636;
    181.558;
    167.483;
    157.346;
    172.307;
    184.281;
    186.798;
    183.203;
    179.511;
    186.717;
    165.896;
    171.971;
    ]';
    
    DNnir = [208.619;
    214.753;
    215.811;
    212.235;
    187.917;
    209.467;
    206.058;
    213.869;
    222.302;
    213.703;
    210.581;
    222.644;
    217.339;
    216.378;
    ]';

case 33
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 22 plantas que NO estan sanas NO estan malas y con corrección 1 - CORR 1 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 500 us
    DNg = [44.20427;
    29.19927;
    54.68727;
    57.78827;
    34.14427;
    46.07427;
    51.09527;
    59.05427;
    64.71627;
    59.36627;
    54.26227;
    62.50027;
    54.99627;
    57.69527;
    ]'; 
        
    DNr = [23.82003;
    13.21403;
    32.62003;
    48.36403;
    32.48403;
    23.82503;
    39.23103;
    46.96503;
    48.36103;
    49.32103;
    44.78103;
    46.27103;
    31.38403;
    35.44103;
    ]';
    
    DNnir = [179.241;
    160.945;
    188.301;
    184.215;
    155.553;
    181.344;
    180.649;
    187.008;
    196.343;
    186.844;
    182.400;
    193.296;
    191.593;
    190.405;
    ]';

case 34
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 23 plantas que NO estan sanas NO estan malas y con corrección 1 - CORR 1 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [92.558;
    97.368;
    102.070;
    104.146;
    81.655;
    92.231;
    94.986;
    106.838;
    110.888;
    105.440;
    100.602;
    113.128;
    101.232;
    100.229;
    ]'; 
        
    DNr = [56.319;
    62.903;
    66.561;
    82.792;
    67.547;
    55.302;
    71.545;
    83.739;
    83.413;
    84.372;
    79.512;
    85.823;
    64.362;
    66.534;
    ]';
    
    DNnir = [232.75686;
    235.62786;
    238.79686;
    235.84086;
    209.42186;
    231.74886;
    228.53486;
    237.30586;
    244.14286;
    236.62986;
    233.02986;
    245.03286;
    240.49686;
    236.15886;
    ]';

case 35
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 24 plantas que NO estan sanas NO estan malas y con corrección 1 - CORR 1 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [120.578;
129.051;
131.292;
132.072;
110.337;
122.178;
124.609;
135.067;
141.121;
134.224;
129.656;
141.864;
130.199;
133.339;
    ]'; 
        
    DNr = [85.639;
97.338;
98.202;
111.124;
97.049;
86.912;
101.873;
113.847;
116.364;
112.769;
109.077;
116.283;
95.462;
101.537;
    ]';
    
    DNnir = [269.80611;
275.94011;
276.99811;
273.42211;
249.10411;
270.65411;
267.24511;
275.05611;
283.48911;
274.89011;
271.76811;
283.83111;
278.52611;
277.56511;
    ]';

case 36
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 25 plantas que NO estan sanas NO estan
    % malas y con corrección 2 - CORR 2 (Desde el campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 500 us
    DNg = [143.3924;
128.3874;
153.8754;
156.9764;
133.3324;
145.2624;
150.2834;
158.2424;
163.9044;
158.5544;
153.4504;
161.6884;
154.1844;
156.8834;
    ]'; 
        
    DNr = [127.673;
117.067;
136.473;
152.217;
136.337;
127.678;
143.084;
150.818;
152.214;
153.174;
148.634;
150.124;
135.237;
139.294;
    ]';
    
    DNnir = [229.8187;
211.5227;
238.8787;
234.7927;
206.1307;
231.9217;
231.2267;
237.5857;
246.9207;
237.4217;
232.9777;
243.8737;
242.1707;
240.9827;
    ]';

case 37
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 26 plantas que NO estan sanas NO estan
    % malas y con corrección 2 - CORR 2 (Desde el campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [185.729;
190.539;
195.241;
197.317;
174.826;
185.402;
188.157;
200.009;
204.059;
198.611;
193.773;
206.299;
194.403;
193.400;
    ]'; 
        
    DNr = [162.784;
169.368;
173.026;
189.257;
174.012;
161.767;
178.010;
190.204;
189.878;
190.837;
185.977;
192.288;
170.827;
172.999;
    ]';
    
    DNnir = [268.7848;
271.6558;
274.8248;
271.8688;
245.4498;
267.7768;
264.5628;
273.3338;
280.1708;
272.6578;
269.0578;
281.0608;
276.5248;
272.1868;
    ]';


case 38
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 27 plantas que NO estan sanas NO estan
    % malas y con corrección 2 - CORR 2 (Desde el campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [212.372;
220.845;
223.086;
223.866;
202.131;
213.972;
216.403;
226.861;
232.915;
226.018;
221.450;
233.658;
221.993;
225.133;
    ]'; 
        
    DNr = [190.306;
202.005;
202.869;
215.791;
201.716;
191.579;
206.540;
218.514;
221.031;
217.436;
213.744;
220.950;
200.129;
206.204;
    ]';
    
    DNnir = [299.8687;
306.0027;
307.0607;
303.4847;
279.1667;
300.7167;
297.3077;
305.1187;
313.5517;
304.9527;
301.8307;
313.8937;
308.5887;
307.6277;
    ]';

case 39
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 16 plantas que NO estan sanas estan secas
    % con corrección 2 - CORR 2 (Desde el campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 500 us
    DNg = [172.9093;
147.1703;
171.6853;
168.2033;
171.1333;
165.8163;
189.2783;
171.5253;
174.5823;
171.4183;
165.1543;
    ]'; 
        
    DNr = [187.544;
155.934;
186.812;
182.195;
187.968;
174.047;
205.537;
179.902;
188.290;
182.298;
176.901;
    ]';
    
    DNnir = [201.3601;
180.8831;
199.9081;
198.8511;
196.9201;
200.7431;
216.0341;
204.9191;
203.1771;
202.8311;
196.5721;
    ]';


case 40
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 17 plantas que NO estan sanas estan secas
    % con corrección 2 - CORR 2 (Desde el campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1000 us
    DNg = [217.733;
192.671;
213.967;
209.368;
217.076;
208.889;
227.796;
209.617;
216.898;
218.123;
206.302;
    ]'; 
        
    DNr = [229.028;
198.055;
225.087;
219.951;
230.049;
214.908;
237.218;
216.385;
227.785;
225.541;
215.853;
    ]';
    
    DNnir = [241.5551;
222.7101;
237.7751;
235.6111;
238.4181;
238.6651;
248.9451;
238.2551;
240.8671;
244.5901;
233.6151;
    ]';

case 41
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 12 plantas que NO estan sanas estan secas
    % sin corrección 
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [213.562;
189.346;
214.086;
207.261;
212.312;
204.821;
223.581;
205.426;
213.544;
208.481;
202.873;
    ]'; 
        
    DNr = [207.196;
182.124;
205.287;
201.468;
207.948;
197.065;
211.004;
198.309;
207.929;
200.696;
198.056;
    ]';
    
    DNnir = [215.651;
198.453;
216.246;
211.966;
212.377;
213.189;
223.108;
212.683;
215.829;
214.007;
209.074;
    ]';

case 42
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 15 plantas que NO estan sanas estan secas
    % con corrección 1 (desde cuarto oscuro)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [147.067;
122.851;
147.591;
140.766;
145.817;
138.326;
157.086;
138.931;
147.049;
141.986;
136.378;
    ]'; 
        
    DNr = [136.762;
111.690;
134.853;
131.034;
137.514;
126.631;
140.570;
127.875;
137.495;
130.262;
127.622;
    ]';
    
    DNnir = [276.83811;
259.64011;
277.43311;
273.15311;
273.56411;
274.37611;
284.29511;
273.87011;
277.01611;
275.19411;
270.26111;
    ]';

case 43
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 18 plantas secas
    % con correccion 2 (desde campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 500 us
    DNg = [271.280;
247.064;
271.804;
264.979;
270.030;
262.539;
281.299;
263.144;
271.262;
266.199;
260.591;
    ]'; 
        
    DNr = [285.387;
260.315;
283.478;
279.659;
286.139;
275.256;
289.195;
276.500;
286.120;
278.887;
276.247;
    ]';
    
    DNnir = [305.2390;
288.0410;
305.8340;
301.5540;
301.9650;
302.7770;
312.6960;
302.2710;
305.4170;
303.5950;
298.6620;
    ]';


case 44
    % Caso de planta salida de campo 16-feb-2017    
    % Datos tomados de la tabla 18 plantas que NO estan sanas estan secas
    % con corrección 2 (desde campo)
    % verificacion-NDVI-exp-fix-analisis-con-DN'.xlsx Hoja: En campo NDVI brachiaria con ISO: 100 y tiempo de exposicion 1250 us
    DNg = [111.696;
97.121;
102.150;
99.423;
95.504;
99.792;
109.227;
108.861;
114.171;
111.348;
110.345;
105.223;
    ]'; 
        
    DNr = [85.044;
75.197;
76.663;
78.563;
73.722;
76.334;
86.351;
84.451;
85.537;
89.334;
81.413;
79.971;
    ]';
    
    DNnir = [136.568;
119.787;
126.345;
118.369;
118.254;
121.298;
131.642;
134.740;
140.028;
134.336;
135.943;
128.809;
    ]';


case 45
    % Caso de planta salida de campo 28-marzo-2017    
    % Datos tomados de la tabla 37 plantas sanas
    % sin corrección
    % verificacion-NDVI-exp-fix-analisis-con-DN%27modified.xlsx 
    % Hoja: Field NDVI Brachiaria - polyfit  con ISO: 100 Tiempo de exposicion: 500 us
    DNg = [60.465	;
73.299	;
56.792	;
62.474	;
61.989	;
50.606	;
78.741	;
70.787	;
61.456	;
73.537	;
72.618	;
72.998	;
72.911	;
80.962	;
67.988	;
84.047	;
68.571	;
65.602	;
61.541	;
74.802	;
77.912	;
59.626	;
66.386	;
66.529	;
70.359	;
    ]'; 
        
    DNr = [45.347	;
52.619	;
44.439	;
46.411	;
48.076	;
40.208	;
56.687	;
53.167	;
47.661	;
54.944	;
53.175	;
53.211	;
53.347	;
58.844	;
52.057	;
60.835	;
51.734	;
50.041	;
49.029	;
55.689	;
57.977	;
47.652	;
52.322	;
52.531	;
52.443	;

    ]';
    
    DNnir = [76.771	;
94.636	;
70.853	;
79.063	;
76.868	;
63.541	;
101.130	;
88.954	;
77.310	;
92.626	;
92.637	;
92.971	;
92.768	;
102.878	;
84.724	;
106.557	;
86.623	;
82.755	;
75.351	;
95.269	;
98.094	;
74.371	;
84.419	;
80.374	;
88.876	;
    ]';


case 46
    % Caso de planta salida de campo 28-marzo-2017    
    % Datos tomados de la tabla 40 plantas secas
    % sin corrección
    % verificacion-NDVI-exp-fix-analisis-con-DN%27modified.xlsx 
    % Hoja: Field NDVI Brachiaria - polyfit  con ISO: 100 Tiempo de exposicion: 500 us
    DNg = [56.931	;
42.897	;
43.984	;
47.384	;
50.206	;
47.515	;
50.456	;
43.640	;
43.464	;
47.355	;
48.161	;
54.390	;
47.511	;
53.950	;
45.311	;
53.493	;
47.161	;
48.819	;
49.955	;
44.608	;
43.977	;
44.772	;
44.582	;
59.435	;
48.698	;

    ]'; 
        
    DNr = [58.524	;
45.191	;
46.031	;
48.667	;
52.165	;
49.078	;
52.836	;
45.768	;
45.502	;
49.431	;
50.502	;
56.023	;
49.348	;
56.319	;
47.314	;
48.185	;
48.460	;
51.573	;
52.550	;
46.821	;
45.728	;
46.611	;
46.369	;
50.851	;
51.227	;
    ]';
    
    DNnir = [62.060	;
46.611	;
47.424	;
51.795	;
54.407	;
51.121	;
54.438	;
47.903	;
46.963	;
50.971	;
51.805	;
60.844	;
51.141	;
58.071	;
48.994	;
62.924	;
51.610	;
52.062	;
53.136	;
47.866	;
47.811	;
48.300	;
48.101	;
70.663	;
52.119	;

    ]';

case 47
    % 
    % s
    % s
    % 
    % us
    DNg = [94.78374879	;
96.04414674	;
94.38243829	;
76.53669175	;
102.6118439	;
95.60994462	;
93.74101773	;
92.45091191	;
93.79326622	;
98.88587945	;
96.29505174	;
78.84519906	;
61.63706925	;
67.92309466	;
101.0650506	;
93.20486684	;
94.91624672	;
98.5277024	;
106.7726958	;
97.4147416	;
76.69563612	;
105.061647	;
105.3461378	;
94.69272641	;
75.31164264	;
101.03688	;
72.46400974	;
109.0873519	;
99.26639459	;
112.4273996	;
106.3429705	;
82.19536799	;
84.37482675	;
82.58242131	;
106.7010838	;
114.2935143	;
100.2113524	;
97.8352618	;
76.56608443	;
100.1757095	;
104.5445304	;
103.5051918	;
77.10989862	;
115.5245921	;
99.90667462	;
107.0838546	;
109.3835909	;
104.606714	;
98.88393733	;
86.68131968	;
    ]'; 
        
    DNr = [71.75374296	;
74.40221954	;
75.27756747	;
62.18119809	;
74.37890435	;
73.75335006	;
73.3595459	;
71.22360705	;
76.57991208	;
78.090082	;
82.34479482	;
79.62932508	;
61.52502615	;
67.35575022	;
79.17752692	;
73.24215995	;
79.74360233	;
73.10430968	;
80.25782794	;
74.64585859	;
78.21855603	;
89.02787731	;
79.75099421	;
73.82131369	;
76.05183944	;
80.80127749	;
75.14653861	;
82.46129015	;
73.27832884	;
82.28021763	;
88.77406267	;
80.27387802	;
86.17377637	;
79.76604228	;
77.897453	;
82.56566548	;
85.61798421	;
84.59721756	;
77.33307034	;
80.96767138	;
86.760203	;
79.11040082	;
76.37480398	;
85.63265754	;
83.62725134	;
83.10992286	;
86.93695914	;
78.85911056	;
76.16440072	;
86.2029068	;

    ]';
    
    DNnir = [118.6409367	;
118.9265039	;
116.6657312	;
94.62492472	;
128.0643196	;
118.3655431	;
117.0502512	;
114.8547987	;
111.4342736	;
118.6353364	;
112.9290406	;
80.1701641	;
67.0055219	;
72.01636684	;
124.0626124	;
115.7472917	;
113.9279017	;
124.2866213	;
131.1790943	;
120.9391366	;
78.14685943	;
122.8952172	;
130.2290465	;
115.5472082	;
79.08727034	;
121.9969484	;
71.96093522	;
136.6246067	;
124.7849136	;
140.016117	;
126.2156809	;
89.10920209	;
85.52007833	;
88.53219181	;
133.2115223	;
142.7043216	;
117.8567323	;
115.9715884	;
78.01894825	;
123.6107465	;
124.0350412	;
127.4633095	;
80.69089218	;
142.4242673	;
119.6330801	;
131.9314736	;
129.7567003	;
129.0342888	;
121.0230521	;
91.28155188	;

    ]';

case 48
    % 
    % s
    % s
    % 
    % us
    DNg = [37.38040012	;
60.77934371	;
47.37657644	;
53.16852956	;
39.41299418	;
31.37708392	;
53.03314128	;
30.99041556	;
32.4092203	;
67.29405073	;
59.46652394	;
33.4684464	;
41.29229694	;
39.7487068	;
38.73584065	;
42.16662274	;
42.83189444	;
40.31436855	;
40.87730706	;
41.41015911	;
43.55520366	;
66.21488422	;
66.50326704	;
67.7445902	;
67.69479102	;
39.27141912	;
72.89587854	;
65.32367007	;
48.73659468	;
74.47915451	;
37.8424706	;
66.25224745	;
43.35578773	;
61.80836161	;
44.37764314	;
45.64234395	;
43.66236114	;
37.10721276	;
59.6817646	;
39.28732928	;
69.19700785	;
40.66563562	;
39.52047628	;
46.06919622	;
68.83584409	;
41.78805251	;
61.72214843	;
63.90015433	;
62.62264495	;
56.73105891	;

    ]'; 
        
    DNr = [35.26415815	;
45.28262802	;
50.27061205	;
43.32141177	;
35.65561624	;
37.13191716	;
42.66278552	;
32.20730893	;
37.47405921	;
50.07630818	;
45.91022079	;
37.83847336	;
45.08620276	;
40.31362899	;
43.41634083	;
46.37276554	;
46.66079393	;
44.53289539	;
44.99537402	;
46.14126644	;
45.76360126	;
50.62176732	;
50.14028733	;
50.7394131	;
50.5748104	;
43.35941981	;
54.35899881	;
50.68409001	;
52.4965996	;
55.19140601	;
42.63362354	;
51.20415721	;
43.40379646	;
49.03224566	;
48.61986824	;
49.973212	;
48.13070276	;
42.04268348	;
48.91583279	;
43.86646025	;
52.79966913	;
45.07485199	;
43.54895935	;
47.15520496	;
53.30704048	;
46.22361858	;
49.12792133	;
51.62328188	;
50.46670548	;
45.00947255	;


    ]';
    
    DNnir = [47.09753171	;
79.14257373	;
50.73154455	;
66.57742589	;
50.19289178	;
33.98268841	;
66.20625632	;
38.94264897	;
35.02211927	;
86.97159121	;
75.9679073	;
36.52992414	;
43.84694925	;
48.41768673	;
41.42920265	;
45.043137	;
46.87129788	;
42.98423001	;
43.36042567	;
44.03616731	;
49.79510062	;
83.54962599	;
84.94502019	;
86.50353188	;
86.56474532	;
42.40002526	;
92.76815085	;
81.95737675	;
51.56090671	;
94.91009264	;
40.95552945	;
84.0398408	;
50.31334446	;
78.26308824	;
47.61684106	;
48.28436483	;
45.93940174	;
39.60293865	;
73.12927312	;
42.01895906	;
88.32384138	;
43.46164798	;
42.22054211	;
52.11982509	;
87.07919962	;
44.11898265	;
78.27251525	;
78.59006072	;
76.44001403	;
72.29997419	;


    ]';



end

nReflGreen = mG.*DNg +yG;
nReflRed = mR.*DNr +yR;
nReflNIR = mNIR.*DNnir +yNIR;

ReflGreen = exp(-nReflGreen)'
ReflRed = exp(-nReflRed)'
ReflNIR = exp(-nReflNIR)'



