-- MySQL 8+ 建表：Go Bridge + Demo 所需
CREATE TABLE IF NOT EXISTS partner_configs (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  base_url VARCHAR(255) NOT NULL,
  api_key VARCHAR(255) NULL,
  api_secret VARCHAR(255) NULL,
  callback_secret VARCHAR(255) NULL,
  rate_per_sec INT DEFAULT 100,
  per_host_rate INT DEFAULT 50,
  timeout_ms INT DEFAULT 5000,
  enabled TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS http_job_index (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  job_id CHAR(36) UNIQUE NOT NULL,
  type VARCHAR(32) NOT NULL,
  order_id BIGINT UNSIGNED NULL,
  partner VARCHAR(50) NOT NULL,
  status VARCHAR(16) DEFAULT 'queued',
  attempts INT DEFAULT 0,
  last_error TEXT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  INDEX idx_job_type(type),
  INDEX idx_job_order(order_id),
  INDEX idx_job_partner(partner)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS demo_orders (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tenant_id BIGINT UNSIGNED NOT NULL,
  partner VARCHAR(50) NOT NULL,
  symbol VARCHAR(50) NOT NULL,
  side VARCHAR(10) NOT NULL,
  amount DECIMAL(18,8) NOT NULL,
  price DECIMAL(18,8) NOT NULL,
  status VARCHAR(32) DEFAULT 'pending',
  out_order_id VARCHAR(64) NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  INDEX idx_demo_partner(partner),
  INDEX idx_demo_status(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS order_events (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT UNSIGNED NOT NULL,
  event VARCHAR(32) NOT NULL,
  payload JSON NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_event_order(order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 基础种子
INSERT INTO partner_configs (name, base_url, api_key, api_secret, callback_secret, rate_per_sec, per_host_rate, timeout_ms, enabled, created_at, updated_at)
VALUES
('partnerA','https://example-partnerA.test','demo-key','demo-secret','partner-callback-secret',100,50,5000,1,NOW(),NOW())
ON DUPLICATE KEY UPDATE base_url=VALUES(base_url), api_key=VALUES(api_key), api_secret=VALUES(api_secret),
  callback_secret=VALUES(callback_secret), rate_per_sec=VALUES(rate_per_sec), per_host_rate=VALUES(per_host_rate),
  timeout_ms=VALUES(timeout_ms), enabled=VALUES(enabled), updated_at=NOW();
