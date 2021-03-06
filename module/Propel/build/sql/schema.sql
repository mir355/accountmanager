
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- account
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account`
(
    `id` INTEGER(3) NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER(4) NOT NULL,
    `identifier` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255),
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `account_U_1` (`user_id`, `identifier`),
    INDEX `account_I_1` (`create_time`),
    INDEX `account_I_2` (`update_time`),
    CONSTRAINT `account_FK_1`
        FOREIGN KEY (`user_id`)
        REFERENCES `user` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='账号表';

-- ---------------------------------------------------------------------
-- category
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category`
(
    `id` INTEGER(4) NOT NULL AUTO_INCREMENT,
    `pid` INTEGER(4),
    `child_count` INTEGER(2) NOT NULL,
    `user_id` INTEGER(4) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `category_I_1` (`create_time`),
    INDEX `category_I_2` (`update_time`),
    INDEX `category_FI_1` (`pid`),
    INDEX `category_FI_2` (`user_id`),
    CONSTRAINT `category_FK_1`
        FOREIGN KEY (`pid`)
        REFERENCES `category` (`id`)
        ON DELETE CASCADE,
    CONSTRAINT `category_FK_2`
        FOREIGN KEY (`user_id`)
        REFERENCES `user` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='资源类别表';

-- ---------------------------------------------------------------------
-- resource
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `resource`;

CREATE TABLE `resource`
(
    `id` INTEGER(4) NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER(4) NOT NULL,
    `name` VARCHAR(128) NOT NULL,
    `description` TEXT,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`,`category_id`),
    INDEX `resource_I_1` (`create_time`),
    INDEX `resource_I_2` (`update_time`),
    INDEX `resource_FI_1` (`category_id`),
    CONSTRAINT `resource_FK_1`
        FOREIGN KEY (`category_id`)
        REFERENCES `category` (`id`)
) ENGINE=InnoDB COMMENT='资源表';

-- ---------------------------------------------------------------------
-- resource_account
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `resource_account`;

CREATE TABLE `resource_account`
(
    `id` INTEGER(4) NOT NULL AUTO_INCREMENT,
    `resource_id` INTEGER(4) NOT NULL,
    `account_id` INTEGER(3) NOT NULL,
    `identity` VARCHAR(255) NOT NULL,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `resource_account_U_1` (`resource_id`, `account_id`, `identity`),
    INDEX `resource_account_I_1` (`create_time`),
    INDEX `resource_account_I_2` (`update_time`),
    INDEX `resource_account_FI_2` (`account_id`),
    CONSTRAINT `resource_account_FK_1`
        FOREIGN KEY (`resource_id`)
        REFERENCES `resource` (`id`),
    CONSTRAINT `resource_account_FK_2`
        FOREIGN KEY (`account_id`)
        REFERENCES `account` (`id`)
) ENGINE=InnoDB COMMENT='资源账号关联表';

-- ---------------------------------------------------------------------
-- user
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user`
(
    `id` INTEGER(4) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL,
    `nickname` VARCHAR(25) NOT NULL,
    `role_id` INTEGER(3) NOT NULL,
    `password` VARCHAR(60) NOT NULL,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `user_U_1` (`name`),
    INDEX `user_FI_1` (`role_id`),
    CONSTRAINT `user_FK_1`
        FOREIGN KEY (`role_id`)
        REFERENCES `role` (`id`)
) ENGINE=InnoDB COMMENT='用户表';

-- ---------------------------------------------------------------------
-- role
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role`
(
    `id` INTEGER(3) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `role_U_1` (`name`)
) ENGINE=InnoDB COMMENT='角色';

-- ---------------------------------------------------------------------
-- session
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session`
(
    `id` VARCHAR(32) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    `create_time` DATETIME NOT NULL,
    `update_time` DATETIME NOT NULL,
    `data` VARCHAR(21000),
    PRIMARY KEY (`id`,`name`)
) ENGINE=MEMORY COMMENT='session';

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
