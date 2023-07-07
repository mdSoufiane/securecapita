########################################################
####                                                ####
#### Author : Soufiane DAHBI                        ####
#### Licence:                                       ####
#### Date: July 5th, 2023                           ####
#### Version: 1.0                                   ####
####                                                ####
########################################################

/*
* --- general rules ---
* use underscore_names instead of camelcase
* table names should be plural
* spell out id fields (item_id instead of id)
* don't use ambiguous column names
* name foreign key columns the same as the columns they refer to
* Use caps for all SQL queries
 */

CREATE SCHEMA IF NOT EXISTS securecapita;

SET NAMES 'UTF8MB4';
SET TIME_ZONE = SYSTEM;
SET TIME_ZONE = '+1:00';

USE securecapita;

Drop TABLE IF EXISTS Users;
CREATE TABLE Users
(
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    password     VARCHAR(255) DEFAULT NULL,
    address      VARCHAR(255) DEFAULT NULL,
    phone        VARCHAR(30) DEFAULT NULL,
    title        VARCHAR(50) DEFAULT NULL,
    bio          VARCHAR(255) DEFAULT NULL,
    enabled      BOOLEAN DEFAULT FALSE,
    non_locked   BOOLEAN DEFAULT FALSE,
    using_mfa    BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    image_url    VARCHAR(255) DEFAULT 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    CONSTRAINT UQ_Users_Email UNIQUE (email)
);
Drop TABLE IF EXISTS Roles;
CREATE TABLE Roles
(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    permission  VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_Roles_Name UNIQUE (name)
);
Drop TABLE IF EXISTS UserRoles;
CREATE TABLE UserRoles
(
    id       BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id  BIGINT UNSIGNED NOT NULL,
    role_id  BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES Roles(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UQ_UserRoles_User_Id UNIQUE (user_id)
);

Drop TABLE IF EXISTS Events;
CREATE TABLE Events
(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type        VARCHAR(50) NOT NULL CHECK ( type in('LOGIN_ATTEMPT','LOGIN_ATTEMPT_FAILURE','LOGIN_ATTEMPT_SUCCESS','PROFILE_UPDATE','PROFILE_PICTURE_UPDATE','ROLE_UPDATE','ACCOUNT_SETTINGS_UPDATE','PASSWORD_UPDATE','MFA_UPDATE') ),
    description VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_Events_Type UNIQUE (type)
);

Drop TABLE IF EXISTS UserEvents;
CREATE TABLE UserEvents
(
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id      BIGINT UNSIGNED NOT NULL,
    event_id     BIGINT UNSIGNED NOT NULL,
    device       varchar(100) default null,
    ip_address   varchar(100) default null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Events(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
Drop TABLE IF EXISTS AccountVerification;
CREATE TABLE AccountVerification
(
    id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    url     varchar(255) not null,
    -- date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_AccountVerification_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_AccountVerification_url UNIQUE (url)
);
Drop TABLE IF EXISTS ResetPasswordVerification;
CREATE TABLE ResetPasswordVerification
(
    id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED NOT NULL,
    url             varchar(255) not null,
    expiration_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_ResetPasswordVerification_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_ResetPasswordVerification_url UNIQUE (url)
);
Drop TABLE IF EXISTS TwoFactorVerification;
CREATE TABLE TwoFactorVerification
(
    id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED NOT NULL,
    code            varchar(10) not null,
    expiration_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_TwoFactorVerification_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_TwoFactorVerification_code UNIQUE (code)
);









