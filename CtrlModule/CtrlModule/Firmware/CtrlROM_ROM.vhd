-- ZPU
--
-- Copyright 2004-2008 oharboe - �yvind Harboe - oyvind.harboe@zylin.com
-- Modified by Alastair M. Robinson for the ZPUFlex project.
--
-- The FreeBSD license
-- 
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimer in the documentation and/or other materials
--    provided with the distribution.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE ZPU PROJECT ``AS IS'' AND ANY
-- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
-- PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
-- ZPU PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
-- INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
-- OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-- The views and conclusions contained in the software and documentation
-- are those of the authors and should not be interpreted as representing
-- official policies, either expressed or implied, of the ZPU Project.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.zpupkg.all;

entity CtrlROM_ROM is
generic
	(
		maxAddrBitBRAM : integer := maxAddrBitBRAMLimit -- Specify your actual ROM size to save LEs and unnecessary block RAM usage.
	);
port (
	clk : in std_logic;
	areset : in std_logic := '0';
	from_zpu : in ZPU_ToROM;
	to_zpu : out ZPU_FromROM
);
end CtrlROM_ROM;

architecture arch of CtrlROM_ROM is

type ram_type is array(natural range 0 to ((2**(maxAddrBitBRAM+1))/4)-1) of std_logic_vector(wordSize-1 downto 0);

