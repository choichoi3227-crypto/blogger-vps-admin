
-- 사용자 계정 및 Cloudflare 글로벌 API 설정 테이블
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    cf_email TEXT,
    cf_api_key TEXT,
    cf_zone_id TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 커스텀 라우트 및 캐시 수명 제어 테이블
CREATE TABLE IF NOT EXISTS routes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    route_pattern TEXT NOT NULL,
    cache_ttl INTEGER DEFAULT 31536000,
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 초기 관리자 계정 세팅 (아이디: admin@admin.com / 비밀번호: admin123)
-- SHA-256 해시값 적용 완료
INSERT INTO users (email, password_hash) 
VALUES ('admin@admin.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');


