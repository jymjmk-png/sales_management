-- 사용자 테이블
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'manager', 'user') NOT NULL DEFAULT 'user',
    business_code CHAR(4) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    last_login DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_business_code (business_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 사업장 테이블
CREATE TABLE IF NOT EXISTS businesses (
    business_code CHAR(4) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    representative VARCHAR(50),
    business_number VARCHAR(20),
    tax_invoice_enabled ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
    phone VARCHAR(20),
    fax VARCHAR(20),
    address VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 거래처 테이블
CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    customer_code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    representative VARCHAR(50),
    business_number VARCHAR(20),
    customer_type ENUM('buyer', 'supplier', 'both') NOT NULL DEFAULT 'both',
    phone VARCHAR(20),
    fax VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    bank_name VARCHAR(50),
    bank_account VARCHAR(50),
    bank_holder VARCHAR(50),
    memo TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_biz_customer (business_code, customer_code),
    INDEX idx_business_code (business_code),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 품목 테이블
CREATE TABLE IF NOT EXISTS materials (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    material_code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    spec VARCHAR(100),
    unit VARCHAR(20) NOT NULL DEFAULT 'EA',
    material_type ENUM('raw', 'wip', 'finished', 'supplies') NOT NULL,
    unit_price DECIMAL(12,2) DEFAULT 0,
    tax_rate DECIMAL(5,2) DEFAULT 10.00,
    memo TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_biz_material (business_code, material_code),
    INDEX idx_business_code (business_code),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 입고 헤더 테이블
CREATE TABLE IF NOT EXISTS inbound_headers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    inbound_date DATE NOT NULL,
    customer_id INT NOT NULL,
    document_number VARCHAR(20),
    memo TEXT,
    total_amount DECIMAL(12,2) DEFAULT 0,
    total_tax DECIMAL(12,2) DEFAULT 0,
    status ENUM('pending', 'confirmed', 'cancelled') NOT NULL DEFAULT 'pending',
    created_by INT NOT NULL,
    confirmed_by INT,
    confirmed_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_business_code (business_code),
    INDEX idx_inbound_date (inbound_date),
    INDEX idx_customer (customer_id),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (confirmed_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 입고 상세 테이블
CREATE TABLE IF NOT EXISTS inbound_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inbound_header_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    tax_rate DECIMAL(5,2) NOT NULL DEFAULT 10.00,
    memo TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_header (inbound_header_id),
    INDEX idx_material (material_id),
    FOREIGN KEY (inbound_header_id) REFERENCES inbound_headers(id),
    FOREIGN KEY (material_id) REFERENCES materials(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 출고 헤더 테이블
CREATE TABLE IF NOT EXISTS outbound_headers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    outbound_date DATE NOT NULL,
    customer_id INT NOT NULL,
    document_number VARCHAR(20),
    memo TEXT,
    total_amount DECIMAL(12,2) DEFAULT 0,
    total_tax DECIMAL(12,2) DEFAULT 0,
    status ENUM('pending', 'confirmed', 'cancelled') NOT NULL DEFAULT 'pending',
    created_by INT NOT NULL,
    confirmed_by INT,
    confirmed_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_business_code (business_code),
    INDEX idx_outbound_date (outbound_date),
    INDEX idx_customer (customer_id),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (confirmed_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 출고 상세 테이블
CREATE TABLE IF NOT EXISTS outbound_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    outbound_header_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    tax_rate DECIMAL(5,2) NOT NULL DEFAULT 10.00,
    memo TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_header (outbound_header_id),
    INDEX idx_material (material_id),
    FOREIGN KEY (outbound_header_id) REFERENCES outbound_headers(id),
    FOREIGN KEY (material_id) REFERENCES materials(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 재고 이력 테이블
CREATE TABLE IF NOT EXISTS inventory_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    material_id INT NOT NULL,
    transaction_type ENUM('inbound', 'outbound', 'adjustment') NOT NULL,
    transaction_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    memo TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_business_code (business_code),
    INDEX idx_material (material_id),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code),
    FOREIGN KEY (material_id) REFERENCES materials(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 재고 현황 테이블 (재고금액은 이동평균법으로 계산)
CREATE TABLE IF NOT EXISTS inventory_balance (
    business_code CHAR(4) NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL DEFAULT 0,
    unit_price DECIMAL(12,2) NOT NULL DEFAULT 0,
    last_inbound_date DATE,
    last_outbound_date DATE,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (business_code, material_id),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code),
    FOREIGN KEY (material_id) REFERENCES materials(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 번호 관리 테이블
CREATE TABLE IF NOT EXISTS numbering (
    id INT PRIMARY KEY AUTO_INCREMENT,
    business_code CHAR(4) NOT NULL,
    document_type VARCHAR(20) NOT NULL,
    ym_key CHAR(6) NOT NULL COMMENT '연월 (YYYYMM)',
    last_sequence INT NOT NULL DEFAULT 0,
    format VARCHAR(50) NOT NULL,
    UNIQUE KEY uk_numbering (business_code, document_type, ym_key),
    FOREIGN KEY (business_code) REFERENCES businesses(business_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;