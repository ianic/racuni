CREATE TABLE `partner` (
  `id` int(11) NOT NULL auto_increment,
  `naziv` varchar(255) default NULL,
  `adresa` varchar(255) default NULL,
  `mjesto` varchar(255) default NULL,
  `tel` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `porezni_broj` varchar(255) default NULL,
  `ziro_racun` varchar(255) default NULL,
  `kontakt` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `racun` (
  `id` int(11) NOT NULL auto_increment,
  `partner_id` int(11) default NULL,
  `broj` varchar(255) default NULL,
  `datum` date default NULL,
  `dospjece` date default NULL,
  `popust_postotak` float default NULL,
  `pdv_postotak` float default NULL,
  `napomena` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `racun__` (
  `id` int(11) NOT NULL auto_increment,
  `partner_id` int(11) default NULL,
  `broj` varchar(255) default NULL,
  `datum` date default NULL,
  `dospjece` date default NULL,
  `osnovica` float default NULL,
  `popust_postotak` float default NULL,
  `popust` float default NULL,
  `pdv_postotak` float default NULL,
  `pdv` float default NULL,
  `iznos` float default NULL,
  `napomena` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `racun_placanje` (
  `id` int(11) NOT NULL auto_increment,
  `racun_id` int(11) default NULL,
  `datum` date default NULL,
  `iznos` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `racun_stavka` (
  `id` int(11) NOT NULL auto_increment,
  `racun_id` int(11) default NULL,
  `opis` text,
  `jedinica_mjere` varchar(255) default NULL,
  `cijena` float default NULL,
  `kolicina` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

