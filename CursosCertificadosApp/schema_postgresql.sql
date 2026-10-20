-- =====================================================================
-- CURSOS GLOBALES JP - ESQUEMA DE BASE DE DATOS EN POSTGRESQL (DDL)
-- Plataforma de Educación Digital Freemium con Certificación a $1 USD
-- =====================================================================

-- Extensión para generación de UUIDs si se requiere
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. TABLA: Usuarios y Clientes
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS certificates CASCADE;
DROP TABLE IF EXISTS quiz_attempts CASCADE;
DROP TABLE IF EXISTS quiz_options CASCADE;
DROP TABLE IF EXISTS quiz_questions CASCADE;
DROP TABLE IF EXISTS quizzes CASCADE;
DROP TABLE IF EXISTS lesson_progress CASCADE;
DROP TABLE IF EXISTS course_enrollments CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS course_modules CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    identification_number VARCHAR(50) NOT NULL, -- Cédula / DNI para emisión legal del certificado
    role VARCHAR(20) NOT NULL DEFAULT 'Student',  -- 'Student' o 'Admin'
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);

-- 2. TABLA: Categorías y Rutas Formativas
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon_class VARCHAR(50) DEFAULT 'bi-folder',
    display_order INT DEFAULT 0
);

-- 3. TABLA: Cursos (Sin LOPCYMAT, Contenido 100% Lecturas y Evaluaciones)
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL UNIQUE,
    short_description VARCHAR(300),
    full_description TEXT,
    level VARCHAR(50) DEFAULT 'Intermedio', -- 'Básico', 'Intermedio', 'Avanzado'
    estimated_hours INT DEFAULT 10,
    passing_score NUMERIC(5,2) DEFAULT 70.00, -- Puntaje mínimo para aprobar la evaluación (%)
    image_url VARCHAR(250) DEFAULT '/images/default-course.jpg',
    badge_color VARCHAR(30) DEFAULT 'primary',
    is_published BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_courses_slug ON courses(slug);
CREATE INDEX idx_courses_category ON courses(category_id);

-- 4. TABLA: Módulos del Curso
CREATE TABLE course_modules (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    order_index INT DEFAULT 0
);

CREATE INDEX idx_modules_course ON course_modules(course_id);

-- 5. TABLA: Lecciones Formativas (Lecturas Interactivas, Guías y Presentaciones Visuales)
CREATE TABLE lessons (
    id SERIAL PRIMARY KEY,
    module_id INT NOT NULL REFERENCES course_modules(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    content_type VARCHAR(30) DEFAULT 'Reading', -- 'Reading' (Guía Teórica), 'Presentation' (Slides Visuales/Infografías)
    content_html TEXT NOT NULL,                -- Contenido educativo verídico enriquecido en HTML
    summary TEXT,                             -- Síntesis o puntos clave de aprendizaje
    duration_minutes INT DEFAULT 15,          -- Tiempo estimado de lectura/estudio
    order_index INT DEFAULT 0,
    is_mandatory BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_lessons_module ON lessons(module_id);

-- 6. TABLA: Cuestionarios / Evaluaciones Finales
CREATE TABLE quizzes (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL UNIQUE REFERENCES courses(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    passing_percentage NUMERIC(5,2) DEFAULT 70.00,
    time_limit_minutes INT DEFAULT 20
);

-- 7. TABLA: Preguntas de Opción Múltiple
CREATE TABLE quiz_questions (
    id SERIAL PRIMARY KEY,
    quiz_id INT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    explanation TEXT, -- Retroalimentación explicativa de la respuesta correcta
    order_index INT DEFAULT 0
);

CREATE INDEX idx_quiz_questions_quiz ON quiz_questions(quiz_id);

-- 8. TABLA: Opciones de Respuesta
CREATE TABLE quiz_options (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL REFERENCES quiz_questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_quiz_options_question ON quiz_options(question_id);

-- 9. TABLA: Inscripciones de Alumnos y Avance Global
CREATE TABLE course_enrollments (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    enrolled_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMPTZ,
    progress_percentage NUMERIC(5,2) DEFAULT 0.00,
    is_completed BOOLEAN DEFAULT FALSE,
    quiz_passed BOOLEAN DEFAULT FALSE,
    quiz_score NUMERIC(5,2) DEFAULT 0.00,
    CONSTRAINT uq_user_course UNIQUE (user_id, course_id)
);

CREATE INDEX idx_enrollments_user ON course_enrollments(user_id);
CREATE INDEX idx_enrollments_course ON course_enrollments(course_id);

-- 10. TABLA: Progreso Detallado por Lección
CREATE TABLE lesson_progress (
    id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL REFERENCES course_enrollments(id) ON DELETE CASCADE,
    lesson_id INT NOT NULL REFERENCES lessons(id) ON DELETE RESTRICT,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMPTZ,
    CONSTRAINT uq_enrollment_lesson UNIQUE (enrollment_id, lesson_id)
);

CREATE INDEX idx_lesson_progress_enrollment ON lesson_progress(enrollment_id);

-- 11. TABLA: Intentos de Evaluación y Calificaciones
CREATE TABLE quiz_attempts (
    id SERIAL PRIMARY KEY,
    quiz_id INT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    score_percentage NUMERIC(5,2) NOT NULL,
    is_passed BOOLEAN NOT NULL DEFAULT FALSE,
    answers_json JSONB, -- Historial de opciones seleccionadas
    attempted_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_quiz_attempts_user ON quiz_attempts(user_id);
CREATE INDEX idx_quiz_attempts_quiz ON quiz_attempts(quiz_id);

-- 12. TABLA: Certificados Oficiales
CREATE TABLE certificates (
    id VARCHAR(40) PRIMARY KEY, -- Identificador UUID seguro
    verification_code VARCHAR(50) NOT NULL UNIQUE, -- Ej: CGJP-2026-F89A1
    user_id INT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    course_id INT NOT NULL REFERENCES courses(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    issued_at TIMESTAMPTZ,
    status INT NOT NULL DEFAULT 0, -- 0: Locked (Marca de agua), 1: PendingPayment, 2: Issued (Oficial)
    watermark_preview_url VARCHAR(250),
    final_pdf_path VARCHAR(250),
    qr_code_base64 TEXT,
    quiz_score NUMERIC(5,2)
);

CREATE INDEX idx_certificates_code ON certificates(verification_code);
CREATE INDEX idx_certificates_user ON certificates(user_id);

-- 13. TABLA: Pagos de Acreditación ($1 USD)
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    certificate_id VARCHAR(40) NOT NULL REFERENCES certificates(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    amount NUMERIC(18,2) NOT NULL DEFAULT 1.00, -- Tarifa de 1 USD
    payment_method VARCHAR(50) NOT NULL, -- 'PagoMovil', 'BinancePay', 'Zinli', 'Stripe', 'PayPal'
    transaction_reference VARCHAR(100) NOT NULL,
    proof_image_url VARCHAR(300),
    status VARCHAR(30) NOT NULL DEFAULT 'Pending', -- 'Pending', 'Approved', 'Rejected'
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMPTZ,
    admin_notes VARCHAR(250)
);

CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_cert ON payments(certificate_id);
