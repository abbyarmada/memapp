CREATE TABLE `barcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2972 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `boats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `boat_name` varchar(255) DEFAULT NULL,
  `boat_type` varchar(255) DEFAULT NULL,
  `boat_class` varchar(255) DEFAULT NULL,
  `sail_number` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pen_tag` varchar(255) DEFAULT 'None Assigned',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `BoatsMembers` (`member_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1584 DEFAULT CHARSET=latin1;

CREATE TABLE `loyaltycards` (
  `id` int(11) NOT NULL DEFAULT '0',
  `Member_Title` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Member_Forename` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Member_Middlenames` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Member_Surname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address_1` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address_2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address_3` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Town_City` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `County` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Post_Code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Home_Telephone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Work_Telephone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Mobile_Telephone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Company_Name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `Gender` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Cards_Issued_TD` int(11) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Scheme_Code` int(11) DEFAULT NULL,
  `Data_Protection_Flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Link_Member_Code` int(11) DEFAULT NULL,
  `Date_Registered` date DEFAULT NULL,
  `Points_Claimed` float DEFAULT NULL,
  `Average_Points_Claimed` float DEFAULT NULL,
  `RedeemedTD` int(11) DEFAULT NULL,
  `Current_Points` int(11) DEFAULT NULL,
  `Total_Points_Issued` int(11) DEFAULT NULL,
  `Average_Points_Issued` float DEFAULT NULL,
  `IssuedTD` int(11) DEFAULT NULL,
  `Total_Spend` float DEFAULT NULL,
  `Average_Spend` float DEFAULT NULL,
  `Loyalty_Transactions_TD` int(11) DEFAULT NULL,
  `Date_Of_Last_Trans` date DEFAULT NULL,
  `Date_Of_Last_Redemption` date DEFAULT NULL,
  `Date_Of_Last_Issue` date DEFAULT NULL,
  `Admissions` int(11) DEFAULT NULL,
  `Last_Admission` date DEFAULT NULL,
  `Declined` int(11) DEFAULT NULL,
  `Last_Declined` date DEFAULT NULL,
  `PicFilePath` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LastContactedDate` date DEFAULT NULL,
  `Status` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMail` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DOBD` int(11) DEFAULT NULL,
  `Scheme_Changed` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INTFlag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SEREAL_NUMBER` int(11) DEFAULT NULL,
  `Membership_Type` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Last_Renewal_Date` date DEFAULT NULL,
  `Member_Code` int(11) DEFAULT NULL,
  `Rewnewed_2009` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Renewed_Date` date DEFAULT NULL,
  `Renewed_2008` date DEFAULT NULL,
  `Bar_Billies` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Saluation` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `House_Name_No` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Occupation` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Social` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Racing` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Cruser` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Dinghy` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Junor` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `City` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Country` varchar(510) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MerberShipId` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `proposed` varchar(255) DEFAULT NULL,
  `seconded` varchar(255) DEFAULT NULL,
  `year_joined` int(11) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `renew_date` datetime DEFAULT NULL,
  `privilege_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name_no` varchar(255) DEFAULT NULL,
  `street1` varchar(255) DEFAULT NULL,
  `street2` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `county` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email_renewal` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `priv` (`privilege_id`),
  KEY `MemRenew` (`renew_date`)
) ENGINE=MyISAM AUTO_INCREMENT=9052 DEFAULT CHARSET=latin1;

CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `date_lodged` datetime DEFAULT NULL,
  `pay_type` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `privilege_id` int(11) NOT NULL,
  `paymenttype_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PayMembers` (`member_id`),
  KEY `Date` (`date_lodged`)
) ENGINE=MyISAM AUTO_INCREMENT=6852 DEFAULT CHARSET=latin1;

CREATE TABLE `paymenttypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=FIXED;

CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `child_dob` varchar(255) DEFAULT NULL,
  `home_phone` varchar(255) DEFAULT NULL,
  `mobile_phone` varchar(255) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `comm_prefs` varchar(255) DEFAULT NULL,
  `snd_txt` varchar(255) DEFAULT NULL,
  `snd_eml` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `member_number` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `txt_bridge` int(11) NOT NULL DEFAULT '0',
  `txt_social` int(11) NOT NULL DEFAULT '0',
  `txt_crace` int(11) NOT NULL DEFAULT '0',
  `txt_cruiser_race_skipper` int(11) NOT NULL DEFAULT '0',
  `txt_cruising` int(11) NOT NULL DEFAULT '0',
  `txt_cruiser_skipper` int(11) NOT NULL DEFAULT '0',
  `txt_dinghy_sailing` int(11) NOT NULL DEFAULT '0',
  `txt_junior` int(11) NOT NULL DEFAULT '0',
  `txt_test` int(11) NOT NULL DEFAULT '0',
  `txt_op_co` int(11) NOT NULL DEFAULT '0',
  `occupation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PeoMembers` (`member_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2987 DEFAULT CHARSET=latin1;

CREATE TABLE `peoplebarcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `barcard_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `people` (`person_id`),
  KEY `barcards` (`barcard_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5365 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `privileges` (
  `member_class` char(1) NOT NULL,
  `name` char(50) NOT NULL,
  `bar_billies` char(1) NOT NULL DEFAULT 'N',
  `car_park` int(11) NOT NULL DEFAULT '0',
  `votes` int(10) unsigned NOT NULL DEFAULT '0',
  `bar_reference` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `boat_storage` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `subscriptions` (
  `amount` float NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `privilege_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versioned_id` int(11) DEFAULT NULL,
  `versioned_type` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `modifications` text,
  `number` int(11) DEFAULT NULL,
  `reverted_from` int(11) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

INSERT INTO schema_migrations (version) VALUES ('11');