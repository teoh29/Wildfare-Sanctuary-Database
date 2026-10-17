ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';


DROP TABLE FinanceTransaction CASCADE CONSTRAINTS;
DROP TABLE PaySlip CASCADE CONSTRAINTS;
DROP TABLE AnimalKeeper CASCADE CONSTRAINTS;
DROP TABLE AnimalDonation CASCADE CONSTRAINTS;
DROP TABLE Adoption CASCADE CONSTRAINTS;
DROP TABLE HealthCheck CASCADE CONSTRAINTS;
DROP TABLE Vaccinations CASCADE CONSTRAINTS;
DROP TABLE Tasks CASCADE CONSTRAINTS;
DROP TABLE Volunteers CASCADE CONSTRAINTS;
DROP TABLE Keepers CASCADE CONSTRAINTS;
DROP TABLE Donation CASCADE CONSTRAINTS;
DROP TABLE Donor CASCADE CONSTRAINTS;
DROP TABLE Adopter CASCADE CONSTRAINTS;
DROP TABLE AnimalResidence CASCADE CONSTRAINTS;
DROP TABLE Residences CASCADE CONSTRAINTS;
DROP TABLE Animals CASCADE CONSTRAINTS;



CREATE TABLE Animals (
    animal_id NUMERIC(5) PRIMARY KEY,
    animal_name VARCHAR2(20) NOT NULL,
    species VARCHAR2(15) NOT NULL,
    breed VARCHAR2(20) NOT NULL,
    gender VARCHAR2(6) NOT NULL,
    age NUMERIC(2) CHECK (age > 0) NOT NULL,
    arrival_date DATE NOT NULL,
    status VARCHAR2(20) NOT NULL
);

CREATE TABLE Residences (
    residence_id NUMERIC(5) PRIMARY KEY,
    residence_name VARCHAR2(20) NOT NULL,
    capacity NUMERIC(2) NOT NULL,
    current_occupancy NUMERIC(2) NOT NULL,
    availability CHAR(1) NOT NULL,
    cleaning_status VARCHAR2(14) NOT NULL
);