shared variable ram : ram_type :=
(
     0 => x"0b0b0b0b",
     1 => x"8c0b0b0b",
     2 => x"0b81e004",
     3 => x"0b0b0b0b",
     4 => x"8c04ff0d",
     5 => x"80040400",
     6 => x"00000016",
     7 => x"00000000",
     8 => x"0b0b0b99",
     9 => x"e8080b0b",
    10 => x"0b99ec08",
    11 => x"0b0b0b99",
    12 => x"f0080b0b",
    13 => x"0b0b9808",
    14 => x"2d0b0b0b",
    15 => x"99f00c0b",
    16 => x"0b0b99ec",
    17 => x"0c0b0b0b",
    18 => x"99e80c04",
    19 => x"00000000",
    20 => x"00000000",
    21 => x"00000000",
    22 => x"00000000",
    23 => x"00000000",
    24 => x"71fd0608",
    25 => x"72830609",
    26 => x"81058205",
    27 => x"832b2a83",
    28 => x"ffff0652",
    29 => x"0471fc06",
    30 => x"08728306",
    31 => x"09810583",
    32 => x"05101010",
    33 => x"2a81ff06",
    34 => x"520471fd",
    35 => x"060883ff",
    36 => x"ff738306",
    37 => x"09810582",
    38 => x"05832b2b",
    39 => x"09067383",
    40 => x"ffff0673",
    41 => x"83060981",
    42 => x"05820583",
    43 => x"2b0b2b07",
    44 => x"72fc060c",
    45 => x"51510471",
    46 => x"fc06080b",
    47 => x"0b0b93c8",
    48 => x"73830610",
    49 => x"10050806",
    50 => x"7381ff06",
    51 => x"73830609",
    52 => x"81058305",
    53 => x"1010102b",
    54 => x"0772fc06",
    55 => x"0c515104",
    56 => x"99e8709a",
    57 => x"c0278b38",
    58 => x"80717084",
    59 => x"05530c81",
    60 => x"e2048c51",
    61 => x"85f90402",
    62 => x"fc050df8",
    63 => x"80518f0b",
    64 => x"99f80c9f",
    65 => x"0b99fc0c",
    66 => x"a0717081",
    67 => x"05533499",
    68 => x"fc08ff05",
    69 => x"99fc0c99",
    70 => x"fc088025",
    71 => x"eb3899f8",
    72 => x"08ff0599",
    73 => x"f80c99f8",
    74 => x"088025d7",
    75 => x"38800b99",
    76 => x"fc0c800b",
    77 => x"99f80c02",
    78 => x"84050d04",
    79 => x"02f0050d",
    80 => x"f88053f8",
    81 => x"a05483bf",
    82 => x"52737081",
    83 => x"05553351",
    84 => x"70737081",
    85 => x"055534ff",
    86 => x"12527180",
    87 => x"25eb38fb",
    88 => x"c0539f52",
    89 => x"a0737081",
    90 => x"055534ff",
    91 => x"12527180",
    92 => x"25f23802",
    93 => x"90050d04",
    94 => x"02f4050d",
    95 => x"74538e0b",
    96 => x"99f80825",
    97 => x"8f3882bc",
    98 => x"2d99f808",
    99 => x"ff0599f8",
   100 => x"0c82fe04",
   101 => x"99f80899",
   102 => x"fc085351",
   103 => x"728a2e09",
   104 => x"8106b738",
   105 => x"7151719f",
   106 => x"24a03899",
   107 => x"f808a029",
   108 => x"11f88011",
   109 => x"5151a071",
   110 => x"3499fc08",
   111 => x"810599fc",
   112 => x"0c99fc08",
   113 => x"519f7125",
   114 => x"e238800b",
   115 => x"99fc0c99",
   116 => x"f8088105",
   117 => x"99f80c83",
   118 => x"ee0470a0",
   119 => x"2912f880",
   120 => x"11515172",
   121 => x"713499fc",
   122 => x"08810599",
   123 => x"fc0c99fc",
   124 => x"08a02e09",
   125 => x"81068e38",
   126 => x"800b99fc",
   127 => x"0c99f808",
   128 => x"810599f8",
   129 => x"0c028c05",
   130 => x"0d0402ec",
   131 => x"050d800b",
   132 => x"9a800cf6",
   133 => x"8c08f690",
   134 => x"0871882c",
   135 => x"565481ff",
   136 => x"06527372",
   137 => x"25883871",
   138 => x"54820b9a",
   139 => x"800c7288",
   140 => x"2c7381ff",
   141 => x"06545574",
   142 => x"73258b38",
   143 => x"729a8008",
   144 => x"84079a80",
   145 => x"0c557384",
   146 => x"2b86a071",
   147 => x"25837131",
   148 => x"700b0b0b",
   149 => x"97900c81",
   150 => x"712bff05",
   151 => x"f6880cfd",
   152 => x"fc13ff12",
   153 => x"2c788829",
   154 => x"ff940570",
   155 => x"812c9a80",
   156 => x"08525852",
   157 => x"55515254",
   158 => x"76802e85",
   159 => x"38708107",
   160 => x"5170f694",
   161 => x"0c710981",
   162 => x"05f6800c",
   163 => x"72098105",
   164 => x"f6840c02",
   165 => x"94050d04",
   166 => x"02f4050d",
   167 => x"74537270",
   168 => x"81055480",
   169 => x"f52d5271",
   170 => x"802e8938",
   171 => x"715182f8",
   172 => x"2d859e04",
   173 => x"810b99e8",
   174 => x"0c028c05",
   175 => x"0d0402fc",
   176 => x"050d8180",
   177 => x"8051c011",
   178 => x"5170fb38",
   179 => x"0284050d",
   180 => x"0402fc05",
   181 => x"0dec5183",
   182 => x"710c85be",
   183 => x"2d82710c",
   184 => x"0284050d",
   185 => x"0402fc05",
   186 => x"0dec5192",
   187 => x"710c85be",
   188 => x"2d82710c",
   189 => x"0284050d",
   190 => x"0402ec05",
   191 => x"0d840bec",
   192 => x"0c8ae42d",
   193 => x"87ce2d81",
   194 => x"f72d9794",
   195 => x"518cf92d",
   196 => x"87da2d8d",
   197 => x"892d97c0",
   198 => x"0b80f52d",
   199 => x"708a2b98",
   200 => x"800697cc",
   201 => x"0b80f52d",
   202 => x"708c2ba0",
   203 => x"800697d8",
   204 => x"0b80f52d",
   205 => x"70822b84",
   206 => x"06747307",
   207 => x"0797e40b",
   208 => x"80f52d70",
   209 => x"8d2b80c0",
   210 => x"800697f0",
   211 => x"0b80f52d",
   212 => x"70832b88",
   213 => x"06747307",
   214 => x"0797fc0b",
   215 => x"80f52d70",
   216 => x"842bb006",
   217 => x"98880b80",
   218 => x"f52d7086",
   219 => x"2b80c006",
   220 => x"74730707",
   221 => x"98940b80",
   222 => x"f52d7087",
   223 => x"2b818006",
   224 => x"98a00b80",
   225 => x"f52d7089",
   226 => x"2b848006",
   227 => x"74730707",
   228 => x"98ac0b80",
   229 => x"f52d708e",
   230 => x"2b838080",
   231 => x"067207fc",
   232 => x"0c535454",
   233 => x"54545454",
   234 => x"54545454",
   235 => x"54565452",
   236 => x"57575353",
   237 => x"865299e8",
   238 => x"08833884",
   239 => x"5271ec0c",
   240 => x"86900471",
   241 => x"980c04ff",
   242 => x"b00899e8",
   243 => x"0c04810b",
   244 => x"ffb00c04",
   245 => x"800bffb0",
   246 => x"0c0402f4",
   247 => x"050d88dc",
   248 => x"0499e808",
   249 => x"81f02e09",
   250 => x"81068938",
   251 => x"810b99d8",
   252 => x"0c88dc04",
   253 => x"99e80881",
   254 => x"e02e0981",
   255 => x"06893881",
   256 => x"0b99dc0c",
   257 => x"88dc0499",
   258 => x"e8085299",
   259 => x"dc08802e",
   260 => x"883899e8",
   261 => x"08818005",
   262 => x"5271842c",
   263 => x"728f0653",
   264 => x"5399d808",
   265 => x"802e9938",
   266 => x"72842999",
   267 => x"98057213",
   268 => x"81712b70",
   269 => x"09730806",
   270 => x"730c5153",
   271 => x"5388d204",
   272 => x"72842999",
   273 => x"98057213",
   274 => x"83712b72",
   275 => x"0807720c",
   276 => x"5353800b",
   277 => x"99dc0c80",
   278 => x"0b99d80c",
   279 => x"9a845189",
   280 => x"dd2d99e8",
   281 => x"08ff24fe",
   282 => x"f838800b",
   283 => x"99e80c02",
   284 => x"8c050d04",
   285 => x"02f8050d",
   286 => x"9998528f",
   287 => x"51807270",
   288 => x"8405540c",
   289 => x"ff115170",
   290 => x"8025f238",
   291 => x"0288050d",
   292 => x"0402f005",
   293 => x"0d755187",
   294 => x"d42d7082",
   295 => x"2cfc0699",
   296 => x"98117210",
   297 => x"9e067108",
   298 => x"70722a70",
   299 => x"83068274",
   300 => x"2b700974",
   301 => x"06760c54",
   302 => x"51565753",
   303 => x"515387ce",
   304 => x"2d7199e8",
   305 => x"0c029005",
   306 => x"0d0402fc",
   307 => x"050d7251",
   308 => x"80710c80",
   309 => x"0b84120c",
   310 => x"0284050d",
   311 => x"0402f005",
   312 => x"0d757008",
   313 => x"84120853",
   314 => x"5353ff54",
   315 => x"71712ea8",
   316 => x"3887d42d",
   317 => x"84130870",
   318 => x"84291488",
   319 => x"11700870",
   320 => x"81ff0684",
   321 => x"18088111",
   322 => x"8706841a",
   323 => x"0c535155",
   324 => x"51515187",
   325 => x"ce2d7154",
   326 => x"7399e80c",
   327 => x"0290050d",
   328 => x"0402f805",
   329 => x"0d87d42d",
   330 => x"e008708b",
   331 => x"2a708106",
   332 => x"51525270",
   333 => x"802e9d38",
   334 => x"9a840870",
   335 => x"84299a8c",
   336 => x"057381ff",
   337 => x"06710c51",
   338 => x"519a8408",
   339 => x"81118706",
   340 => x"9a840c51",
   341 => x"800b9aac",
   342 => x"0c87c72d",
   343 => x"87ce2d02",
   344 => x"88050d04",
   345 => x"02fc050d",
   346 => x"9a845189",
   347 => x"ca2d88f4",
   348 => x"2d8aa151",
   349 => x"87c32d02",
   350 => x"84050d04",
   351 => x"02fc050d",
   352 => x"8b860487",
   353 => x"da2d80f6",
   354 => x"5189912d",
   355 => x"99e808f3",
   356 => x"3880da51",
   357 => x"89912d99",
   358 => x"e808e838",
   359 => x"99e80899",
   360 => x"e40c99e8",
   361 => x"0851848a",
   362 => x"2d028405",
   363 => x"0d0402ec",
   364 => x"050d7654",
   365 => x"8052870b",
   366 => x"881580f5",
   367 => x"2d565374",
   368 => x"72248338",
   369 => x"a0537251",
   370 => x"82f82d81",
   371 => x"128b1580",
   372 => x"f52d5452",
   373 => x"727225de",
   374 => x"38029405",
   375 => x"0d0402f0",
   376 => x"050d9ab0",
   377 => x"085481f7",
   378 => x"2d800b9a",
   379 => x"b40c7308",
   380 => x"802e8180",
   381 => x"38820b99",
   382 => x"fc0c9ab4",
   383 => x"088f0699",
   384 => x"f80c7308",
   385 => x"5271832e",
   386 => x"96387183",
   387 => x"26893871",
   388 => x"812eaf38",
   389 => x"8cdf0471",
   390 => x"852e9f38",
   391 => x"8cdf0488",
   392 => x"1480f52d",
   393 => x"84150897",
   394 => x"84535452",
   395 => x"85982d71",
   396 => x"84291370",
   397 => x"0852528c",
   398 => x"e3047351",
   399 => x"8bae2d8c",
   400 => x"df0499e0",
   401 => x"08881508",
   402 => x"2c708106",
   403 => x"51527180",
   404 => x"2e873897",
   405 => x"88518cdc",
   406 => x"04978c51",
   407 => x"85982d84",
   408 => x"14085185",
   409 => x"982d9ab4",
   410 => x"0881059a",
   411 => x"b40c8c14",
   412 => x"548bee04",
   413 => x"0290050d",
   414 => x"04719ab0",
   415 => x"0c8bde2d",
   416 => x"9ab408ff",
   417 => x"059ab80c",
   418 => x"0402e805",
   419 => x"0d9ab008",
   420 => x"9abc0857",
   421 => x"55875189",
   422 => x"912d99e8",
   423 => x"08812a70",
   424 => x"81065152",
   425 => x"71802ea0",
   426 => x"388daf04",
   427 => x"87da2d87",
   428 => x"5189912d",
   429 => x"99e808f4",
   430 => x"3899e408",
   431 => x"81327099",
   432 => x"e40c7052",
   433 => x"52848a2d",
   434 => x"80fe5189",
   435 => x"912d99e8",
   436 => x"08802ea6",
   437 => x"3899e408",
   438 => x"802e9138",
   439 => x"800b99e4",
   440 => x"0c805184",
   441 => x"8a2d8dec",
   442 => x"0487da2d",
   443 => x"80fe5189",
   444 => x"912d99e8",
   445 => x"08f33885",
   446 => x"e52d99e4",
   447 => x"08903881",
   448 => x"fd518991",
   449 => x"2d81fa51",
   450 => x"89912d93",
   451 => x"bf0481f5",
   452 => x"5189912d",
   453 => x"99e80881",
   454 => x"2a708106",
   455 => x"51527180",
   456 => x"2eaf389a",
   457 => x"b8085271",
   458 => x"802e8938",
   459 => x"ff129ab8",
   460 => x"0c8ed104",
   461 => x"9ab40810",
   462 => x"9ab40805",
   463 => x"70842916",
   464 => x"51528812",
   465 => x"08802e89",
   466 => x"38ff5188",
   467 => x"12085271",
   468 => x"2d81f251",
   469 => x"89912d99",
   470 => x"e808812a",
   471 => x"70810651",
   472 => x"5271802e",
   473 => x"b1389ab4",
   474 => x"08ff119a",
   475 => x"b8085653",
   476 => x"53737225",
   477 => x"89388114",
   478 => x"9ab80c8f",
   479 => x"96047210",
   480 => x"13708429",
   481 => x"16515288",
   482 => x"1208802e",
   483 => x"8938fe51",
   484 => x"88120852",
   485 => x"712d81fd",
   486 => x"5189912d",
   487 => x"99e80881",
   488 => x"2a708106",
   489 => x"51527180",
   490 => x"2ead389a",
   491 => x"b808802e",
   492 => x"8938800b",
   493 => x"9ab80c8f",
   494 => x"d7049ab4",
   495 => x"08109ab4",
   496 => x"08057084",
   497 => x"29165152",
   498 => x"88120880",
   499 => x"2e8938fd",
   500 => x"51881208",
   501 => x"52712d81",
   502 => x"fa518991",
   503 => x"2d99e808",
   504 => x"812a7081",
   505 => x"06515271",
   506 => x"802eae38",
   507 => x"9ab408ff",
   508 => x"1154529a",
   509 => x"b8087325",
   510 => x"8838729a",
   511 => x"b80c9099",
   512 => x"04711012",
   513 => x"70842916",
   514 => x"51528812",
   515 => x"08802e89",
   516 => x"38fc5188",
   517 => x"12085271",
   518 => x"2d9ab808",
   519 => x"70535473",
   520 => x"802e8a38",
   521 => x"8c15ff15",
   522 => x"5555909f",
   523 => x"04820b99",
   524 => x"fc0c718f",
   525 => x"0699f80c",
   526 => x"81eb5189",
   527 => x"912d99e8",
   528 => x"08812a70",
   529 => x"81065152",
   530 => x"71802ead",
   531 => x"38740885",
   532 => x"2e098106",
   533 => x"a4388815",
   534 => x"80f52dff",
   535 => x"05527188",
   536 => x"1681b72d",
   537 => x"71982b52",
   538 => x"71802588",
   539 => x"38800b88",
   540 => x"1681b72d",
   541 => x"74518bae",
   542 => x"2d81f451",
   543 => x"89912d99",
   544 => x"e808812a",
   545 => x"70810651",
   546 => x"5271802e",
   547 => x"b3387408",
   548 => x"852e0981",
   549 => x"06aa3888",
   550 => x"1580f52d",
   551 => x"81055271",
   552 => x"881681b7",
   553 => x"2d7181ff",
   554 => x"068b1680",
   555 => x"f52d5452",
   556 => x"72722787",
   557 => x"38728816",
   558 => x"81b72d74",
   559 => x"518bae2d",
   560 => x"80da5189",
   561 => x"912d99e8",
   562 => x"08812a70",
   563 => x"81065152",
   564 => x"71802e81",
   565 => x"a6389ab0",
   566 => x"089ab808",
   567 => x"55537380",
   568 => x"2e8a388c",
   569 => x"13ff1555",
   570 => x"5391de04",
   571 => x"72085271",
   572 => x"822ea638",
   573 => x"71822689",
   574 => x"3871812e",
   575 => x"a93892fb",
   576 => x"0471832e",
   577 => x"b1387184",
   578 => x"2e098106",
   579 => x"80ed3888",
   580 => x"1308518c",
   581 => x"f92d92fb",
   582 => x"049ab808",
   583 => x"51881308",
   584 => x"52712d92",
   585 => x"fb04810b",
   586 => x"8814082b",
   587 => x"99e00832",
   588 => x"99e00c92",
   589 => x"d1048813",
   590 => x"80f52d81",
   591 => x"058b1480",
   592 => x"f52d5354",
   593 => x"71742483",
   594 => x"38805473",
   595 => x"881481b7",
   596 => x"2d8bde2d",
   597 => x"92fb0475",
   598 => x"08802ea2",
   599 => x"38750851",
   600 => x"89912d99",
   601 => x"e8088106",
   602 => x"5271802e",
   603 => x"8b389ab8",
   604 => x"08518416",
   605 => x"0852712d",
   606 => x"88165675",
   607 => x"da388054",
   608 => x"800b99fc",
   609 => x"0c738f06",
   610 => x"99f80ca0",
   611 => x"52739ab8",
   612 => x"082e0981",
   613 => x"0698389a",
   614 => x"b408ff05",
   615 => x"74327009",
   616 => x"81057072",
   617 => x"079f2a91",
   618 => x"71315151",
   619 => x"53537151",
   620 => x"82f82d81",
   621 => x"14548e74",
   622 => x"25c63899",
   623 => x"e4085271",
   624 => x"99e80c02",
   625 => x"98050d04",
   626 => x"00ffffff",
   627 => x"ff00ffff",
   628 => x"ffff00ff",
   629 => x"ffffff00",
   630 => x"20203d20",
   631 => x"204d5358",
   632 => x"2d582020",
   633 => x"203d2020",
   634 => x"20000000",
   635 => x"2020204e",
   636 => x"6575726f",
   637 => x"52756c65",
   638 => x"7a202000",
   639 => x"52657365",
   640 => x"74000000",
   641 => x"45786974",
   642 => x"00000000",
   643 => x"4b65796d",
   644 => x"61702045",
   645 => x"53000000",
   646 => x"4b65796d",
   647 => x"61702045",
   648 => x"4e000000",
   649 => x"4b65796d",
   650 => x"61702042",
   651 => x"52000000",
   652 => x"4b65796d",
   653 => x"61702046",
   654 => x"52000000",
   655 => x"4f504c33",
   656 => x"20536f75",
   657 => x"6e642059",
   658 => x"65730000",
   659 => x"4f504c33",
   660 => x"20536f75",
   661 => x"6e64204e",
   662 => x"6f000000",
   663 => x"52616d20",
   664 => x"32303438",
   665 => x"4b420000",
   666 => x"52616d20",
   667 => x"34303936",
   668 => x"4b420000",
   669 => x"536c6f74",
   670 => x"20313a20",
   671 => x"456d7074",
   672 => x"79000000",
   673 => x"536c6f74",
   674 => x"20313a20",
   675 => x"4d656761",
   676 => x"5343432b",
   677 => x"20324d42",
   678 => x"536c6f74",
   679 => x"20313a20",
   680 => x"4d656761",
   681 => x"72616d20",
   682 => x"324d4200",
   683 => x"536c6f74",
   684 => x"20313a20",
   685 => x"4d656761",
   686 => x"72616d20",
   687 => x"314d4200",
   688 => x"536c6f74",
   689 => x"20313a20",
   690 => x"4d656761",
   691 => x"5343432b",
   692 => x"20314d42",
   693 => x"00000000",
   694 => x"536c6f74",
   695 => x"20303a20",
   696 => x"45787061",
   697 => x"6e646564",
   698 => x"00000000",
   699 => x"536c6f74",
   700 => x"20303a20",
   701 => x"5072696d",
   702 => x"61727900",
   703 => x"43505520",
   704 => x"436c6f63",
   705 => x"6b204e6f",
   706 => x"726d616c",
   707 => x"00000000",
   708 => x"43505520",
   709 => x"436c6f63",
   710 => x"6b205475",
   711 => x"72626f00",
   712 => x"426c656e",
   713 => x"64206f66",
   714 => x"66000000",
   715 => x"426c656e",
   716 => x"64206f6e",
   717 => x"00000000",
   718 => x"5363616e",
   719 => x"6c696e65",
   720 => x"73204e6f",
   721 => x"6e650000",
   722 => x"5363616e",
   723 => x"6c696e65",
   724 => x"73204352",
   725 => x"54203235",
   726 => x"25000000",
   727 => x"5363616e",
   728 => x"6c696e65",
   729 => x"73204352",
   730 => x"54203530",
   731 => x"25000000",
   732 => x"5363616e",
   733 => x"6c696e65",
   734 => x"73204352",
   735 => x"54203735",
   736 => x"25000000",
   737 => x"16200000",
   738 => x"14200000",
   739 => x"15200000",
   740 => x"00000002",
   741 => x"00000002",
   742 => x"000009d8",
   743 => x"00000000",
   744 => x"00000002",
   745 => x"000009ec",
   746 => x"00000000",
   747 => x"00000002",
   748 => x"000009fc",
   749 => x"000002d1",
   750 => x"00000003",
   751 => x"00000c88",
   752 => x"00000004",
   753 => x"00000003",
   754 => x"00000c80",
   755 => x"00000002",
   756 => x"00000003",
   757 => x"00000c78",
   758 => x"00000002",
   759 => x"00000003",
   760 => x"00000c70",
   761 => x"00000002",
   762 => x"00000003",
   763 => x"00000c68",
   764 => x"00000002",
   765 => x"00000003",
   766 => x"00000c5c",
   767 => x"00000004",
   768 => x"00000003",
   769 => x"00000c54",
   770 => x"00000002",
   771 => x"00000003",
   772 => x"00000c4c",
   773 => x"00000002",
   774 => x"00000003",
   775 => x"00000c3c",
   776 => x"00000004",
   777 => x"00000002",
   778 => x"00000a04",
   779 => x"0000057c",
   780 => x"00000000",
   781 => x"00000000",
   782 => x"00000000",
   783 => x"00000a0c",
   784 => x"00000a18",
   785 => x"00000a24",
   786 => x"00000a30",
   787 => x"00000a3c",
   788 => x"00000a4c",
   789 => x"00000a5c",
   790 => x"00000a68",
   791 => x"00000a74",
   792 => x"00000a84",
   793 => x"00000aac",
   794 => x"00000a74",
   795 => x"00000ac0",
   796 => x"00000ad8",
   797 => x"00000aec",
   798 => x"00000afc",
   799 => x"00000b10",
   800 => x"00000b20",
   801 => x"00000b2c",
   802 => x"00000b38",
   803 => x"00000b48",
   804 => x"00000b5c",
   805 => x"00000b70",
   806 => x"00000000",
   807 => x"00000000",
   808 => x"00000000",
   809 => x"00000000",
   810 => x"00000000",
   811 => x"00000000",
   812 => x"00000000",
   813 => x"00000000",
   814 => x"00000000",
   815 => x"00000000",
   816 => x"00000000",
   817 => x"00000000",
   818 => x"00000000",
   819 => x"00000000",
   820 => x"00000000",
   821 => x"00000000",
   822 => x"00000000",
   823 => x"00000000",
   824 => x"00000000",
   825 => x"00000000",
	others => x"00000000"
);

begin

process (clk)
begin
	if (clk'event and clk = '1') then
		if (from_zpu.memAWriteEnable = '1') and (from_zpu.memBWriteEnable = '1') and (from_zpu.memAAddr=from_zpu.memBAddr) and (from_zpu.memAWrite/=from_zpu.memBWrite) then
			report "write collision" severity failure;
		end if;
	
		if (from_zpu.memAWriteEnable = '1') then
			ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBitBRAM downto 2)))) := from_zpu.memAWrite;
			to_zpu.memARead <= from_zpu.memAWrite;
		else
			to_zpu.memARead <= ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBitBRAM downto 2))));
		end if;
	end if;
end process;

process (clk)
begin
	if (clk'event and clk = '1') then
		if (from_zpu.memBWriteEnable = '1') then
			ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBitBRAM downto 2)))) := from_zpu.memBWrite;
			to_zpu.memBRead <= from_zpu.memBWrite;
		else
			to_zpu.memBRead <= ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBitBRAM downto 2))));
		end if;
	end if;
end process;


end arch;

