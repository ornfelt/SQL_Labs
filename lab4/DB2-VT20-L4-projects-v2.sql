/****************************************/
/* DB2-VT20-L4-projects     			*/
/* Senast ändrad: 2019-12-12 			*/
/****************************************/
create table projects (
	id INT not null primary key auto_increment, 
	name VARCHAR(50),
	description VARCHAR(50),
	supervisor INT,
	start_date DATE,
	end_date DATE
);

insert into projects (name, description, supervisor, start_date, end_date) values ('Sql4life', 'Universal awesome activity', 364, '2015-12-24', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Ventosanzap', 'Intuitive systemic protocol', 791, '2013-03-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Stringtough', 'Organic context-sensitive open system', 467, '2018-04-18', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Tin', 'Assimilated empowering architecture', 546, '2015-01-22', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Hogwar', 'Integrated context-sensitive productivity', 293, '2013-05-27', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Fintone', 'Quality-focused bottom-line application', 903, '2013-04-01', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Y-Solowarm', 'Persevering responsive service-desk', 692, '2017-08-12', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Daltfresh', 'Optional homogeneous access', 990, '2014-10-04', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Cardguard', 'Triple-buffered hybrid secured line', 368, '2016-08-01', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Hatity', 'Automated 24 hour functionalities', 297, '2016-09-23', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Asoka', 'Devolved tertiary conglomeration', 855, '2016-11-06', '2019-12-01');
insert into projects (name, description, supervisor, start_date, end_date) values ('Zoolab Mars', 'Up-sized eco-centric strategy', 312, '2016-09-29', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Zoolab Jupiter', 'Inverse high-level framework', 809, '2013-02-20', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Domainer', 'Assimilated static utilisation', 753, '2015-08-07', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('X-Solowarm', 'Managed value-added knowledge user', 946, '2018-01-16', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Alpha Bravo', 'Vision-oriented client-driven groupware', 559, '2017-02-25', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Slab', 'Enhanced coherent time-frame', 868, '2019-05-01', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Sonsing', 'Total eco-centric benchmark', 676, '2018-08-13', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('CenCon', 'Centralized bottom-line system engine', 636, '2013-02-16', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Viva', 'User-friendly contextually-based methodology', 236, '2016-03-10', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Softer', 'Synchronised coherent groupware', 352, '2013-06-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('It', 'Up-sized encompassing focus group', 858, '2019-07-06', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('DB2', 'Robust coherent productivity', 539, '2013-10-22', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Redhold', 'Versatile client-driven local area network', 988, '2014-01-07', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Traxon', 'Visionary 24/7 product', 216, '2014-08-12', '2020-01-23');
insert into projects (name, description, supervisor, start_date, end_date) values ('Zontrax', 'Self-enabling multimedia portal', 242, '2013-03-21', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Job', 'Secured systemic ability', 418, '2017-10-03', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Aerified', 'Front-line modular infrastructure', 676, '2013-09-06', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Solarbreeze-1', 'Inverse fresh-thinking secured line', 744, '2016-05-21', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Solarbreeze-2', 'Visionary maximized protocol', 993, '2019-05-21', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Bitchip', 'Compatible even-keeled artificial intelligence', 599, '2019-09-25', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Opela', 'Mandatory fresh-thinking attitude', 599, '2016-03-17', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Vagram', null, 845, '2017-11-16', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Voyatouch', 'Organic secondary toolset', 778, '2018-11-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Pinkhold', 'Enterprise-wide zero defect internet solution', 210, '2016-06-20', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Quo Lux', null, 814, '2016-04-13', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Stronghold', 'Visionary responsive throughput', 795, '2015-12-03', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Alpha Beholder', 'Organic zero defect throughput', 991, '2019-10-25', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Opela-2', 'Upgradable bottom-line parallelism', 881, '2015-07-08', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Namfix', 'Enhanced multi-tasking time-frame', 559, '2018-02-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Lotlux', 'Distributed secondary info-mediaries', 718, '2019-06-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Toughjoyfax', 'Up-sized systemic analyzer', 837, '2016-08-14', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Home Ing', 'Synchronised interactive interface', 575, '2014-06-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Bluelam', 'Visionary responsive process improvement', 923, '2019-06-05', '2019-11-30');
insert into projects (name, description, supervisor, start_date, end_date) values ('Prioioio', 'Future-proofed zero defect access', 511, '2013-06-22', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Greenlam', 'Front-line attitude-oriented benchmark', 325, '2017-04-18', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Bamity', 'Mandatory fresh-thinking flexibility', 907, '2017-05-02', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Bytecard', 'Sharable executive open architecture', 897, '2015-04-09', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('TeknoBlade', 'Fully-configurable full-range access', 744, '2015-12-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Kanlam', 'Reverse-engineered dynamic artificial intelligence', 523, '2013-10-25', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Lotstring', 'Persistent mobile emulation', 356, '2017-02-10', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Sansang', 'Self-enabling coherent frame', 430, '2019-06-02', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Waterdeep', 'Directional paradigm nat20', 886, '2015-11-02', '2019-11-27');
insert into projects (name, description, supervisor, start_date, end_date) values ('Fintone2000', 'Down-sized regional architecture', 361, '2018-05-22', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Duobam', null, 503, '2016-09-30', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Trippledex', 'Business-focused stable array', 845, '2017-05-29', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Multilevel 44', 'Up-sized national utilisation', 501, '2017-07-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Mad Mage', 'Multi-channelled demand-driven yawning portal', 325, '2016-03-28', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Fixflex', 'User-friendly directional data-warehouse', 938, '2014-09-23', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Googlio', null, 865, '2017-02-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Stockh', 'Synchronised high-level moratorium', 615, '2017-11-06', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Zoolab Alpha', 'Phased coherent strategy', 957, '2015-07-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Pannier', 'Progressive modular attitude', 893, '2015-09-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Deepwater', 'Customer-focused system-worthy architecture', 492, '2017-08-05', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Litlux', 'Stand-alone bandwidth-monitored customer loyalty', 768, '2013-10-08', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Wrapsafe', 'Profit-focused disintermediate capacity', 725, '2014-02-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Konklab', 'Right-sized high-level artificial intelligence', 685, '2018-03-20', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Biodex', 'Operative high-level database', 720, '2016-01-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Alpha', 'Streamlined zero defect help-desk', 486, '2019-04-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Matsoft', 'Visionary grid-enabled help-desk', 768, '2017-10-20', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Overhold', 'Multi-lateral dedicated neural-net', 531, '2013-12-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Luxio', 'Up-sized solution-oriented middleware', 368, '2014-07-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Sonair', 'Sharable high-level collaboration', 407, '2019-03-03', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Voltsillam', 'Triple-buffered radical neural-net', 373, '2013-02-25', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Flexidy', 'Integrated encompassing internet solution', 541, '2016-03-07', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Flowdesk', 'Decentralized stable support', 895, '2016-09-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Prodder', 'Vision-oriented tangible parallelism', 834, '2018-12-06', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Right-sized', 'User-centric coherent firmware', 548, '2013-11-04', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('motivating', 'Secured even-keeled open system', 354, '2014-04-10', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('projection', 'Distributed hybrid collaboration', 322, '2018-02-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Polarised', 'Front-line solution-oriented policy', 321, '2013-09-07', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('orchestration', 'Synchronised bandwidth-monitored superstructure', 396, '2019-02-13', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('upward-trending', 'Robust discrete forecast', 679, '2016-02-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Down-sized', 'Integrated motivating benchmark', 440, '2018-12-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('neural-net', 'Multi-layered dynamic forecast', 327, '2018-07-31', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('executive', 'Total optimal approach', 905, '2018-08-26', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('time-frame', 'Diverse intermediate complexity', 576, '2016-04-18', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Public-key', 'Future-proofed 4th generation Graphic Interface', 426, '2013-02-10', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Horizontal', 'Organic uniform methodology', 593, '2014-12-24', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('real-time', 'Secured local encryption', 510, '2019-10-11', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Operative', 'Stand-alone dynamic matrix', 482, '2014-03-01', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('application', 'Reactive interactive matrices', 201, '2017-07-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('matrices', 'Seamless full-range extranet', 610, '2017-09-19', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('encompassing', 'Up-sized modular task-force', 344, '2013-12-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('Devolved', 'Persevering didactic support', 716, '2018-02-21', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('benchmark', 'Secured client-driven standardization', 764, '2019-02-15', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('productivity', 'Operative 5th generation circuit', 593, '2019-03-18', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('contextually-based', 'Polarised empowering portal', 778, '2019-10-05', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('dynamic', 'Versatile responsive policy', 817, '2018-05-31', null);
insert into projects (name, description, supervisor, start_date, end_date) values ('database', 'Streamlined secondary time-frame', 307, '2015-03-04', null);	