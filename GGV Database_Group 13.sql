CREATE DATABASE GGV;
USE GGV;
CREATE TABLE participating_countries (
     participating_country_id VARCHAR(10) NOT NULL PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

CREATE TABLE ggv_fee (
	ggv_fee_id VARCHAR(10) NOT NULL PRIMARY KEY,
   participating_country_id VARCHAR(10) NOT NULL,
    country_category VARCHAR(50) NOT NULL CHECK(country_category IN("non-G20", "G20", "neighbouring country")),
    amount DECIMAL(10,2), 
    CONSTRAINT participating_country_id_FK_ggv_fee_id FOREIGN KEY (participating_country_id) REFERENCES participating_countries (participating_country_id) ON DELETE CASCADE ON UPDATE CASCADE
);
    
CREATE TABLE passport_detail (
	passport_number INT NOT NULL PRIMARY KEY,
    issued_date DATE NOT NULL,
    exp_date DATE NOT NULL,
    DOB DATE NOT NULL,
    nationality VARCHAR(20) NOT NULL
);

CREATE TABLE visitor (
	visitor_id VARCHAR(20) NOT NULL PRIMARY KEY,
    passport_number INT NOT NULL,	-- FOREIGN KEY
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    visitor_email VARCHAR(30) NOT NULL,
    CONSTRAINT passport_number_FK_visitor FOREIGN KEY (passport_number) REFERENCES passport_detail (passport_number) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE ggv_fee
ADD COLUMN visitor_id VARCHAR(20) NOT NULL,
ADD CONSTRAINT visitor_id_FK_ggv_fee FOREIGN KEY (visitor_id) REFERENCES visitor (visitor_id) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE preference (
	tour_id VARCHAR(20) NOT NULL PRIMARY KEY,
    visitor_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    participating_country_id VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    preference_nbr VARCHAR(10) NOT NULL,
    preference_area VARCHAR(30) NOT NULL,
    CONSTRAINT visitor_id_FK_preference FOREIGN KEY (visitor_id) REFERENCES visitor (visitor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT participating_country_id_FK_preference FOREIGN KEY (participating_country_id) REFERENCES participating_countries (participating_country_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE credit_card_detail (
	card_number INT NOT NULL PRIMARY KEY,
    card_name VARCHAR(30) NOT NULL,
    card_expiry_date DATE NOT NULL
);

CREATE TABLE payment (
	payment_id VARCHAR(20) NOT NULL PRIMARY KEY,
    tour_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    ggv_fee_id VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    date_paid DATE NOT NULL,
    mode_of_payment VARCHAR(20) CHECK (mode_of_payment IN ("GGV app", "GGV website")),
    card_number INT NOT NULL, 	-- FOREIGN KEY
    qr_code BLOB,
    expiry_date_receipt DATE NOT NULL,
    CONSTRAINT tour_id_FK_payment FOREIGN KEY (tour_id) REFERENCES preference (tour_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ggv_fee_id_FK_payment FOREIGN KEY (ggv_fee_id) REFERENCES ggv_fee (ggv_fee_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT card_number_FK_payment FOREIGN KEY (card_number) REFERENCES credit_card_detail (card_number) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE customer_history (
	history_id VARCHAR(20) NOT NULL PRIMARY KEY,
    payment_id VARCHAR(20) NOT NULL, 	-- FOREIGN KEY
    departure_date DATE NOT NULL,
    arrival_date DATE NOT NULL,
    CONSTRAINT payment_id_FK_customer_history FOREIGN KEY (payment_id) REFERENCES payment (payment_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE purchased_bond (
	transaction_id VARCHAR(20) NOT NULL PRIMARY KEY,
    bond_type VARCHAR(50) NOT NULL CHECK (bond_type IN ("Blue Bond", "Forest Resilience Bond", "Rhino Bond")),
    bond_sales_amount DECIMAL(10,2) NOT NULL,
    coupon_rate DECIMAL(10,2) NOT NULL,
    purchase_date DATE NOT NULL,
    maturity_date DATE
);

CREATE TABLE partcipating_purchased_bond (
	participating_country_id VARCHAR(10) NOT NULL,
    transaction_id VARCHAR(20) NOT NULL,
    PRIMARY KEY(participating_country_id, transaction_id),
	CONSTRAINT participating_country_id_FK_transaction_id FOREIGN KEY (participating_country_id) REFERENCES participating_countries (participating_country_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT transaction_id_FK_participating_country_id FOREIGN KEY (transaction_id) REFERENCES purchased_bond (transaction_id) ON UPDATE CASCADE ON DELETE CASCADE
    );


CREATE TABLE bond_holder_detail (
	bond_holder_id VARCHAR(10) NOT NULL PRIMARY KEY,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    bond_holder_email VARCHAR(40) NOT NULL
);

CREATE TABLE bond_holder (
	bond_holder_id VARCHAR(10) NOT NULL,
    transaction_id VARCHAR(10) NOT NULL,
    PRIMARY KEY(bond_holder_id, transaction_id),
    CONSTRAINT bond_holder_id_FK_bond_holder FOREIGN KEY (bond_holder_id) REFERENCES bond_holder_detail (bond_holder_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT transaction_id_FK_purchased_bond FOREIGN KEY (transaction_id) REFERENCES purchased_bond (transaction_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE board_of_director_details (
	personal_recorder_id VARCHAR(10) NOT NULL PRIMARY KEY,
    personal_recorder_fname VARCHAR(30) NOT NULL,
    personal_recorder_lname VARCHAR(30) NOT NULL,
    personal_recoder_email VARCHAR(40) NOT NULL
);

CREATE TABLE board_of_director (
	personal_recorder_id VARCHAR(10) NOT NULL,
    transaction_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (personal_recorder_id,  transaction_id),
    CONSTRAINT personal_recorder_id_FK_board_of_director FOREIGN KEY (personal_recorder_id) REFERENCES board_of_director_details (personal_recorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT transaction_id_FK_board_of_director FOREIGN KEY (transaction_id) REFERENCES purchased_bond (transaction_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ngo_list (
	ngo_id VARCHAR(10) NOT NULL PRIMARY KEY,
    ngo_name VARCHAR(20) NOT NULL
);

CREATE TABLE national_agencies_list (
	national_agencies_id VARCHAR(10) NOT NULL PRIMARY KEY,
    national_agencies_name VARCHAR(20) NOT NULL
);

CREATE TABLE financial_support (
	support_id VARCHAR(10) NOT NULL PRIMARY KEY,
    support_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE ngo_financial_support (
	support_id VARCHAR(10) NOT NULL,
    ngo_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (support_id,  ngo_id),
    CONSTRAINT support_id_FK_ngo_financial_support FOREIGN KEY (support_id) REFERENCES financial_support (support_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ngo_id_FK_ngo_financial_support FOREIGN KEY (ngo_id) REFERENCES ngo_list (ngo_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE participating_ngo (
	participating_country_id VARCHAR(10) NOT NULL,
    ngo_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (participating_country_id,  ngo_id),
    CONSTRAINT participating_country_id_FK_ngo_id FOREIGN KEY (participating_country_id) REFERENCES participating_countries (participating_country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ngo_id_FK_participating_country_id FOREIGN KEY (ngo_id) REFERENCES ngo_list (ngo_id) ON UPDATE CASCADE ON DELETE CASCADE
    );
    
CREATE TABLE national_agencies_financial_support (
	support_id VARCHAR(10) NOT NULL,
    national_agencies_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (support_id, national_agencies_id),
    CONSTRAINT support_id_FK_national_agencies_financial_support FOREIGN KEY (support_id) REFERENCES financial_support (support_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT national_agencies_id_FK_national_agencies_financial_support FOREIGN KEY (national_agencies_id) REFERENCES national_agencies_list (national_agencies_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE participating_national_agency (
	participating_country_id VARCHAR(10) NOT NULL,
    national_agencies_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (participating_country_id, national_agencies_id),
    CONSTRAINT participating_country_id_FK_national_agencies_id FOREIGN KEY (participating_country_id) REFERENCES participating_countries (participating_country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT national_agencies_id_FK_participating_country_id FOREIGN KEY (national_agencies_id) REFERENCES national_agencies_list (national_agencies_id) ON UPDATE CASCADE ON DELETE CASCADE
    );
    

CREATE TABLE supporters (
	organization_id VARCHAR(10) NOT NULL PRIMARY KEY,
    support_id VARCHAR(10) NOT NULL, 	-- FOREIGN KEY
    support_category VARCHAR(50)
		CHECK(support_category IN ("INGO", "multilateral agency name")),
	support_name VARCHAR(30) NOT NULL,
    CONSTRAINT support_id_FK_supporters FOREIGN KEY (support_id) REFERENCES financial_support (support_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE expert_info (
	expert_id VARCHAR(10) NOT NULL PRIMARY KEY,
    expert_fname VARCHAR(30) NOT NULL,
    expert_lname VARCHAR(30) NOT NULL,
    expert_email VARCHAR(50) NOT NULL
);

CREATE TABLE group_expert (
	group_id VARCHAR(10) NOT NULL ,
    expert_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (group_id, expert_id),
    CONSTRAINT expert_id_FK_group_expert FOREIGN KEY (expert_id) REFERENCES expert_info (expert_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE recommendation (
	recommendation_id VARCHAR(10) NOT NULL PRIMARY KEY,
    group_id VARCHAR(10) NOT NULL, 	-- FOREIGN KEY
    recommendation VARCHAR(200) NOT NULL,
    CONSTRAINT group_id_FK_recommendation FOREIGN KEY (group_id) REFERENCES group_expert (group_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE trust_fund_board_decision (
	decision_id VARCHAR(10)  NOT NULL PRIMARY KEY,
    support_id VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    recommendation_id VARCHAR(10) NOT NULL, 	-- FOREIGN KEY 
    implementation_date DATE NOT NULL,
    CONSTRAINT support_id_FK_trust_fund_board_decision FOREIGN KEY (support_id) REFERENCES financial_support (support_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT recommendation_id_FK_trust_fund_board_decision FOREIGN KEY (recommendation_id) REFERENCES recommendation (recommendation_id) ON UPDATE CASCADE ON DELETE CASCADE
);
