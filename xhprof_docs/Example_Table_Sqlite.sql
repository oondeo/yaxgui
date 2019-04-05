CREATE TABLE `details`
(
    `id`                     char(17)  NOT NULL,
    `url`                    varchar(255)       default NULL,
    `c_url`                  varchar(255)       default NULL,
    `timestamp`              timestamp NOT NULL default CURRENT_TIMESTAMP,
    `server name`            varchar(64)        default NULL,
    `perfdata`               MEDIUMBLOB,
    `type`                   tinyint(4)         default NULL,
    `cookie`                 BLOB,
    `post`                   BLOB,
    `get`                    BLOB,
    `pmu`                    unsigned int(11)   default NULL,
    `wt`                     unsigned int(11)   default NULL,
    `cpu`                    unsigned int(11)   default NULL,
    `server_id`              char(3)   NOT NULL default 't11',
    `aggregateCalls_include` varchar(255)       DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE INDEX `url` ON details(`url`);
CREATE INDEX `c_url` ON details(`c_url`);
CREATE INDEX `cpu` ON details(`cpu`);
CREATE INDEX `wt` ON details(`wt`);
CREATE INDEX `pmu` ON details(`pmu`);
CREATE INDEX `timestamp` ON details(`timestamp`);

CREATE TRIGGER insert_Timestamp_Trigger
AFTER INSERT ON details
BEGIN
   UPDATE details SET Timestamp =STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

CREATE TRIGGER update_Timestamp_Trigger
AFTER UPDATE On details
BEGIN
   UPDATE details SET Timestamp = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;