CREATE TABLE AnimalResidence (
    animal_id NUMERIC(5) NOT NULL,
    residence_id NUMERIC(5) NOT NULL,
    PRIMARY KEY (animal_id, residence_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (residence_id) REFERENCES Residences(residence_id)
);


CREATE TABLE Volunteers (
    volunteer_id NUMERIC(5) PRIMARY KEY,
    schedule_id NUMERIC(5) NOT NULL,
    volunteer_name VARCHAR2(30) NOT NULL,
    email VARCHAR2(50) UNIQUE NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    availability VARCHAR2(10) NOT NULL
);

CREATE TABLE Tasks (
    task_id NUMERIC(5) PRIMARY KEY,
    volunteer_id NUMERIC(5)NOT NULL,
    animal_id NUMERIC(5) NOT NULL,
    task_type VARCHAR2(20)NOT NULL,
    FOREIGN KEY (volunteer_id) REFERENCES Volunteers(volunteer_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

CREATE TABLE Vaccinations (
    vaccination_id NUMERIC(3) PRIMARY KEY,
    animal_id NUMERIC(5) NOT NULL,
    vaccination_type VARCHAR2(15) NOT NULL,
    vaccination_date DATE NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

CREATE TABLE HealthCheck (
    check_id NUMERIC(5) PRIMARY KEY,
    animal_id NUMERIC(5) NOT NULL,
    check_date DATE NOT NULL,
    vet_name VARCHAR2(30),
    diagnosis VARCHAR2(30),
    treatment VARCHAR2(40),
    health_rating NUMERIC(3) CHECK (health_rating BETWEEN 1 AND 5),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

CREATE TABLE Adopter (
    adopter_id NUMERIC(5) PRIMARY KEY,
    adopter_name VARCHAR2(30) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    address VARCHAR2(30) NOT NULL
);

CREATE TABLE Adoption (
    adoption_id NUMERIC(5) PRIMARY KEY,
    animal_id NUMERIC(5) NOT NULL,
    adopter_id NUMERIC(5) NOT NULL,
    adoption_date DATE NOT NULL,
    adoption_fee NUMERIC(5) NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (adopter_id) REFERENCES Adopter(adopter_id)
);

CREATE TABLE Donor (
    donor_id NUMERIC(5) PRIMARY KEY,
    donor_name VARCHAR2(30) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    address VARCHAR2(50) NOT NULL
);

CREATE TABLE Donation (
    donation_id NUMERIC(5) PRIMARY KEY,
    donor_id NUMERIC(5) NOT NULL,
    total_amount NUMERIC(7,2) NOT NULL,
    donation_date DATE NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES Donor(donor_id)
);

CREATE TABLE AnimalDonation (
    animal_id NUMERIC(5) NOT NULL,
    donation_id NUMERIC(5) NOT NULL,
    support_amount NUMERIC(7,2) NOT NULL,
    PRIMARY KEY (animal_id, donation_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (donation_id) REFERENCES Donation(donation_id)
);

CREATE TABLE Keepers (
    keep_id NUMERIC(5) PRIMARY KEY,
    keeper_name VARCHAR2(30) NOT NULL,
    role VARCHAR2(25) NOT NULL,
    shift VARCHAR2(9) NOT NULL,
    keeper_contact VARCHAR2(30) NOT NULL
);

CREATE TABLE AnimalKeeper (
    animal_id NUMERIC(5) NOT NULL,
    keeper_id NUMERIC(5) NOT NULL,
    PRIMARY KEY (animal_id, keeper_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (keeper_id) REFERENCES Keepers(keep_id)
);

CREATE TABLE PaySlip (
    payslip_id NUMERIC(6) PRIMARY KEY,
    keeper_id NUMERIC(5) NOT NULL,
    pay_date DATE NOT NULL,
    net_salary NUMERIC(8,2) CHECK (net_salary >= 0),
    paymentMethod VARCHAR2(20) NOT NULL,
    FOREIGN KEY (keeper_id) REFERENCES Keepers(keep_id)
);

CREATE TABLE FinanceTransaction (
    transaction_id NUMERIC(5) PRIMARY KEY,
    donation_id NUMERIC(5) ,
    payslip_id NUMERIC(6) ,
    transaction_type VARCHAR2(20) NOT NULL,
    amount NUMERIC(7,2) NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (donation_id) REFERENCES Donation(donation_id),
    FOREIGN KEY (payslip_id) REFERENCES PaySlip(payslip_id)
);

-- Animals
INSERT INTO Animals VALUES (101, 'Buddy', 'Dog', 'Golden Retriever', 'Male', 3, '01-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (102, 'Mittens', 'Cat', 'Siamese', 'Female', 2, '03-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (103, 'Rocky', 'Parrot', 'African Grey', 'Male', 4, '07-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (104, 'Luna', 'Rabbit', 'Holland Lop', 'Female', 1, '05-JAN-2023', 'Available');
INSERT INTO Animals VALUES (105, 'Charlie', 'Guinea Pig', 'American', 'Male', 2, '11-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (106, 'Bella', 'Dog', 'Labrador', 'Female', 5, '09-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (107, 'Simba', 'Lizard', 'Bearded Dragon', 'Male', 3, '17-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (108, 'Daisy', 'Hamster', 'Syrian', 'Female', 2, '13-JAN-2023', 'Medical Hold');
INSERT INTO Animals VALUES (109, 'Max', 'Dog', 'German Shepherd', 'Male', 3, '15-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (110, 'Whiskers', 'Cat', 'Persian', 'Female', 2, '22-JAN-2023', 'Available');
INSERT INTO Animals VALUES (111, 'Polly', 'Parrot', 'Macaw', 'Female', 4, '18-JAN-2023', 'Available');
INSERT INTO Animals VALUES (112, 'Oscar', 'Bird', 'Cockatiel', 'Male', 5, '26-JAN-2023', 'Available');
INSERT INTO Animals VALUES (113, 'Peanut', 'Guinea Pig', 'Abyssinian', 'Male', 2, '20-JAN-2023', 'Adopted');
INSERT INTO Animals VALUES (114, 'Cooper', 'Dog', 'Beagle', 'Male', 2, '24-JAN-2023', 'Available');
INSERT INTO Animals VALUES (115, 'Cleo', 'Cat', 'Maine Coon', 'Female', 3, '29-JAN-2023', 'Available');


-- Residences
INSERT INTO Residences VALUES (201, 'Kennel A', 3, 3, 'N', 'Clean');
INSERT INTO Residences VALUES (202, 'Kennel B', 3,1, 'Y', 'Clean');
INSERT INTO Residences VALUES (203, 'Cat Room 1', 3,2, 'Y', 'Needs Cleaning');
INSERT INTO Residences VALUES (204, 'Cat Room 2', 3,1, 'Y', 'Needs Cleaning');
INSERT INTO Residences VALUES (205, 'Aviary', 6,3, 'Y', 'In Cleaning');
INSERT INTO Residences VALUES (206, 'Rabbit Hutch', 5,1, 'Y', 'Clean');
INSERT INTO Residences VALUES (207, 'Small Pets', 15,2, 'Y', 'Clean');
INSERT INTO Residences VALUES (208, 'Reptile Room', 5,1, 'Y', 'In Cleaning');
INSERT INTO Residences VALUES (209, 'Rodent Area', 12,1, 'Y', 'In Cleaning');

--AnimalResidences
INSERT INTO AnimalResidence VALUES (101, 201);
INSERT INTO AnimalResidence VALUES (106, 201);
INSERT INTO AnimalResidence VALUES (109, 201);
INSERT INTO AnimalResidence VALUES (114, 202);
INSERT INTO AnimalResidence VALUES (102, 203);
INSERT INTO AnimalResidence VALUES (110, 203);
INSERT INTO AnimalResidence VALUES (115, 204);
INSERT INTO AnimalResidence VALUES (103, 205);
INSERT INTO AnimalResidence VALUES (111, 205);
INSERT INTO AnimalResidence VALUES (112, 205);
INSERT INTO AnimalResidence VALUES (104, 206);
INSERT INTO AnimalResidence VALUES (105, 207);
INSERT INTO AnimalResidence VALUES (113, 207);
INSERT INTO AnimalResidence VALUES (107, 208);
INSERT INTO AnimalResidence VALUES (108, 209);

-- Volunteers
INSERT INTO Volunteers VALUES (301, 401, 'Sarah Nelson', 'sarah.nel@gmail.com', '0137191127', 'Morning');
INSERT INTO Volunteers VALUES (302, 403, 'Michael Brown', 'michael.b@gmail.com', '0173144426', 'Morning');
INSERT INTO Volunteers VALUES (303, 405, 'Emily Davis', 'emily.d@gmail.com', '0127198834', 'Afternoon');
INSERT INTO Volunteers VALUES (304, 407, 'David Wilson', 'david.w@gmail.com', '0115671423', 'Evening');
INSERT INTO Volunteers VALUES (305, 401, 'Jessica Lee', 'jessica.l@gmail.com', '0196784563', 'Afternoon');
INSERT INTO Volunteers VALUES (306, 403, 'Daniel Kim', 'daniel.k@gmail.com', '0148920436', 'Monrning');
INSERT INTO Volunteers VALUES (307, 405, 'Olivia Martinez', 'olivia.m@gmail.com', '0165228520', 'Afternoon');
INSERT INTO Volunteers VALUES (308, 407, 'James Taylor', 'james.t@gmail.com', '0165783456', 'Evening');
INSERT INTO Volunteers VALUES (309, 401, 'Nathan Green', 'nathan.g@gmail.com', '0137889988', 'Morning');
INSERT INTO Volunteers VALUES (310, 403, 'Ava White', 'ava.w@gmail.com', '0173344556', 'Afternoon');
INSERT INTO Volunteers VALUES (311, 405, 'Liam Harris', 'liam.h@gmail.com', '0128991123', 'Evening');
INSERT INTO Volunteers VALUES (312, 407, 'Grace Hall', 'grace.h@gmail.com', '0148899221', 'Morning');
INSERT INTO Volunteers VALUES (313, 401, 'Ethan Moore', 'ethan.m@gmail.com', '0194433221', 'Afternoon');
INSERT INTO Volunteers VALUES (314, 403, 'Sophie King', 'sophie.k@gmail.com', '0167788990', 'Evening');
INSERT INTO Volunteers VALUES (315, 405, 'Lucas Scott', 'lucas.s@gmail.com', '0113344557', 'Morning');

-- Tasks
INSERT INTO Tasks VALUES (501, 301, 101, 'Feeding');
INSERT INTO Tasks VALUES (502, 302, 102, 'Bathing');
INSERT INTO Tasks VALUES (503, 303, 103, 'Medical Check');
INSERT INTO Tasks VALUES (504, 304, 104, 'Exercise');
INSERT INTO Tasks VALUES (505, 305, 105, 'Grooming');
INSERT INTO Tasks VALUES (506, 306, 106, 'Feeding');
INSERT INTO Tasks VALUES (507, 307, 107, 'Training');
INSERT INTO Tasks VALUES (508, 308, 108, 'Medical Check');
INSERT INTO Tasks VALUES (509, 309, 109, 'Cleaning');
INSERT INTO Tasks VALUES (510, 310, 110, 'Exercise');
INSERT INTO Tasks VALUES (511, 311, 111, 'Grooming');
INSERT INTO Tasks VALUES (512, 312, 112, 'Feeding');
INSERT INTO Tasks VALUES (513, 313, 113, 'Medical Check');
INSERT INTO Tasks VALUES (514, 314, 114, 'Training');
INSERT INTO Tasks VALUES (515, 315, 115, 'Play Time');


-- Vaccinations
INSERT INTO Vaccinations VALUES (1, 101, 'Rabies', '02-JAN-2023');
INSERT INTO Vaccinations VALUES (2, 102, 'FVRCP', '04-JAN-2023');
INSERT INTO Vaccinations VALUES (3, 103, 'Polyomavirus', '08-JAN-2023');
INSERT INTO Vaccinations VALUES (4, 104, 'RHDV2', '06-JAN-2023');
INSERT INTO Vaccinations VALUES (5, 105, 'Bordetella', '12-JAN-2023');
INSERT INTO Vaccinations VALUES (6, 106, 'Rabies', '10-JAN-2023');
INSERT INTO Vaccinations VALUES (7, 107, 'Salmonella', '18-JAN-2023');
INSERT INTO Vaccinations VALUES (8, 108, 'LCMV', '14-JAN-2023');
INSERT INTO Vaccinations VALUES (9, 109, 'Rabies', '16-JAN-2023');
INSERT INTO Vaccinations VALUES (10, 110, 'FVRCP', '23-JAN-2023');
INSERT INTO Vaccinations VALUES (11, 111, 'Polyomavirus', '19-JAN-2023');
INSERT INTO Vaccinations VALUES (12, 112, 'Polyomavirus', '27-JAN-2023');
INSERT INTO Vaccinations VALUES (13, 113, 'Bordetella', '21-JAN-2023');
INSERT INTO Vaccinations VALUES (14, 114, 'Rabies', '25-JAN-2023');
INSERT INTO Vaccinations VALUES (15, 115, 'FVRCP', '30-JAN-2023');
INSERT INTO Vaccinations VALUES (16, 102, 'Rabies', '10-JAN-2023');
INSERT INTO Vaccinations VALUES (17, 106, 'Distemper', '15-JAN-2023');
INSERT INTO Vaccinations VALUES (18, 109, 'Distemper', '20-JAN-2023');
INSERT INTO Vaccinations VALUES (19, 110, 'Rabies', '28-JAN-2023');
INSERT INTO Vaccinations VALUES (20, 115, 'Rabies', '02-FEB-2023');


-- HealthCheck
INSERT INTO HealthCheck VALUES (1301, 101, '05-JAN-2023', 'Dr. Smith', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1302, 102, '06-JAN-2023', 'Dr. Johnson', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1303, 103, '07-JAN-2023', 'Dr. Williams', 'Feather Plucking', 'Behavioral therapy', 4);
INSERT INTO HealthCheck VALUES (1304, 104, '08-JAN-2023', 'Dr. Brown', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1305, 105, '09-JAN-2023', 'Dr. Davis', 'Overgrown Teeth', 'Teeth trimming', 3);
INSERT INTO HealthCheck VALUES (1306, 106, '10-JAN-2023', 'Dr. Miller', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1307, 107, '11-JAN-2023', 'Dr. Wilson', 'Mild Dehydration', 'Increased misting', 4);
INSERT INTO HealthCheck VALUES (1308, 108, '12-JAN-2023', 'Dr. Moore', 'Wet Tail', 'Antibiotics', 2);
INSERT INTO HealthCheck VALUES (1309, 109, '13-JAN-2023', 'Dr. Clark', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1310, 110, '14-JAN-2023', 'Dr. Allen', 'Minor cold', 'Rest', 4);
INSERT INTO HealthCheck VALUES (1311, 111, '15-JAN-2023', 'Dr. Adams', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1312, 112, '16-JAN-2023', 'Dr. Lee', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1313, 113, '17-JAN-2023', 'Dr. Harris', 'Mild Ear Infection', 'Ear drops', 4);
INSERT INTO HealthCheck VALUES (1314, 114, '18-JAN-2023', 'Dr. Young', 'Healthy', 'None', 5);
INSERT INTO HealthCheck VALUES (1315, 115, '19-JAN-2023', 'Dr. Wright', 'Overweight', 'Diet plan', 3);
INSERT INTO HealthCheck VALUES (1316, 101, '20-JAN-2023', 'Dr. Smith', 'Checkup after adoption', 'None', 5);
INSERT INTO HealthCheck VALUES (1317, 103, '15-JAN-2023', 'Dr. Williams', 'Improved behavior', 'Continued therapy', 4);
INSERT INTO HealthCheck VALUES (1318, 106, '22-JAN-2023', 'Dr. Miller', 'Tartar buildup', 'Dental cleaning', 4);
INSERT INTO HealthCheck VALUES (1319, 107, '25-JAN-2023', 'Dr. Wilson', 'Recovered from dehydration', 'Monitor regularly', 5);
INSERT INTO HealthCheck VALUES (1320, 115, '02-FEB-2023', 'Dr. Moore', 'Slight weight gain', 'Continue diet', 4);

-- Adopter
INSERT INTO Adopter VALUES (601, 'Robert Adward', '0165839120', 'robert.ad@gmail.com', '123 Main St');
INSERT INTO Adopter VALUES (602, 'Jennifer Smith', '0138923011', 'jennifer.s@gmail.com', '456 Oak Ave');
INSERT INTO Adopter VALUES (603, 'Bella Hadid', '0134321765', 'bella.h@gmail.com', '789 Pine Rd');
INSERT INTO Adopter VALUES (604, 'Lisa Brown', '0117406978', 'lisa.b@gmail.com', '321 Elm St');
INSERT INTO Adopter VALUES (605, 'Christopher Davis', '0172834953', 'chris.d@gmail.com', '654 Maple Dr');
INSERT INTO Adopter VALUES (606, 'Jenny Jane', '0192361428', 'jane.j@gmail.com', '987 Cedar Ln');
INSERT INTO Adopter VALUES (607, 'Matthew Wilson', '0127689348', 'matt.w@gmail.com', '135 Birch Blvd');
INSERT INTO Adopter VALUES (608, 'Jeff Satur', '0178915674', 'jeffs.s@gmail.com', '246 Spruce Way');

-- Adoption
INSERT INTO Adoption VALUES (701, 101, 601, '15-JAN-2023', 150);
INSERT INTO Adoption VALUES (702, 102, 602, '20-FEB-2023', 150);
INSERT INTO Adoption VALUES (703, 103, 603, '25-FEB-2023', 200);
INSERT INTO Adoption VALUES (704, 105, 604, '28-FEB-2023', 100);
INSERT INTO Adoption VALUES (705, 106, 605, '05-MAR-2023', 100);
INSERT INTO Adoption VALUES (706, 107, 606, '10-MAR-2023', 75);
INSERT INTO Adoption VALUES (707, 109, 607, '15-MAR-2023', 100);
INSERT INTO Adoption VALUES (708, 113, 608, '13-APR-2023', 100);
INSERT INTO Adoption VALUES (709, 115, 608, '13-APR-2023', 300);

-- Donor
INSERT INTO Donor VALUES (801, 'William Taylor', '012345678', 'william.t@gmail.com', '159 Oak St');
INSERT INTO Donor VALUES (802, 'Patricia Anderson', '0113478567', 'patricia.a@gmail.com', '357 Pine Ave');
INSERT INTO Donor VALUES (803, 'Richard Thomas', '0198129321', 'richard.t@gmail.com', '753 Maple Rd');
INSERT INTO Donor VALUES (804, 'Linda Jackson', '0146477232', 'linda.j@gmail.com', '951 Cedar Dr');
INSERT INTO Donor VALUES (805, 'Donald White', '0174923753', 'donald.w@gmail.com', '258 Birch Ln');
INSERT INTO Donor VALUES (806, 'Barbara Harris', '0103752945', 'barbara.h@gmail.com', '456 Spruce Blvd');
INSERT INTO Donor VALUES (807, 'Paul Martin', '0168593424', 'paul.m@gmail.com', '654 Elm Way');
INSERT INTO Donor VALUES (808, 'Susan Thompson', '0184724866', 'susan.t@gmail.com', '852 Oak Cir');

-- Donation
INSERT INTO Donation VALUES (901, 801, 500.00, '10-JAN-2023');
INSERT INTO Donation VALUES (902, 802, 250.00, '12-JAN-2023');
INSERT INTO Donation VALUES (903, 803, 1000.00, '14-JAN-2023');
INSERT INTO Donation VALUES (904, 804, 750.00, '20-JAN-2023');
INSERT INTO Donation VALUES (905, 805, 300.00, '10-FEB-2023');
INSERT INTO Donation VALUES (906, 806, 450.00, '20-FEB-2023');
INSERT INTO Donation VALUES (907, 807, 600.00, '06-MAR-2023');
INSERT INTO Donation VALUES (908, 808, 350.00, '11-MAR-2023');
INSERT INTO Donation VALUES (909, 806, 300.00, '20-MAR-2023');
INSERT INTO Donation VALUES (910, 801, 150.00, '25-MAR-2023');
INSERT INTO Donation VALUES (911, 802, 100.00, '28-MAR-2023');
INSERT INTO Donation VALUES (912, 801, 1200.00, '01-APR-2023');
INSERT INTO Donation VALUES (913, 804, 200.00, '03-APR-2023');
INSERT INTO Donation VALUES (914, 805, 500.00, '05-APR-2023');
INSERT INTO Donation VALUES (915, 808, 350.00, '08-APR-2023');

-- AnimalDonation
INSERT INTO AnimalDonation VALUES (101, 901, 500.00); 
INSERT INTO AnimalDonation VALUES (101, 902, 250.00);
INSERT INTO AnimalDonation VALUES (103, 903, 1000.00);
INSERT INTO AnimalDonation VALUES (104, 904, 750.00);
INSERT INTO AnimalDonation VALUES (105, 905, 300.00);
INSERT INTO AnimalDonation VALUES (106, 906, 450.00);
INSERT INTO AnimalDonation VALUES (107, 907, 600.00);
INSERT INTO AnimalDonation VALUES (108, 908, 350.00);
INSERT INTO AnimalDonation VALUES (109, 909, 300.00);
INSERT INTO AnimalDonation VALUES (110, 910, 150.00);
INSERT INTO AnimalDonation VALUES (111, 911, 100.00);
INSERT INTO AnimalDonation VALUES (112, 912, 1200.00);
INSERT INTO AnimalDonation VALUES (112, 913, 200.00);
INSERT INTO AnimalDonation VALUES (114, 914, 500.00);
INSERT INTO AnimalDonation VALUES (115, 915, 350.00);

-- Keepers
INSERT INTO Keepers VALUES (1001, 'John Garcia', 'Medical Assistant', 'Morning', '0120101234');
INSERT INTO Keepers VALUES (1002, 'Maria Rodriguez', 'Feeder', 'Afternoon', '0119012080');
INSERT INTO Keepers VALUES (1003, 'Charles Martinez', 'Feeder', 'Evening', '0166768901');
INSERT INTO Keepers VALUES (1004, 'Susan Hernandez', 'Medical Assistant', 'Morning', '0175733245');
INSERT INTO Keepers VALUES (1005, 'Joseph Lopez', 'Feeder', 'Afternoon', '0198910110');
INSERT INTO Keepers VALUES (1006, 'Margaret Gonzalez', 'Cleaner', 'Evening', '0110102345');
INSERT INTO Keepers VALUES (1007, 'Daniel Wilson', 'Vet Assistant', 'Morning', '0147891902');
INSERT INTO Keepers VALUES (1008, 'Nancy Adams', 'Vet Assistant', 'Afternoon', '0192468869');
INSERT INTO Keepers VALUES (1009, 'Angela Thompson', 'Cleaner', 'Morning', '0103456789');
INSERT INTO Keepers VALUES (1010, 'Steven Lee', 'Feeder', 'Evening', '0129988776');
INSERT INTO Keepers VALUES (1011, 'Patricia Kim', 'Medical Assistant', 'Afternoon', '0171122334');
INSERT INTO Keepers VALUES (1012, 'Kevin Brown', 'Vet Assistant', 'Evening', '0182233445');
INSERT INTO Keepers VALUES (1013, 'Linda Clark', 'Cleaner', 'Afternoon', '0133344556');
INSERT INTO Keepers VALUES (1014, 'Brian Lewis', 'Feeder', 'Morning', '0115566778');
INSERT INTO Keepers VALUES (1015, 'Emma Walker', 'Medical Assistant', 'Evening', '0166677889');
INSERT INTO Keepers VALUES (1016, 'Chloe Young', 'Vet Assistant', 'Morning', '0101122334');
INSERT INTO Keepers VALUES (1017, 'Jason Scott', 'Feeder', 'Afternoon', '0188899776');
INSERT INTO Keepers VALUES (1018, 'Rachel Evans', 'Cleaner', 'Evening', '0123344556');
INSERT INTO Keepers VALUES (1019, 'Anthony Perez', 'Medical Assistant', 'Afternoon', '0195566443');
INSERT INTO Keepers VALUES (1020, 'Sophia Morgan', 'Feeder', 'Morning', '0176677880');

-- AnimalKeeper
INSERT INTO AnimalKeeper VALUES (101, 1001);
INSERT INTO AnimalKeeper VALUES (102, 1002);
INSERT INTO AnimalKeeper VALUES (103, 1003);
INSERT INTO AnimalKeeper VALUES (104, 1004);
INSERT INTO AnimalKeeper VALUES (105, 1005);
INSERT INTO AnimalKeeper VALUES (106, 1006);
INSERT INTO AnimalKeeper VALUES (107, 1007);
INSERT INTO AnimalKeeper VALUES (108, 1008);
INSERT INTO AnimalKeeper VALUES (109, 1009);
INSERT INTO AnimalKeeper VALUES (110, 1010);
INSERT INTO AnimalKeeper VALUES (111, 1011);
INSERT INTO AnimalKeeper VALUES (112, 1012);
INSERT INTO AnimalKeeper VALUES (113, 1013);
INSERT INTO AnimalKeeper VALUES (114, 1014);
INSERT INTO AnimalKeeper VALUES (115, 1015);
INSERT INTO AnimalKeeper VALUES (103, 1016);
INSERT INTO AnimalKeeper VALUES (105, 1017);
INSERT INTO AnimalKeeper VALUES (106, 1018);
INSERT INTO AnimalKeeper VALUES (108, 1019);
INSERT INTO AnimalKeeper VALUES (115, 1020);

-- PaySlip
INSERT INTO PaySlip VALUES (1101, 1001, '31-JAN-2023', 3200.00, 'Bank');
INSERT INTO PaySlip VALUES (1102, 1002, '31-JAN-2023', 2800.00, 'Bank');
INSERT INTO PaySlip VALUES (1103, 1003, '31-JAN-2023', 2800.00, 'Cash');
INSERT INTO PaySlip VALUES (1104, 1004, '31-JAN-2023', 3500.00, 'Bank');
INSERT INTO PaySlip VALUES (1105, 1005, '31-JAN-2023', 2700.00, 'Cash');
INSERT INTO PaySlip VALUES (1106, 1006, '31-JAN-2023', 2700.00, 'Bank');
INSERT INTO PaySlip VALUES (1107, 1007, '31-JAN-2023', 3000.00, 'Bank');
INSERT INTO PaySlip VALUES (1108, 1008, '31-JAN-2023', 3000.00, 'Cash');
INSERT INTO PaySlip VALUES (1109, 1009, '31-JAN-2023', 2800.00, 'Cash');
INSERT INTO PaySlip VALUES (1110, 1010, '31-JAN-2023', 3500.00, 'Bank');
INSERT INTO PaySlip VALUES (1111, 1011, '31-JAN-2023', 2700.00, 'Cash');
INSERT INTO PaySlip VALUES (1112, 1012, '31-JAN-2023', 2700.00, 'Bank');
INSERT INTO PaySlip VALUES (1113, 1013, '31-JAN-2023', 3000.00, 'Bank');
INSERT INTO PaySlip VALUES (1114, 1014, '31-JAN-2023', 3000.00, 'Cash');
INSERT INTO PaySlip VALUES (1115, 1015, '31-JAN-2023', 3000.00, 'Cash');
INSERT INTO PaySlip VALUES (1116, 1016, '31-JAN-2023', 3100.00, 'Bank');
INSERT INTO PaySlip VALUES (1117, 1017, '31-JAN-2023', 2800.00, 'Bank');
INSERT INTO PaySlip VALUES (1118, 1018, '31-JAN-2023', 2600.00, 'Cash');
INSERT INTO PaySlip VALUES (1119, 1019, '31-JAN-2023', 3300.00, 'Bank');
INSERT INTO PaySlip VALUES (1120, 1020, '31-JAN-2023', 2900.00, 'Cash');


-- FinanceTransaction
INSERT INTO FinanceTransaction VALUES (1201, 901, null, 'Donation', 500.00, '10-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1202, 902, null, 'Donation', 250.00, '12-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1203, 903, null, 'Donation', 1000.00, '14-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1204, 904, null, 'Donation', 750.00, '20-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1205, 905, null, 'Donation', 300.00, '10-FEB-2023');
INSERT INTO FinanceTransaction VALUES (1206, 906, null, 'Donation', 450.00, '20-FEB-2023');
INSERT INTO FinanceTransaction VALUES (1207, 907, null, 'Donation', 600.00, '06-MAR-2023');
INSERT INTO FinanceTransaction VALUES (1208, 908, null, 'Donation', 350.00, '11-MAR-2023');
INSERT INTO FinanceTransaction VALUES (1209, null, 1101, 'PaySlip', 3200.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1210, null, 1102, 'PaySlip', 2800.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1211, null, 1103, 'PaySlip', 2800.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1212, null, 1104, 'PaySlip', 3500.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1213, null, 1105, 'PaySlip', 2700.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1214, null, 1106, 'PaySlip', 2700.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1215, null, 1107, 'PaySlip', 3000.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1216, null, 1108, 'PaySlip', 3000.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1217, null, 1109, 'PaySlip', 2800.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1218, null, 1110, 'PaySlip', 3500.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1219, null, 1111, 'PaySlip', 2700.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1220, null, 1112, 'PaySlip', 2700.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1221, null, 1113, 'PaySlip', 3000.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1222, null, 1114, 'PaySlip', 3000.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1223, null, 1115, 'PaySlip', 3000.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1224, null, 1116, 'PaySlip', 3100.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1225, null, 1117, 'PaySlip', 2800.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1226, null, 1118, 'PaySlip', 2600.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1227, null, 1119, 'PaySlip', 3300.00, '31-JAN-2023');
INSERT INTO FinanceTransaction VALUES (1228, null, 1120, 'PaySlip', 2900.00, '31-JAN-2023');

select*from FinanceTransaction;
select*from PaySlip ;
select*from AnimalKeeper ;
select*from Keepers;
select*from AnimalDonation;
select*from Donation;
select*from Donor ;
select*from Adoption;
select*from Adopter;
select*from HealthCheck;
select*from Vaccinations;
select*from Tasks ;
select*from Volunteers;
select*from AnimalResidence;
select*from Residences;
select*from Animals ;

/* Queries */
/* a) A query that requires an outer join */
SELECT 
    a.animal_id,
    a.animal_name,
    a.species,
    a.breed,
    a.status,
    ad.adoption_date,
    adopter.adopter_name,
    ad.adoption_fee
FROM Animals a
LEFT OUTER JOIN Adoption ad ON a.animal_id = ad.animal_id
LEFT OUTER JOIN Adopter adopter ON ad.adopter_id = adopter.adopter_id
ORDER BY a.animal_id;

/* b) A minimum 4 table join with a group by function query. */
SELECT
    a.species,
    COUNT(DISTINCT d.donor_id) as total_donors,
    COUNT(ad.donation_id) as number_of_donations,
    SUM(ad.support_amount) as total_support_received,
    AVG(ad.support_amount) as average_donation_per_animal
FROM Animals a
INNER JOIN AnimalDonation ad ON a.animal_id = ad.animal_id
INNER JOIN Donation d ON ad.donation_id = d.donation_id
INNER JOIN Donor donor ON d.donor_id = donor.donor_id
GROUP BY a.species
HAVING SUM(ad.support_amount) > 200
ORDER BY total_support_received DESC;

/* c) A string pattern matching and date function query */
SELECT 
    v.volunteer_name,
    v.email,
    v.availability,
    t.task_type,
    a.animal_name,
    ROUND(SYSDATE - a.arrival_date) AS days_since_arrival
FROM Volunteers v
INNER JOIN Tasks t ON v.volunteer_id = t.volunteer_id
INNER JOIN Animals a ON t.animal_id = a.animal_id
WHERE v.email LIKE '%gmail.com'
    AND a.arrival_date >= DATE '2023-01-01'
    AND a.arrival_date < DATE '2023-02-01'
ORDER BY v.volunteer_name;

/* d) A query having both OR and AND */
SELECT a.animal_id, a.animal_name, a.species, a.status, hc.health_rating
FROM Animals a
JOIN HealthCheck hc ON a.animal_id = hc.animal_id
WHERE (a.species = 'Dog' OR a.species = 'Cat')
  AND hc.health_rating >= 4
  AND a.status = 'Available'
  ORDER BY hc.health_rating desc;

/*e) A query that consists of at least 2 subqueries */
SELECT k.keep_id as keeper_id, k.keeper_name, k.role, ps.net_salary AS salary, a.animal_name, a.species, a.status, hc.health_rating
FROM 
    (SELECT * 
     FROM Keepers 
     WHERE role = 'Medical Assistant') k 
JOIN PaySlip ps ON k.keep_id = ps.keeper_id
JOIN AnimalKeeper ak ON k.keep_id = ak.keeper_id
JOIN Animals a ON ak.animal_id = a.animal_id
JOIN (
    SELECT hc1.*
    FROM HealthCheck hc1
    JOIN ( 
        SELECT animal_id, MAX(check_date) AS latest_date
        FROM HealthCheck
        GROUP BY animal_id
    ) latest ON hc1.animal_id = latest.animal_id AND hc1.check_date = latest.latest_date
) hc ON a.animal_id = hc.animal_id
ORDER BY ps.net_salary DESC;

/*f) List the animals that have been in the sanctuary for over a year and have received the most positive health check ratings for health studies */
SELECT a.animal_id, a.animal_name, a.species, a.arrival_date, hc.health_rating 
FROM Animals a
JOIN HealthCheck hc ON a.animal_id = hc.animal_id
WHERE a.status <> 'Adopted'
  AND a.arrival_date <= ADD_MONTHS(SYSDATE, -12)
  AND hc.health_rating = 5
ORDER BY a.arrival_date;