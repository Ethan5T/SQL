
CREATE TABLE Zone (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    friendlyName VARCHAR(255) NOT NULL,
    illegalConnectionCount INT,
    maxUsage FLOAT
);

CREATE TABLE Buildings (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    friendlyName VARCHAR(255) NOT NULL,
    buildingType VARCHAR(255),
    powerDrain FLOAT,
    zoneId CHAR(36),
    FOREIGN KEY (zoneId) REFERENCES Zone(id)
);


CREATE TABLE PowerModule (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    friendlyName VARCHAR(255) NOT NULL,
    baseCost FLOAT,
    upkeepCost FLOAT,
    transferRate FLOAT,
    canStorePower BOOLEAN,
    powerUnit VARCHAR(10),  -- "AC"/"DC"
    age INT
);


CREATE TABLE BuildingPowerModule (
    buildingId CHAR(36),
    powerModuleId CHAR(36),
    PRIMARY KEY (buildingId, powerModuleId),
    FOREIGN KEY (buildingId) REFERENCES Buildings(id),
    FOREIGN KEY (powerModuleId) REFERENCES PowerModule(id)
);


CREATE TABLE PowerInformation (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    buildingId CHAR(36) UNIQUE,
    rateOfUsage FLOAT,
    FOREIGN KEY (buildingId) REFERENCES Buildings(id)
);


CREATE TABLE Event (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    friendlyName VARCHAR(255) NOT NULL,
    type VARCHAR(255)
);

CREATE TABLE EventBuff (
    eventId CHAR(36),
    buff VARCHAR(255),
    PRIMARY KEY (eventId, buff),
    FOREIGN KEY (eventId) REFERENCES Event(id)
);

CREATE TABLE Sponsor (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    friendlyName VARCHAR(255) NOT NULL,
    baseFunding FLOAT
);


CREATE TABLE Challenge (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    challengeText TEXT NOT NULL,
    objType VARCHAR(255),
    quantity INT,
    reward FLOAT
);

CREATE TABLE SponsorChallenge (
    sponsorId CHAR(36),
    challengeId CHAR(36),
    PRIMARY KEY (sponsorId, challengeId),
    FOREIGN KEY (sponsorId) REFERENCES Sponsor(id),
    FOREIGN KEY (challengeId) REFERENCES Challenge(id)
);


CREATE TABLE Log (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    timestamp INT,
    eventId CHAR(36) NULL,
    buildingId CHAR(36),
    content TEXT,
    FOREIGN KEY (eventId) REFERENCES Event(id),
    FOREIGN KEY (buildingId) REFERENCES Buildings(id)
);
