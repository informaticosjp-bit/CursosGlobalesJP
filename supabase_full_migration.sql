--
-- PostgreSQL database dump
--


-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0; (Omitido para compatibilidad con Supabase PG15/PG16)
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."UserNotifications" DROP CONSTRAINT IF EXISTS "UserNotifications_UserId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserCvs" DROP CONSTRAINT IF EXISTS "FK_UserCvs_Users_UserId";
ALTER TABLE IF EXISTS ONLY public."Quizzes" DROP CONSTRAINT IF EXISTS "FK_Quizzes_Courses_CourseId";
ALTER TABLE IF EXISTS ONLY public."QuizQuestions" DROP CONSTRAINT IF EXISTS "FK_QuizQuestions_Quizzes_QuizId";
ALTER TABLE IF EXISTS ONLY public."QuizOptions" DROP CONSTRAINT IF EXISTS "FK_QuizOptions_QuizQuestions_QuestionId";
ALTER TABLE IF EXISTS ONLY public."QuizAttempts" DROP CONSTRAINT IF EXISTS "FK_QuizAttempts_Users_UserId";
ALTER TABLE IF EXISTS ONLY public."QuizAttempts" DROP CONSTRAINT IF EXISTS "FK_QuizAttempts_Quizzes_QuizId";
ALTER TABLE IF EXISTS ONLY public."Payments" DROP CONSTRAINT IF EXISTS "FK_Payments_Users_UserId";
ALTER TABLE IF EXISTS ONLY public."Payments" DROP CONSTRAINT IF EXISTS "FK_Payments_Certificates_CertificateId";
ALTER TABLE IF EXISTS ONLY public."Lessons" DROP CONSTRAINT IF EXISTS "FK_Lessons_CourseModules_ModuleId";
ALTER TABLE IF EXISTS ONLY public."LessonProgresses" DROP CONSTRAINT IF EXISTS "FK_LessonProgresses_Lessons_LessonId";
ALTER TABLE IF EXISTS ONLY public."LessonProgresses" DROP CONSTRAINT IF EXISTS "FK_LessonProgresses_CourseEnrollments_EnrollmentId";
ALTER TABLE IF EXISTS ONLY public."Courses" DROP CONSTRAINT IF EXISTS "FK_Courses_Categories_CategoryId";
ALTER TABLE IF EXISTS ONLY public."CourseModules" DROP CONSTRAINT IF EXISTS "FK_CourseModules_Courses_CourseId";
ALTER TABLE IF EXISTS ONLY public."CourseEnrollments" DROP CONSTRAINT IF EXISTS "FK_CourseEnrollments_Users_UserId";
ALTER TABLE IF EXISTS ONLY public."CourseEnrollments" DROP CONSTRAINT IF EXISTS "FK_CourseEnrollments_Courses_CourseId";
ALTER TABLE IF EXISTS ONLY public."Certificates" DROP CONSTRAINT IF EXISTS "FK_Certificates_Users_UserId";
ALTER TABLE IF EXISTS ONLY public."Certificates" DROP CONSTRAINT IF EXISTS "FK_Certificates_Courses_CourseId";
DROP INDEX IF EXISTS public."IX_Users_Email";
DROP INDEX IF EXISTS public."IX_UserCvs_UserId";
DROP INDEX IF EXISTS public."IX_Quizzes_CourseId";
DROP INDEX IF EXISTS public."IX_QuizQuestions_QuizId";
DROP INDEX IF EXISTS public."IX_QuizOptions_QuestionId";
DROP INDEX IF EXISTS public."IX_QuizAttempts_UserId";
DROP INDEX IF EXISTS public."IX_QuizAttempts_QuizId";
DROP INDEX IF EXISTS public."IX_Payments_UserId";
DROP INDEX IF EXISTS public."IX_Payments_CertificateId";
DROP INDEX IF EXISTS public."IX_Lessons_ModuleId";
DROP INDEX IF EXISTS public."IX_LessonProgresses_LessonId";
DROP INDEX IF EXISTS public."IX_LessonProgresses_EnrollmentId";
DROP INDEX IF EXISTS public."IX_Courses_Slug";
DROP INDEX IF EXISTS public."IX_Courses_CategoryId";
DROP INDEX IF EXISTS public."IX_CourseModules_CourseId";
DROP INDEX IF EXISTS public."IX_CourseEnrollments_UserId_CourseId";
DROP INDEX IF EXISTS public."IX_CourseEnrollments_CourseId";
DROP INDEX IF EXISTS public."IX_Certificates_VerificationCode";
DROP INDEX IF EXISTS public."IX_Certificates_UserId";
DROP INDEX IF EXISTS public."IX_Certificates_CourseId";
DROP INDEX IF EXISTS public."IX_Categories_Slug";
ALTER TABLE IF EXISTS ONLY public."UserNotifications" DROP CONSTRAINT IF EXISTS "UserNotifications_pkey";
ALTER TABLE IF EXISTS ONLY public."UserCvs" DROP CONSTRAINT IF EXISTS "UserCvs_pkey";
ALTER TABLE IF EXISTS ONLY public."SystemSettings" DROP CONSTRAINT IF EXISTS "SystemSettings_pkey";
ALTER TABLE IF EXISTS ONLY public."SystemSettings" DROP CONSTRAINT IF EXISTS "SystemSettings_Key_key";
ALTER TABLE IF EXISTS ONLY public."Users" DROP CONSTRAINT IF EXISTS "PK_Users";
ALTER TABLE IF EXISTS ONLY public."Quizzes" DROP CONSTRAINT IF EXISTS "PK_Quizzes";
ALTER TABLE IF EXISTS ONLY public."QuizQuestions" DROP CONSTRAINT IF EXISTS "PK_QuizQuestions";
ALTER TABLE IF EXISTS ONLY public."QuizOptions" DROP CONSTRAINT IF EXISTS "PK_QuizOptions";
ALTER TABLE IF EXISTS ONLY public."QuizAttempts" DROP CONSTRAINT IF EXISTS "PK_QuizAttempts";
ALTER TABLE IF EXISTS ONLY public."Payments" DROP CONSTRAINT IF EXISTS "PK_Payments";
ALTER TABLE IF EXISTS ONLY public."Lessons" DROP CONSTRAINT IF EXISTS "PK_Lessons";
ALTER TABLE IF EXISTS ONLY public."LessonProgresses" DROP CONSTRAINT IF EXISTS "PK_LessonProgresses";
ALTER TABLE IF EXISTS ONLY public."Courses" DROP CONSTRAINT IF EXISTS "PK_Courses";
ALTER TABLE IF EXISTS ONLY public."CourseModules" DROP CONSTRAINT IF EXISTS "PK_CourseModules";
ALTER TABLE IF EXISTS ONLY public."CourseEnrollments" DROP CONSTRAINT IF EXISTS "PK_CourseEnrollments";
ALTER TABLE IF EXISTS ONLY public."Certificates" DROP CONSTRAINT IF EXISTS "PK_Certificates";
ALTER TABLE IF EXISTS ONLY public."Categories" DROP CONSTRAINT IF EXISTS "PK_Categories";
ALTER TABLE IF EXISTS public."UserNotifications" ALTER COLUMN "Id" DROP DEFAULT;
ALTER TABLE IF EXISTS public."UserCvs" ALTER COLUMN "Id" DROP DEFAULT;
ALTER TABLE IF EXISTS public."SystemSettings" ALTER COLUMN "Id" DROP DEFAULT;
DROP TABLE IF EXISTS public."Users";
DROP SEQUENCE IF EXISTS public."UserNotifications_Id_seq";
DROP TABLE IF EXISTS public."UserNotifications";
DROP SEQUENCE IF EXISTS public."UserCvs_Id_seq";
DROP TABLE IF EXISTS public."UserCvs";
DROP SEQUENCE IF EXISTS public."SystemSettings_Id_seq";
DROP TABLE IF EXISTS public."SystemSettings";
DROP TABLE IF EXISTS public."Quizzes";
DROP TABLE IF EXISTS public."QuizQuestions";
DROP TABLE IF EXISTS public."QuizOptions";
DROP TABLE IF EXISTS public."QuizAttempts";
DROP TABLE IF EXISTS public."Payments";
DROP TABLE IF EXISTS public."Lessons";
DROP TABLE IF EXISTS public."LessonProgresses";
DROP TABLE IF EXISTS public."Courses";
DROP TABLE IF EXISTS public."CourseModules";
DROP TABLE IF EXISTS public."CourseEnrollments";
DROP TABLE IF EXISTS public."Certificates";
DROP TABLE IF EXISTS public."Categories";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Categories" (
    "Id" integer NOT NULL,
    "Name" character varying(100) NOT NULL,
    "Slug" character varying(100) NOT NULL,
    "Description" character varying(250) NOT NULL,
    "IconClass" character varying(50) NOT NULL,
    "DisplayOrder" integer NOT NULL
);


--
-- Name: Categories_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Categories" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Categories_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Certificates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Certificates" (
    "Id" character varying(40) NOT NULL,
    "VerificationCode" character varying(50) NOT NULL,
    "UserId" integer NOT NULL,
    "CourseId" integer NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "IssuedAt" timestamp with time zone,
    "Status" integer NOT NULL,
    "QuizScore" numeric(5,2),
    "WatermarkPreviewUrl" character varying(250),
    "FinalPdfPath" character varying(250),
    "QrCodeBase64" text
);


--
-- Name: CourseEnrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CourseEnrollments" (
    "Id" integer NOT NULL,
    "UserId" integer NOT NULL,
    "CourseId" integer NOT NULL,
    "EnrolledAt" timestamp with time zone NOT NULL,
    "CompletedAt" timestamp with time zone,
    "ProgressPercentage" numeric(5,2) NOT NULL,
    "IsCompleted" boolean NOT NULL,
    "QuizPassed" boolean NOT NULL,
    "QuizScore" numeric(5,2) NOT NULL
);


--
-- Name: CourseEnrollments_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."CourseEnrollments" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."CourseEnrollments_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: CourseModules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CourseModules" (
    "Id" integer NOT NULL,
    "CourseId" integer NOT NULL,
    "Title" character varying(150) NOT NULL,
    "OrderIndex" integer NOT NULL
);


--
-- Name: CourseModules_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."CourseModules" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."CourseModules_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Courses" (
    "Id" integer NOT NULL,
    "CategoryId" integer NOT NULL,
    "Title" character varying(150) NOT NULL,
    "Slug" character varying(150) NOT NULL,
    "ShortDescription" character varying(300) NOT NULL,
    "FullDescription" text NOT NULL,
    "Level" character varying(50) NOT NULL,
    "EstimatedHours" integer NOT NULL,
    "PassingScore" numeric(5,2) NOT NULL,
    "ImageUrl" character varying(250) NOT NULL,
    "BadgeColor" character varying(30) NOT NULL,
    "IsPublished" boolean NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "InstructorName" character varying(150),
    "InstructorTitle" character varying(150),
    "CreatorUserId" integer,
    "Price" numeric(10,2) DEFAULT 1.00 NOT NULL
);


--
-- Name: Courses_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Courses" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Courses_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: LessonProgresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LessonProgresses" (
    "Id" integer NOT NULL,
    "EnrollmentId" integer NOT NULL,
    "LessonId" integer NOT NULL,
    "IsCompleted" boolean NOT NULL,
    "CompletedAt" timestamp with time zone
);


--
-- Name: LessonProgresses_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."LessonProgresses" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."LessonProgresses_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Lessons" (
    "Id" integer NOT NULL,
    "ModuleId" integer NOT NULL,
    "Title" character varying(150) NOT NULL,
    "ContentType" character varying(30) NOT NULL,
    "ContentHtml" text NOT NULL,
    "Summary" character varying(500),
    "DurationMinutes" integer NOT NULL,
    "OrderIndex" integer NOT NULL,
    "IsMandatory" boolean NOT NULL
);


--
-- Name: Lessons_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Lessons" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Lessons_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Payments" (
    "Id" integer NOT NULL,
    "CertificateId" character varying(40),
    "UserId" integer NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "PaymentMethod" character varying(50) NOT NULL,
    "TransactionReference" character varying(100) NOT NULL,
    "ProofImageUrl" character varying(300),
    "Status" character varying(30) NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "ProcessedAt" timestamp with time zone,
    "AdminNotes" character varying(250),
    "PaymentType" character varying(50) DEFAULT 'Certificate'::character varying
);


--
-- Name: Payments_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Payments" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Payments_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: QuizAttempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."QuizAttempts" (
    "Id" integer NOT NULL,
    "QuizId" integer NOT NULL,
    "UserId" integer NOT NULL,
    "ScorePercentage" numeric(5,2) NOT NULL,
    "IsPassed" boolean NOT NULL,
    "AnswersJson" text,
    "AttemptedAt" timestamp with time zone NOT NULL
);


--
-- Name: QuizAttempts_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."QuizAttempts" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."QuizAttempts_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: QuizOptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."QuizOptions" (
    "Id" integer NOT NULL,
    "QuestionId" integer NOT NULL,
    "OptionText" text NOT NULL,
    "IsCorrect" boolean NOT NULL
);


--
-- Name: QuizOptions_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."QuizOptions" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."QuizOptions_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: QuizQuestions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."QuizQuestions" (
    "Id" integer NOT NULL,
    "QuizId" integer NOT NULL,
    "QuestionText" text NOT NULL,
    "Explanation" text,
    "OrderIndex" integer NOT NULL
);


--
-- Name: QuizQuestions_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."QuizQuestions" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."QuizQuestions_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Quizzes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Quizzes" (
    "Id" integer NOT NULL,
    "CourseId" integer NOT NULL,
    "Title" character varying(150) NOT NULL,
    "Description" text NOT NULL,
    "PassingPercentage" numeric(5,2) NOT NULL,
    "TimeLimitMinutes" integer NOT NULL
);


--
-- Name: Quizzes_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Quizzes" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Quizzes_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: SystemSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SystemSettings" (
    "Id" integer NOT NULL,
    "Key" character varying(100) NOT NULL,
    "Title" character varying(200) NOT NULL,
    "Content" text NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: SystemSettings_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."SystemSettings_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: SystemSettings_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."SystemSettings_Id_seq" OWNED BY public."SystemSettings"."Id";


--
-- Name: UserCvs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserCvs" (
    "Id" integer NOT NULL,
    "UserId" integer NOT NULL,
    "FullName" character varying(150) NOT NULL,
    "JobTitle" character varying(150),
    "Email" character varying(150),
    "PhoneNumber" character varying(50),
    "Location" character varying(120),
    "WebsiteOrLinkedIn" character varying(200),
    "ProfessionalSummary" text,
    "ExperienceJson" text,
    "EducationJson" text,
    "Skills" text,
    "CertificationsJson" text,
    "SelectedTemplate" character varying(50) DEFAULT 'Corporate'::character varying,
    "UpdatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "IdentificationNumber" character varying(50),
    "Address" character varying(250),
    "ColorPalette" character varying(50) DEFAULT 'ClassicNavy'::character varying
);


--
-- Name: UserCvs_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."UserCvs_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: UserCvs_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."UserCvs_Id_seq" OWNED BY public."UserCvs"."Id";


--
-- Name: UserNotifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserNotifications" (
    "Id" integer NOT NULL,
    "UserId" integer NOT NULL,
    "Title" character varying(150) NOT NULL,
    "Message" text NOT NULL,
    "Type" character varying(30) DEFAULT 'Info'::character varying NOT NULL,
    "IsRead" boolean DEFAULT false NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: UserNotifications_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."UserNotifications_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: UserNotifications_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."UserNotifications_Id_seq" OWNED BY public."UserNotifications"."Id";


--
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users" (
    "Id" integer NOT NULL,
    "FullName" character varying(150) NOT NULL,
    "Email" character varying(150) NOT NULL,
    "PasswordHash" text NOT NULL,
    "IdentificationNumber" character varying(50) NOT NULL,
    "Role" character varying(20) NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "Age" integer,
    "PhoneNumber" character varying(50),
    "Address" character varying(250),
    "BirthDate" timestamp with time zone,
    "ProfilePictureUrl" character varying(300)
);


--
-- Name: Users_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."Users" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: SystemSettings Id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings" ALTER COLUMN "Id" SET DEFAULT nextval('public."SystemSettings_Id_seq"'::regclass);


--
-- Name: UserCvs Id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCvs" ALTER COLUMN "Id" SET DEFAULT nextval('public."UserCvs_Id_seq"'::regclass);


--
-- Name: UserNotifications Id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserNotifications" ALTER COLUMN "Id" SET DEFAULT nextval('public."UserNotifications_Id_seq"'::regclass);


--
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Categories" VALUES (1, 'Tecnologías e IA', 'tecnologias-e-ia', 'Herramientas de productividad inteligente, análisis de datos e inteligencia artificial generativa.', 'bi-cpu', 1);
INSERT INTO public."Categories" VALUES (2, 'Habilidades Empresariales y de Gestión', 'gestion-empresarial', 'Dirección estratégica, metodologías ágiles, control de inventario y ventas digitales.', 'bi-briefcase', 2);
INSERT INTO public."Categories" VALUES (3, 'Ciberseguridad e Idiomas', 'ciberseguridad-e-idiomas', 'Protección de infraestructura digital y competencias de comunicación global.', 'bi-shield-check', 3);
INSERT INTO public."Categories" VALUES (4, 'Habilidades Blandas y Seguridad Laboral', 'habilidades-blandas-y-seguridad', 'Relaciones humanas, negociación, primeros auxilios y gestión del tiempo en el trabajo.', 'bi-heart-pulse', 4);
INSERT INTO public."Categories" VALUES (7, 'Programación y Desarrollo de Software', 'programacion-desarrollo-software', 'Cursos de desarrollo web, backend, frontend, bases de datos y arquitectura de sistemas.', 'bi-code-slash', 5);
INSERT INTO public."Categories" VALUES (8, 'Marketing Digital, Redes y Ventas', 'marketing-digital-redes-ventas', 'Estrategias de posicionamiento SEO, gestión de redes sociales, embudos de venta y copywriting.', 'bi-megaphone', 6);
INSERT INTO public."Categories" VALUES (9, 'Finanzas, Contabilidad y Tributación', 'finanzas-contabilidad-tributacion', 'Gestión financiera empresarial, contabilidad práctica, presupuestos e impuestos.', 'bi-cash-coin', 7);
INSERT INTO public."Categories" VALUES (10, 'Diseño Gráfico, UI/UX y Multimedia', 'diseno-grafico-ui-ux-multimedia', 'Diseño visual, creación de marca, interfaces de usuario y producción multimedia.', 'bi-palette', 8);
INSERT INTO public."Categories" VALUES (11, 'Idiomas y Comunicación Profesional', 'idiomas-comunicacion-profesional', 'Inglés para el trabajo, oratoria, redacción comercial y negociación internacional.', 'bi-translate', 9);
INSERT INTO public."Categories" VALUES (12, 'Ciencia de Datos e Inteligencia de Negocios', 'ciencia-datos-business-intelligence', 'Análisis de datos cuantitativos, visualización interactiva, dashboards y métricas de rendimiento.', 'bi-graph-up-arrow', 10);
INSERT INTO public."Categories" VALUES (13, 'Emprendimiento y Creación de Negocios', 'emprendimiento-creacion-negocios', 'Modelos de negocio, planes de viabilidad, validación de mercado y captación de clientes.', 'bi-rocket-takeoff', 11);
INSERT INTO public."Categories" VALUES (14, 'Salud Ocupacional, Seguridad y Primeros Auxilios', 'salud-ocupacional-seguridad-laboral', 'Prevención de riesgos laborales, ergonomía, bienestar del trabajador y protocolos de emergencia.', 'bi-heart-pulse', 12);
INSERT INTO public."Categories" VALUES (15, 'Recursos Humanos y Gestión del Talento', 'recursos-humanos-gestion-talento', 'Reclutamiento de personal, evaluación del desempeño, clima laboral y desarrollo organizacional.', 'bi-people', 13);
INSERT INTO public."Categories" VALUES (16, 'Logística, Inventarios y Cadena de Suministro', 'logistica-inventarios-cadena-suministro', 'Gestión de almacenes, control de stocks, despacho y optimización de cadenas de distribución.', 'bi-box-seam', 14);
INSERT INTO public."Categories" VALUES (17, 'Ofimática y Productividad en la Nube', 'ofimatica-productividad-nube', 'Procesadores de texto, hojas de cálculo, presentaciones y trabajo colaborativo digital.', 'bi-file-earmark-spreadsheet', 15);
INSERT INTO public."Categories" VALUES (18, 'Atención al Cliente y Negociación Comercial', 'atencion-cliente-negociacion', 'Fidelización de usuarios, resolución de reclamos, comunicación asertiva y técnicas de cierre.', 'bi-headset', 16);
INSERT INTO public."Categories" VALUES (19, 'Educación y Metodologías de Aprendizaje', 'educacion-metodologias-aprendizaje', 'Diseño instruccional, formación docente, pedagogía digital y evaluación del aprendizaje.', 'bi-mortarboard', 17);
INSERT INTO public."Categories" VALUES (20, 'Comercio Electrónico y Negocios Digitales', 'comercio-electronico-negocios-digitales', 'Creación de tiendas online, pasarelas de pago, logística de e-commerce y conversión digital.', 'bi-cart-check', 18);
INSERT INTO public."Categories" VALUES (21, 'Tecnología, IA y Ofimática', 'tecnologia-ia-ofimatica', 'Cursos de software, sistemas, comercio electrónico y herramientas digitales de alta demanda.', 'bi-laptop', 1);
INSERT INTO public."Categories" VALUES (22, 'Empleabilidad, Ventas y Gestión Comercial', 'empleabilidad-desarrollo-idiomas', 'Formación en ventas, trade marketing, atención al cliente y supervisión de piso.', 'bi-briefcase', 2);


--
-- Data for Name: Certificates; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: CourseEnrollments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: CourseModules; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."CourseModules" VALUES (14, 12, 'Módulo 1: La Triada de la Seguridad (CIA) y Amenazas Modernas: Phishing e Ingeniería Social', 1);
INSERT INTO public."CourseModules" VALUES (9, 7, 'Módulo 1: La Era de la Transformación Digital: Más que Tecnología, un Cambio Cultural', 1);
INSERT INTO public."CourseModules" VALUES (11, 9, 'Módulo 1: WhatsApp Business como Motor de Ventas y CRM de Bolsillo', 1);
INSERT INTO public."CourseModules" VALUES (10, 8, 'Módulo 1: Clasificación de Inventarios por el Método ABC (Principio de Pareto)', 1);
INSERT INTO public."CourseModules" VALUES (12, 10, 'Módulo 1: Diagnóstico Estratégico: Matrices FODA y Análisis PESTEL', 1);
INSERT INTO public."CourseModules" VALUES (18, 16, 'Módulo 1: La Experiencia del Cliente (CX) y Omnicanalidad', 1);
INSERT INTO public."CourseModules" VALUES (16, 14, 'Módulo 1: Fundamentos de la Negociación: Modelo de Harvard y Enfoque Ganar-Ganar', 1);
INSERT INTO public."CourseModules" VALUES (17, 15, 'Módulo 1: Diagnóstico del Tiempo y la Matriz de Eisenhower', 1);
INSERT INTO public."CourseModules" VALUES (19, 17, 'Módulo 1: Principios Generales y Protocolo PAS (Proteger, Avisar, Socorrer)', 1);
INSERT INTO public."CourseModules" VALUES (51, 19, 'Módulo 1: Word Profesional: Formato de Documentos, Estilos y Correspondencia', 1);
INSERT INTO public."CourseModules" VALUES (52, 19, 'Módulo 2: Excel Básico: Estructura de Celdas, Operadores y Formato de Tablas', 2);
INSERT INTO public."CourseModules" VALUES (5, 3, 'Módulo 1: Búsqueda y Extracción Avanzada: De BUSCARV a BUSCARX (XLOOKUP) e ÍNDICE/COINCIDIR', 1);
INSERT INTO public."CourseModules" VALUES (42, 3, 'Módulo 2: Lógica Condicional Multivariable: SI.CONJUNTO, Y, O, y Validación de Datos', 2);
INSERT INTO public."CourseModules" VALUES (43, 3, 'Módulo 3: Tablas Dinámicas Profesionales, Segmentadores y Campos Calculados', 3);
INSERT INTO public."CourseModules" VALUES (44, 3, 'Módulo 4: Automatización de Tareas Repetitivas con Macros Grabadas y VBA Básico', 4);
INSERT INTO public."CourseModules" VALUES (32, 2, 'Módulo 1: Fundamentos de BI y Conexión de Datos con Power Query', 1);
INSERT INTO public."CourseModules" VALUES (33, 2, 'Módulo 2: Modelado Relacional: El Esquema en Estrella (Star Schema)', 2);
INSERT INTO public."CourseModules" VALUES (34, 2, 'Módulo 3: Introducción a DAX: Columnas Calculadas vs Medidas (CALCULATE)', 3);
INSERT INTO public."CourseModules" VALUES (35, 2, 'Módulo 4: Diseño de Dashboards Ejecutivos y Storytelling de Negocios', 4);
INSERT INTO public."CourseModules" VALUES (7, 5, 'Módulo 1: SQL para Análisis de Datos: Consultas Avanzadas y Agregaciones', 1);
INSERT INTO public."CourseModules" VALUES (71, 5, 'Módulo 2: Fundamentos de Python para Ciencia de Datos: NumPy y Pandas', 2);
INSERT INTO public."CourseModules" VALUES (72, 5, 'Módulo 3: Análisis Exploratorio de Datos (EDA) y Visualización con Matplotlib y Seaborn', 3);
INSERT INTO public."CourseModules" VALUES (73, 5, 'Módulo 4: Introducción al Modelado Predictivo con Scikit-Learn', 4);
INSERT INTO public."CourseModules" VALUES (61, 20, 'Módulo 1: Combinación de Correspondencia en Word: Cartas Masivas y Contratos Automatizados', 1);
INSERT INTO public."CourseModules" VALUES (62, 20, 'Módulo 2: Fórmulas Intermedias de Excel: CONTAR.SI, SUMAR.SI y Formato Condicional', 2);
INSERT INTO public."CourseModules" VALUES (63, 20, 'Módulo 3: Gráficos Estadísticos y Tendencias en Excel', 3);
INSERT INTO public."CourseModules" VALUES (64, 20, 'Módulo 4: Presentaciones Dinámicas en PowerPoint: Patrón de Diapositivas y Animaciones', 4);
INSERT INTO public."CourseModules" VALUES (22, 1, 'Módulo 1: Arquitectura de LLMs y la Anatomía del Prompt Perfecto (Framework RTFR)', 1);
INSERT INTO public."CourseModules" VALUES (23, 1, 'Módulo 2: Técnicas Avanzadas: Few-Shot Prompting, Chain of Thought y Roles Multidisciplinarios', 2);
INSERT INTO public."CourseModules" VALUES (24, 1, 'Módulo 3: Flujos de Trabajo de Oficina: Minutas de Reunión, Contratos y Fórmulas Excel', 3);
INSERT INTO public."CourseModules" VALUES (25, 1, 'Módulo 4: Seguridad, Privacidad de Datos y Alucinaciones en Entornos Corporativos', 4);
INSERT INTO public."CourseModules" VALUES (82, 6, 'Módulo 4: Tableros Kanban, Límites WIP y Métricas de Flujo', 4);
INSERT INTO public."CourseModules" VALUES (116, 10, 'Módulo 2: De la Visión a los Objetivos: El Framework OKR (Objectives and Key Results)', 2);
INSERT INTO public."CourseModules" VALUES (117, 10, 'Módulo 3: El Cuadro de Mando Integral (Balanced Scorecard - BSC)', 3);
INSERT INTO public."CourseModules" VALUES (118, 10, 'Módulo 4: Ejecución Estratégica, Gestión de Riesgos y Cadencia de Rendición de Cuentas', 4);
INSERT INTO public."CourseModules" VALUES (13, 11, 'Módulo 1: De Jefe a Líder: Estilos de Liderazgo y Modelo Situacional', 1);
INSERT INTO public."CourseModules" VALUES (125, 11, 'Módulo 2: Conversaciones Difíciles, Feedback y Coaching 1 a 1', 2);
INSERT INTO public."CourseModules" VALUES (126, 11, 'Módulo 3: Delegación Efectiva, Autonomía y Empoderamiento', 3);
INSERT INTO public."CourseModules" VALUES (127, 11, 'Módulo 4: Liderazgo en Tiempos de Crisis, Resiliencia y Gestión del Cambio', 4);
INSERT INTO public."CourseModules" VALUES (134, 12, 'Módulo 2: Autenticación Robusta: Contraseñas Seguras, Gestores y Autenticación Multifactor (MFA)', 2);
INSERT INTO public."CourseModules" VALUES (135, 12, 'Módulo 3: Amenazas Graves: Ransomware, Criptojacking y Seguridad en Redes Wi-Fi', 3);
INSERT INTO public."CourseModules" VALUES (136, 12, 'Módulo 4: Estrategia de Respaldo 3-2-1 y Plan de Recuperación ante Desastres (DRP)', 4);
INSERT INTO public."CourseModules" VALUES (89, 7, 'Módulo 2: Computación en la Nube (Cloud Computing): SaaS, PaaS, IaaS y Costos TCO', 2);
INSERT INTO public."CourseModules" VALUES (90, 7, 'Módulo 3: Sistemas ERP y CRM: La Columna Vertebral de la Operación Corporativa', 3);
INSERT INTO public."CourseModules" VALUES (91, 7, 'Módulo 4: Ciberseguridad Gerencial y Continuidad de Negocios (BCP/DRP)', 4);
INSERT INTO public."CourseModules" VALUES (107, 9, 'Módulo 2: Técnicas de Comercio Conversacional y Cierre por Chat', 2);
INSERT INTO public."CourseModules" VALUES (108, 9, 'Módulo 3: Venta en Marketplaces (Mercado Libre y Facebook Marketplace)', 3);
INSERT INTO public."CourseModules" VALUES (109, 9, 'Módulo 4: Embudos Digitales y Métricas Financieras (CAC, LTV, ROAS)', 4);
INSERT INTO public."CourseModules" VALUES (98, 8, 'Módulo 2: Fórmulas de Abastecimiento para Evitar Quiebres de Existencia', 2);
INSERT INTO public."CourseModules" VALUES (99, 8, 'Módulo 3: Costo de Almacenamiento, Costo de Ordenar y Trade-Offs Financieros', 3);
INSERT INTO public."CourseModules" VALUES (100, 8, 'Módulo 4: Conteo Físico Ciego, Detección de Discrepancias y Ajustes Contables', 4);
INSERT INTO public."CourseModules" VALUES (8, 6, 'Módulo 1: Fundamentos de Agilidad y el Manifiesto Ágil', 1);
INSERT INTO public."CourseModules" VALUES (80, 6, 'Módulo 2: El Framework Scrum: Sprints, Ceremonias y Artefactos', 2);
INSERT INTO public."CourseModules" VALUES (81, 6, 'Módulo 3: Roles en Scrum: Product Owner, Scrum Master y Developers', 3);
INSERT INTO public."CourseModules" VALUES (170, 16, 'Módulo 2: Comunicación Escrita y Atención Telefónica de Alto Impacto', 2);
INSERT INTO public."CourseModules" VALUES (171, 16, 'Módulo 3: Gestión de Tickets, Acuerdos de Nivel de Servicio (SLA) e Incidencias', 3);
INSERT INTO public."CourseModules" VALUES (172, 16, 'Módulo 4: Manejo de Objeciones, Resolución de Reclamos y Métricas CSAT/NPS', 4);
INSERT INTO public."CourseModules" VALUES (152, 14, 'Módulo 2: Preparación Estratégica: MAAN (BATNA) y Zona de Posible Acuerdo (ZOPA)', 2);
INSERT INTO public."CourseModules" VALUES (153, 14, 'Módulo 3: Tácticas de Negociación, Concesiones y Anclaje', 3);
INSERT INTO public."CourseModules" VALUES (154, 14, 'Módulo 4: Neutralización de Tácticas Duras y Cierre de Acuerdos Sostenibles', 4);
INSERT INTO public."CourseModules" VALUES (161, 15, 'Módulo 2: Planificación Semanal, Bloques de Tiempo (Timeboxing) y Calendarios', 2);
INSERT INTO public."CourseModules" VALUES (162, 15, 'Módulo 3: Enfoque, Técnica Pomodoro y Eliminación de Ladrones de Tiempo', 3);
INSERT INTO public."CourseModules" VALUES (163, 15, 'Módulo 4: Trabajo Profundo (Deep Work) y Gestión de la Sobrecarga Digital', 4);
INSERT INTO public."CourseModules" VALUES (20, 17, 'Módulo 2: Reanimación Cardiopulmonar (RCP) Básica y Uso del DEA', 2);
INSERT INTO public."CourseModules" VALUES (179, 17, 'Módulo 3: Maniobra de Heimlich y Asfixia por Atragantamiento', 3);
INSERT INTO public."CourseModules" VALUES (180, 17, 'Módulo 4: Manejo de Hemorragias, Quemaduras, Fracturas y Botiquín Laboral', 4);
INSERT INTO public."CourseModules" VALUES (149, 13, 'Módulo 8: Sustantivos, Adjetivos, Pronombres Posesivos y Demostrativos', 8);
INSERT INTO public."CourseModules" VALUES (150, 13, 'Módulo 9: Preposiciones Fundamentales: Tiempo, Lugar, Movimiento y Transporte', 9);
INSERT INTO public."CourseModules" VALUES (151, 13, 'Módulo 10: Verbos Modales Básicos (Can, Must, Should, May, Would) y Question Tags', 10);
INSERT INTO public."CourseModules" VALUES (237, 33, 'Módulo 3: Supervisión de Piso de Venta y Prevención de Pérdidas (Merma)', 3);
INSERT INTO public."CourseModules" VALUES (238, 33, 'Módulo 4: Gestión de Cambios, Devoluciones y Manejo de Clientes Difíciles', 4);
INSERT INTO public."CourseModules" VALUES (252, 37, 'Módulo 2: El Código de Ética y Conducta Profesional', 2);
INSERT INTO public."CourseModules" VALUES (253, 37, 'Módulo 3: Confidencialidad, Manejo de Información y Whistleblowing', 3);
INSERT INTO public."CourseModules" VALUES (244, 35, 'Módulo 2: Mantenimiento Preventivo y Correctivo de Hardware y Periféricos', 2);
INSERT INTO public."CourseModules" VALUES (254, 37, 'Módulo 4: Responsabilidad Social Empresarial (RSE) y Sostenibilidad', 4);
INSERT INTO public."CourseModules" VALUES (228, 31, 'Módulo 2: Circuito de Ventas (Order to Cash) en SAP B1', 2);
INSERT INTO public."CourseModules" VALUES (229, 31, 'Módulo 3: Circuito de Compras (Procure to Pay) y Recepción de Mercancía', 3);
INSERT INTO public."CourseModules" VALUES (230, 31, 'Módulo 4: Gestión de Inventarios, Almacenes y Traslados', 4);
INSERT INTO public."CourseModules" VALUES (255, 38, 'Módulo 1: La Primera Impresión y Lenguaje Corporal en el Servicio', 1);
INSERT INTO public."CourseModules" VALUES (260, 39, 'Módulo 2: Técnicas de Picking y Packing: Preparación y Embalaje', 2);
INSERT INTO public."CourseModules" VALUES (265, 40, 'Módulo 3: Comunicación No Violenta, Asertividad y Feedback Constructivo', 3);
INSERT INTO public."CourseModules" VALUES (266, 40, 'Módulo 4: Hábitos de Productividad, Disciplina y Superación de la Procrastinación', 4);
INSERT INTO public."CourseModules" VALUES (261, 39, 'Módulo 3: Seguridad Industrial, Ergonomía y Manejo de Cargas', 3);
INSERT INTO public."CourseModules" VALUES (262, 39, 'Módulo 4: Metodología 5S en Almacenes y Control de Merma', 4);
INSERT INTO public."CourseModules" VALUES (245, 35, 'Módulo 3: Sistemas Operativos Windows: Formateo, Instalación Limpia y Drivers', 3);
INSERT INTO public."CourseModules" VALUES (246, 35, 'Módulo 4: Redes Locales (LAN), Cableado Estructurado UTP y Soporte a Cámaras CCTV', 4);
INSERT INTO public."CourseModules" VALUES (15, 13, 'Módulo 1: Pronombres Personales Sujetos y el Verbo "To Be" (Ser o Estar)', 1);
INSERT INTO public."CourseModules" VALUES (143, 13, 'Módulo 2: Los Verbos Clave "To Have" (Tener/Haber) y "To Do" (Hacer/Auxiliar)', 2);
INSERT INTO public."CourseModules" VALUES (144, 13, 'Módulo 3: La Estructura de la Oración en Inglés y los Artículos (A, An, The)', 3);
INSERT INTO public."CourseModules" VALUES (145, 13, 'Módulo 4: Present Simple (El Presente del Indicativo) y Adverbios de Frecuencia', 4);
INSERT INTO public."CourseModules" VALUES (146, 13, 'Módulo 5: Present Continuous (El Presente Continuo) vs. Present Simple', 5);
INSERT INTO public."CourseModules" VALUES (147, 13, 'Módulo 6: Past Simple (El Pasado Simple): Verbos Regulares e Irregulares', 6);
INSERT INTO public."CourseModules" VALUES (148, 13, 'Módulo 7: Las Formas de Futuro: Future Simple ("Will") vs. "Be Going To"', 7);
INSERT INTO public."CourseModules" VALUES (53, 19, 'Módulo 3: Excel Funcional: Funciones Esenciales SUMA, PROMEDIO, CONTAR y Referencias', 3);
INSERT INTO public."CourseModules" VALUES (227, 31, 'Módulo 1: Introducción a la Arquitectura SAP B1 y Datos Maestros', 1);
INSERT INTO public."CourseModules" VALUES (54, 19, 'Módulo 4: PowerPoint Efectivo: Estructura de Diapositivas y Storytelling Visual', 4);
INSERT INTO public."CourseModules" VALUES (239, 34, 'Módulo 1: Fundamentos de Trade Marketing y Niveles de Exhibición', 1);
INSERT INTO public."CourseModules" VALUES (251, 37, 'Módulo 1: Identidad Corporativa: Misión, Visión y Valores en Acción', 1);
INSERT INTO public."CourseModules" VALUES (231, 32, 'Módulo 1: Arquitectura de Shopify y Configuración Inicial de la Tienda', 1);
INSERT INTO public."CourseModules" VALUES (256, 38, 'Módulo 2: Escucha Activa, Preguntas Clave y Sondeo', 2);
INSERT INTO public."CourseModules" VALUES (232, 32, 'Módulo 2: Catálogo de Productos, Variantes, Inventario y Colecciones', 2);
INSERT INTO public."CourseModules" VALUES (257, 38, 'Módulo 3: Manejo de Situaciones Difíciles y Clientes Conflictivos', 3);
INSERT INTO public."CourseModules" VALUES (233, 32, 'Módulo 3: Pasarelas de Pago, Tarifas de Envío y Logística', 3);
INSERT INTO public."CourseModules" VALUES (234, 32, 'Módulo 4: Gestión de Pedidos, Carritos Abandonados y Retención', 4);
INSERT INTO public."CourseModules" VALUES (240, 34, 'Módulo 2: Interpretación y Ejecución de Planogramas', 2);
INSERT INTO public."CourseModules" VALUES (241, 34, 'Módulo 3: Rotación FEFO/FIFO y Cero Vencimientos', 3);
INSERT INTO public."CourseModules" VALUES (235, 33, 'Módulo 1: Operaciones de Caja, POS y Arqueo Diario', 1);
INSERT INTO public."CourseModules" VALUES (243, 35, 'Módulo 1: Niveles de Soporte Técnico (L1/L2/L3) y Gestión de Tickets de Incidencia', 1);
INSERT INTO public."CourseModules" VALUES (236, 33, 'Módulo 2: Técnicas de Venta en Piso: Venta Cruzada y Elevación del Ticket', 2);
INSERT INTO public."CourseModules" VALUES (264, 40, 'Módulo 2: Dinámicas de Grupo, Sinergia y Roles de Belbin', 2);
INSERT INTO public."CourseModules" VALUES (242, 34, 'Módulo 4: Material POP, Exhibiciones Adicionales y Relación con el Jefe de Piso', 4);
INSERT INTO public."CourseModules" VALUES (247, 36, 'Módulo 1: La Estructura Organizacional y Departamentos Clave', 1);
INSERT INTO public."CourseModules" VALUES (248, 36, 'Módulo 2: De la Requisición Interna a la Orden de Compra y Pago a Proveedores', 2);
INSERT INTO public."CourseModules" VALUES (249, 36, 'Módulo 3: Cotizaciones, Emisión de Facturas, Cobro y Gestión de Cartera', 3);
INSERT INTO public."CourseModules" VALUES (258, 38, 'Módulo 4: Fidelización, Programas de Lealtad y Momentos Wow', 4);
INSERT INTO public."CourseModules" VALUES (263, 40, 'Módulo 1: Inteligencia Emocional y Autoliderazgo en el Trabajo', 1);
INSERT INTO public."CourseModules" VALUES (250, 36, 'Módulo 4: Diseño de Informes Ejecutivos, Tableros de Control y Resumen Financiero Básico', 4);
INSERT INTO public."CourseModules" VALUES (259, 39, 'Módulo 1: Distribución Física del Almacén (Layout) y Zonas Operativas', 1);


--
-- Data for Name: Courses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Courses" VALUES (10, 1, 'Planificación Estratégica: De la Visión a la Ejecución con OKRs y Cuadro de Mando', 'planificacion-estrategica', 'El puente entre la teoría y los resultados: Diagnóstico FODA y PESTEL, diseño de Objetivos y Resultados Clave (OKRs), Cuadro de Mando Integral (BSC) y cadencia de ejecución.', 'Capacitación de nivel directivo para gerentes, supervisores y emprendedores. Domina el diagnóstico estratégico mediante matrices FODA cruzadas y análisis del macroentorno PESTEL; implementa la metodología OKR (Objectives and Key Results) utilizada por Google e Intel para alinear a toda la empresa hacia metas ambiciosas; estructura el Cuadro de Mando Integral (Balanced Scorecard) en sus 4 perspectivas; y lidera revisiones periódicas de rendición de cuentas.', 'Avanzado', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.633137-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (32, 1, 'Shopify Básico: Creación, Configuración y Gestión de Tiendas Online', 'shopify-comercio-electronico-tiendas-online', 'Aprende a montar y operar una tienda virtual profesional con Shopify: arquitectura, catálogo con variantes, pasarelas de pago, logística de envíos y retención de carritos abandonados.', 'Capacitación práctica y completa en comercio electrónico con la plataforma líder mundial. Domina la configuración de monedas, impuestos y dominios personalizados; crea fichas de producto optimizadas para la venta con variantes de talla y color; organiza colecciones automatizadas con etiquetas; configura checkouts y métodos de pago; y gestiona pedidos diarios y automatizaciones de email marketing para recuperar carritos abandonados.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 15:44:12.716172-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (33, 1, 'Asistente de Ventas Comercial: Gestión Administrativa, Atención y Supervisión en Piso', 'asistente-de-ventas-comercial-supervision', 'Formación práctica para asistentes comerciales y líderes de salón: manejo de caja y arqueos diarios sin faltantes, venta consultiva, control de merma y resolución de quejas.', 'Capacitación orientada al trabajo diario en tiendas de retail, supermercados, ferreterías y comercios. Aprende el protocolo riguroso de apertura y cierre de caja; domina las técnicas de Cross-Selling (Venta Cruzada) y Up-Selling para elevar el ticket promedio; aplica protocolos de prevención de pérdidas y control de farderos; y lidera la gestión de cambios y reclamos con máxima asertividad comercial.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 15:44:12.839171-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (35, 21, 'Servicio Técnico Informático y Soporte a Sistemas: Hardware, Redes y Mantenimiento', 'servicio-tecnico-informatico-soporte-sistemas', 'Formación integral para técnicos de soporte y mesa de ayuda: diagnóstico de hardware, mantenimiento preventivo/correctivo, instalación de Windows, cableado estructurado UTP y gestión de tickets.', 'Capacitación práctica orientada a formar técnicos de soporte en entornos corporativos y centros de servicio. Aprende a diagnosticar fallas de placa madre, procesador, memoria RAM y almacenamiento SMART; domina el protocolo ESD de descarga electrostática y sustitución de pasta térmica; realiza instalaciones limpias de Windows con esquema GPT/UEFI y crimpa cableado estructurado bajo la norma T568B para redes de oficina.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 15:44:13.274583-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (31, 1, 'SAP Business One (SAP B1): Gestión Operativa de Ventas, Compras e Inventarios', 'sap-business-one-b1-gestion-operativa', 'Domina el ERP estándar mundial de las PYMES y medianas empresas: datos maestros, circuito completo de ventas (Order to Cash), compras (Procure to Pay) y control de stock.', 'Capacitación práctica orientada al manejo real de SAP Business One. Aprende a crear Socios de Negocios y Artículos; procesar ofertas de ventas, órdenes y entregas; gestionar solicitudes de compra, pedidos y entradas de mercancías (GRPO); emitir facturas legales y realizar recuentos físicos de inventario con análisis de diferencias.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 15:44:12.439723-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (34, 1, 'Mercaderista y Trade Merchandising: Exhibición, Rotación y Gestión en Punto de Venta', 'mercaderista-trade-merchandising-punto-venta', 'El arte de vender en el anaquel: Trade Marketing, planogramas, niveles visuales de exhibición, rotación estricta FEFO/PEPS contra caducidades y material publicitario POP.', 'Capacitación especializada para mercaderistas, promotores y supervisores de canal moderno (supermercados, farmacias, tiendas de conveniencia). Aprende a conquistar la ''Zona Caliente'' de la góndola (a la altura de los ojos y de las manos); ejecuta planogramas con criterio de Share of Shelf; aplica rotación estricta de fechas de vencimiento (FEFO); negocia espacios adicionales con el jefe de piso; e instala material POP de alto impacto.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 15:44:13.039293-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (1, 21, 'Domina la IA con Gemini y ChatGPT: Prompt Engineering Avanzado y Productividad Empresarial', 'domina-la-ia-con-gemini', 'Aprende a redactar prompts de nivel profesional, estructurar contextos con Few-Shot prompting, automatizar minutas de reuniones, analizar datos y redactar informes de oficina.', 'Capacitación práctica y avanzada en Inteligencia Artificial Generativa aplicada al trabajo corporativo. Domina la anatomía del prompt perfecto (Rol, Contexto, Instrucción, Formato de salida y Restricciones), técnicas de Few-Shot y Chain-of-Thought, automatización de resúmenes ejecutivos, formulación de consultas complejas en Excel, redacción de correos comerciales de alta persuasión y análisis ético de seguridad de datos corporativos.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.367815-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (36, 1, 'Administración Empresarial Básica: Estructura, Compras, Ventas y Reportes', 'administracion-empresarial-procesos-reportes', 'El mapa de operaciones corporativo: organigramas, circuito de compras y cuentas por pagar, ciclo de facturación y cobranza, e informes ejecutivos para la toma de decisiones.', 'Capacitación práctica y transversal para asistentes administrativos, secretarias ejecutivas y supervisores de área. Conoce los departamentos clave de una empresa y cómo interactúan entre sí; domina el ciclo de compras desde la requisición interna hasta la orden de compra y el pago a proveedores; gestiona la emisión de facturas y la cobranza sin fricciones; y elabora informes ejecutivos y tableros de control claros para la gerencia.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 16:05:37.092487-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (39, 1, 'Auxiliar de Almacén, Control de Inventarios y Logística Básica', 'auxiliar-almacen-inventarios-logistica', 'Formación práctica para operarios y auxiliares logísticos: diseño de Layout, técnicas de Picking y Packing, seguridad industrial con EPP, y metodología 5S en bodegas.', 'Capacitación 100% orientada al trabajo físico y operativo en centros de distribución y almacenes comerciales. Aprende a interpretar la zonificación y layout del almacén (muelles, pulmón, picking, consolidación); domina los métodos de picking por olas y packing seguro con film plástico; aplica protocolos de ergonomía y manejo seguro de cargas manuales y montacargas; e implementa la metodología 5S para mantener orden y cero accidentes.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 16:05:37.913389-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (37, 1, 'Filosofía Empresarial, Cultura Organizacional y Ética Laboral', 'filosofia-empresarial-etica-laboral', 'Comprende el ADN corporativo: valores, código de ética, prevención de conflictos de interés, cumplimiento normativo y cultura de integridad.', 'Formación fundamental para todo profesional y líder en el entorno empresarial. Aprende cómo se construye la identidad corporativa a través de la misión, visión y valores, cómo aplicar el código de conducta en dilemas éticos reales, prevención del soborno y fraude, manejo de información confidencial y canales de denuncia protegidos (Whistleblowing).', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 16:05:37.409331-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (38, 1, 'Atención al Cliente Presencial, Comunicación Asertiva y Fidelización', 'atencion-al-cliente-presencial-fidelizacion', 'Domina el contacto cara a cara: lenguaje corporal, escucha activa, desactivación de clientes molestos, protocolos de servicio y técnicas de fidelización.', 'Capacitación de alto impacto orientada a personal de recepción, atención en ventanilla, retail y servicios presenciales. Aprende a causar una primera impresión imborrable en los primeros 7 segundos, aplicar técnicas de modulación de voz y postura abierta, calmar situaciones tensas con el método LAST (Listen, Apologize, Solve, Thank) y construir programas de fidelización duradera.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 16:05:37.711979-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (40, 1, 'Trabajo en Equipo, Liderazgo Personal y Productividad Laboral', 'trabajo-en-equipo-habilidades-blandas-productividad', 'Potencia tu perfil profesional: inteligencia emocional (Goleman), roles de equipo Belbin, comunicación no violenta, seguridad psicológica y hábitos de alto rendimiento.', 'Capacitación práctica para profesionales que buscan destacar y prosperar en organizaciones modernas. Desarrolla las habilidades blandas (power skills) más buscadas por los reclutadores: autoconocimiento, autorregulación ante la frustración, empatía activa, roles complementarios en el trabajo colaborativo, técnicas para dar y recibir feedback constructivo y erradicación de la procrastinación laboral.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-19 16:05:38.241771-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (5, 21, 'Ciencia y Análisis de Datos con Python y SQL: De Consultas a Machine Learning', 'ciencia-y-analisis-de-datos', 'Domina el stack técnico de los Científicos de Datos: consultas analíticas con SQL (GROUP BY, JOINs), manipulación masiva con Pandas/NumPy y modelado con Scikit-Learn.', 'Capacitación intensiva para analistas que desean superar las barreras de Excel y dominar el lenguaje de las grandes empresas. Aprende a escribir consultas complejas en PostgreSQL y MySQL utilizando JOINs y subconsultas; manipula DataFrames de millones de filas en Python con Pandas; genera visualizaciones científicas con Matplotlib y Seaborn; y entrena tus primeros modelos predictivos de Machine Learning supervisado.', 'Avanzado', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.572994-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (9, 1, 'Ventas en Línea: Estrategia Digital, Social Selling y Embudos de Conversión', 'ventas-en-linea', 'Domina el comercio conversacional y digital: ventas de alto impacto por WhatsApp Business, catálogos en Marketplaces (Mercado Libre, Facebook) y optimización de embudos.', 'Capacitación orientada a vendedores, emprendedores y asesores de comercio moderno. Aprende a convertir chats de WhatsApp Business en cierres de venta reales; domina las respuestas rápidas, etiquetas de seguimiento y catálogos de bolsillo; optimiza publicaciones en Marketplaces con palabras clave y reputación positiva; y calcula métricas clave del embudo digital como el Costo de Adquisición de Clientes (CAC) y el Retorno de Inversión Publicitaria (ROAS).', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.620779-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (13, 3, 'Inglés A1 / English Fundamentals', 'ingles-a1-english-fundamentals', 'Programa completo de gramática, vocabulario y expresiones prácticas de nivel A1 basado en el temario estructurado de AulaFácil.', 'Curso completo de gramática y comunicación en inglés nivel principiante (A1) basado en el temario de AulaFácil. Incluye pronombres, verbo To Be, verbos auxiliares To Have y To Do, Present Simple, Present Continuous, Past Simple con verbos regulares e irregulares, futuros con Will y Going To, preposiciones de tiempo y lugar, pronombres demostrativos/posesivos y verbos modales.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'info', true, '2026-10-17 22:40:23.670945-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (2, 21, 'Power BI: Modelado de Datos, DAX y Construcción de Dashboards Ejecutivos', 'power-bi', 'Convierte datos crudos en decisiones estratégicas: ETL con Power Query, modelado relacional en estrella, fórmulas analíticas en DAX (CALCULATE) y tableros interactivos.', 'Formación corporativa completa en Business Intelligence con Microsoft Power BI. Domina la extracción y limpieza automatizada de datos (ETL) con Power Query; diseña modelos de datos robustos bajo el Esquema en Estrella (Star Schema) con relaciones 1 a Varios; escribe medidas analíticas dinámicas utilizando DAX avanzado (CALCULATE, ALL, FILTER, RELATED); y construye dashboards ejecutivos aplicando principios de Storytelling y diseño UX/UI.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.531532-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (12, 21, 'Introducción a la Ciberseguridad: Defensa contra Phishing, Ransomware y Gestión de Redes Corporativas', 'introduccion-ciberseguridad', 'Aprende los pilares de la seguridad informática empresarial: triada CIA, autenticación multifactor (MFA), prevención de ingeniería social, protección de redes Wi-Fi y protocolos de respaldo 3-2-1.', 'Capacitación vital para cualquier profesional en el entorno digital moderno. Conoce la anatomía de los ataques cibernéticos más destructivos (Phishing, Spear Phishing, Ransomware, Man-in-the-Middle), los fundamentos de la criptografía y certificados SSL/TLS, configuración de firewalls y redes privadas virtuales (VPN), gestión segura de credenciales y planes de continuidad de negocio ante incidentes de seguridad.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.659846-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (7, 21, 'Tecnología de la Información para el Éxito Empresarial: Transformación Digital y Sistemas Corporativos', 'ti-para-el-exito-empresarial', 'Comprende la visión estratégica de la tecnología: computación en la nube (SaaS, PaaS, IaaS), sistemas empresariales ERP y CRM, y gestión del riesgo tecnológico para líderes y directores.', 'Capacitación directiva y técnica diseñada para que profesionales, supervisores y gerentes comprendan el impacto de la tecnología en la rentabilidad y la escala del negocio. Aprende a evaluar costos totales de propiedad (TCO), liderar migraciones hacia servicios cloud en Amazon Web Services (AWS) y Microsoft Azure, seleccionar e implementar sistemas ERP/CRM sin fricciones operativas y formular planes de continuidad de negocio (BCP/DRP).', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.597637-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (8, 1, 'Administración y Control de Inventarios: Modelos ABC, Stocks de Seguridad y Auditoría', 'administracion-de-inventario', 'Domina la gestión matemática de almacenes: Clasificación ABC por Pareto, cálculo del Punto de Reorden (ROP), Lote Económico (EOQ), stock de seguridad y tomas físicas.', 'Capacitación especializada para analistas de inventario, jefes de almacén y administradores de logística. Aprende a clasificar existencias con el Principio de Pareto (Modelo ABC); calcula puntos óptimos de reabastecimiento (ROP) y stocks de seguridad para eliminar quiebres de existencias; equilibra los costos de ordenar contra los costos de almacenamiento con el modelo EOQ; y ejecuta auditorías cíclicas y tomas físicas ciegas con conciliación contable.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.608921-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (6, 1, 'Gestión de Proyectos con Agile y Scrum: Sprints, Roles y Tableros Kanban', 'gestion-proyectos-agile', 'Domina la gestión moderna de proyectos: Manifiesto Ágil, el Framework Scrum (Sprints, ceremonias y artefactos), roles (PO, SM) y tableros visuales Kanban con límites WIP.', 'Capacitación integral en metodologías ágiles demandada en industrias tecnológicas, financieras y de consultoría. Comprende la superación del modelo tradicional en Cascada (Waterfall); domina los roles en Scrum (Product Owner, Scrum Master y Desarrolladores); lidera las cuatro ceremonias (Sprint Planning, Daily, Sprint Review y Retrospectiva); gestiona el Product Backlog; e implementa tableros Kanban controlando el trabajo en curso (WIP).', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.584866-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (11, 1, 'Liderazgo Efectivo: Inteligencia Emocional, Coaching y Gestión de Equipos', 'liderazgo-efectivo', 'Pasa de jefe a líder inspirador: modelo situacional de Hersey-Blanchard, reuniones 1 a 1, delegación efectiva sin micromanagement y liderazgo en crisis.', 'Capacitación directiva orientada a supervisores, jefes de área, gerentes y coordinadores. Aprende a adaptar tu estilo de liderazgo según la madurez y competencia de cada colaborador (Liderazgo Situacional), liderar reuniones individuales de coaching (One-on-One) de alto impacto, delegar tareas con niveles de autonomía claros y mantener la cohesión en momentos de incertidumbre y crisis.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.646311-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (3, 21, 'Excel Avanzado: Modelado Financiero, Fórmulas Anidadas, Tablas Dinámicas y Macros', 'excel-avanzado', 'Lleva tus habilidades de análisis al nivel profesional: funciones de búsqueda avanzada (XLOOKUP/BUSCARX), lógica condicional compleja, tablas dinámicas analíticas y automatización con macros VBA.', 'Capacitación de alto nivel para analistas financieros, contadores y supervisores de operaciones. Domina la transición moderna de BUSCARV hacia BUSCARX e ÍNDICE/COINCIDIR bidireccional; estructura fórmulas anidadas con SI.CONJUNTO y operadores booleanos Y/O; diseña cuadros de mando interactivos con Tablas Dinámicas, campos calculados y segmentadores; y automatiza procesos repetitivos con macros grabadas y código VBA esencial.', 'Avanzado', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.548932-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (16, 1, 'Atención al Cliente: Excelencia Omnicanal, Protocolos y Resolución de Quejas', 'atencion-al-cliente', 'Domina el servicio en todos los canales: telefónico, chat en vivo, correo y redes. Gestión de tickets (SLA), indicadores CSAT y paradoja de recuperación.', 'Capacitación integral para agentes de contact center, soporte al usuario y coordinadores de servicio. Aprende a redactar respuestas formales por correo y chat, modular la voz en llamadas telefónicas, cumplir tiempos de respuesta según Acuerdos de Nivel de Servicio (SLA), revertir quejas con la Paradoja de Recuperación del Servicio y medir el CSAT y CES.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.708746-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (14, 1, 'Tácticas de Negociación Efectiva: El Método Harvard y Acuerdos Ganar-Ganar', 'tacticas-de-negociacion-efectiva', 'Domina el modelo de negociación más prestigioso del mundo: intereses vs. posiciones, MAAN (BATNA), ZOPA, criterios objetivos y gestión de concesiones.', 'Capacitación práctica en el Proyecto de Negociación de Harvard (Fisher, Ury y Patton). Aprende a separar a las personas del problema, identificar los intereses reales ocultos detrás de posiciones inflexibles, calcular tu Mejor Alternativa a un Acuerdo Negociado (MAAN / BATNA), mapear la Zona de Posible Acuerdo (ZOPA) y neutralizar tácticas sucias de negociación.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.680544-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (15, 1, 'Gestión del Tiempo y Productividad: Eisenhower, Pomodoro y Trabajo Profundo', 'gestion-del-tiempo', 'Domina tu jornada laboral: Matriz de Eisenhower (Urgente vs Importante), técnica Pomodoro, Timeblocking en calendario y Trabajo Profundo (Deep Work).', 'Capacitación de alto impacto orientada a profesionales que sufren de dispersión, saturación por correos y sensación de apagar fuegos todo el día. Aprende a clasificar tareas con la Matriz de Eisenhower, implementar bloques de tiempo ininterrumpidos en Google Calendar / Outlook, aplicar la técnica Pomodoro para sesiones de hiperenfoque y gestionar las distracciones digitales de Slack y WhatsApp.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.694924-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (19, 21, 'Microsoft Office Básico: Word, Excel y PowerPoint para el Entorno Laboral', 'office-basico', 'Domina las herramientas indispensables de oficina: redacción de documentos formales en Word, hojas de cálculo y fórmulas básicas en Excel, y presentaciones de impacto en PowerPoint.', 'Formación integral y práctica orientada al trabajo diario de oficina. Aprende desde el formato profesional de correspondencia, memorándums e informes en Word, hasta el diseño de tablas ordenadas, sumatorias y porcentajes en Excel, y la estructuración de diapositivas ejecutivas en PowerPoint sin sobrecargar texto.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-18 03:29:35.279975-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (20, 21, 'Microsoft Office Intermedio: Gestión Documental, Fórmulas de Análisis y Presentaciones Avanzadas', 'office-intermedio', 'Domina el puente hacia la productividad avanzada: combinación de correspondencia masiva en Word, fórmulas estadísticas en Excel (CONTAR.SI, SUMAR.SI) y plantillas maestras en PowerPoint.', 'Capacitación enfocada en optimizar los tiempos de respuesta administrativos. Aprende a redactar contratos y cartas masivas conectando Word con bases de datos en Excel; domina las fórmulas de conteo y suma condicional con múltiples criterios; analiza tendencias con gráficos estadísticos profesionales; y estandariza la imagen institucional de tu empresa utilizando el Patrón de Diapositivas en PowerPoint.', 'Intermedio', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-18 03:29:35.369305-04', NULL, NULL, NULL, 1.00);
INSERT INTO public."Courses" VALUES (17, 1, 'Primeros Auxilios Laborales y Emergencias: Protocolo PAS, RCP y Bioseguridad', 'primeros-auxilios', 'Salva vidas en el trabajo: protocolo PAS (Proteger, Avisar, Socorrer), RCP básica en adultos, Maniobra de Heimlich, quemaduras y control de hemorragias.', 'Capacitación práctica indispensable de seguridad laboral y salud en el trabajo. Aprende a mantener la calma y actuar con rigor científico ante accidentes: aplicación del protocolo PAS, reconocimiento de paros cardiorrespiratorios y compresiones torácicas de alta calidad (RCP), desobstrucción de la vía aérea (Heimlich), vendajes compresivos para hemorragias, quemaduras y botiquín reglamentario.', 'Básico', 20, 70.00, '/images/default-course.jpg', 'primary', true, '2026-10-17 22:40:23.722038-04', NULL, NULL, NULL, 1.00);


--
-- Data for Name: LessonProgresses; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: Lessons; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Lessons" VALUES (10, 10, 'Categorización por Valor Monetario y Frecuencia de Movimiento', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-pie-chart-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Principio de Pareto: No Todos los Productos se Cuidan por Igual</h5>
            <p class="mb-0 small">Intentar auditar y controlar con la misma intensidad los tornillos de $0.05 que los motores de $5.000 USD es un error que satura al personal de almacén. La clasificación ABC focaliza el esfuerzo de control en el 20% de los artículos que concentran el 80% del capital de la empresa.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/NMu9evFpGps" title="Análisis ABC de Inventarios y PARETO - Paso a paso en EXCEL" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Jerarquía del Modelo ABC</h4>
    <p>Basado en el <strong>Principio de Pareto (Regla del 80/20)</strong> formulado por Vilfredo Pareto, el método ABC categoriza el catálogo de productos evaluando su <em>Valor Monetario Anual de Utilización (Ventas Totales = Demanda Anual × Costo Unitario)</em>:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Categoría</th>
                    <th>% de Artículos Físicos (SKUs)</th>
                    <th>% del Valor Monetario Acumulado</th>
                    <th>Protocolo de Custodia y Auditoría Obligatorio</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger fs-6">Artículos A</td>
                    <td>10% a 20%</td>
                    <td><strong>70% a 80%</strong> del capital</td>
                    <td><strong>Máxima Prioridad:</strong> Conteos cíclicos semanales, resguardo bajo llave o jaulas de seguridad, órdenes de compra ajustadas al consumo semanal y cero tolerancia a discrepancias.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark fs-6">Artículos B</td>
                    <td>20% a 30%</td>
                    <td><strong>15% a 20%</strong> del capital</td>
                    <td><strong>Prioridad Moderada:</strong> Conteos mensuales, pedidos mensuales estandarizados y monitoreo regular de rotación.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-secondary fs-6">Artículos C</td>
                    <td>50% a 60%</td>
                    <td><strong>Apenas 5% a 10%</strong> del capital</td>
                    <td><strong>Control Simplificado:</strong> Compras en grandes volúmenes para ahorrar fletes (pedidos para 3 a 6 meses), conteo semestral o anual y almacenamiento abierto sin burocracia excesiva.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator text-primary me-2"></i>2. Paso a Paso para Construir la Clasificación ABC en Excel</h4>
    <ol>
        <li>Listar todos los SKUs con su <code>Costo Unitario</code> y su <code>Demanda Anual en Unidades</code>.</li>
        <li>Crear la columna <code>Valor Total = Costo × Demanda</code>.</li>
        <li>Ordenar la tabla completa de <strong>Mayor a Menor</strong> según la columna <code>Valor Total</code>.</li>
        <li>Calcular el <code>% de Participación Individual = Valor Total / Suma Total</code>.</li>
        <li>Crear la columna <code>% Acumulado</code> sumando progresivamente las participaciones de arriba hacia abajo.</li>
        <li>Aplicar la regla condicional:
            <ul>
                <li>Hasta el 80% acumulado ➔ <strong>Categoría A</strong>.</li>
                <li>Del 80% al 95% acumulado ➔ <strong>Categoría B</strong>.</li>
                <li>Del 95% al 100% acumulado ➔ <strong>Categoría C</strong>.</li>
            </ul>
        </li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Clasificar únicamente por volumen de unidades vendidas y no por valor monetario:</strong> Vender 10.000 tuercas de $0.02 representa apenas $200 USD de movimiento; vender 5 servidores de $8.000 representa $40.000 USD. El valor monetario siempre manda en el análisis ABC.</li>
        <li><strong>No considerar la criticidad operativa del artículo:</strong> Aunque un fusible especial cueste solo $2 (Categoría C), si ese fusible se quema y no hay repuesto en almacén la fábrica entera se detiene. Estos insumos críticos deben reclasificarse como <em>''A Crítico''</em> con stock de seguridad obligatorio.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Actualizas tu clasificación ABC al menos dos veces al año según las variaciones de demanda?</li>
            <li>¿Están los artículos A resguardados en zonas de acceso restringido con auditoría semanal?</li>
            <li>¿Identificaste los repuestos de bajo costo pero críticos para la continuidad operativa?</li>
        </ul>
    </div>
</div>', 'Domina la regla 80/20 aplicada a bodegas: clasifica SKUs en Tipo A (alto valor), Tipo B (rotación media) y Tipo C (artículos masivos de bajo costo), optimizando el tiempo de control y custodia.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (98, 98, 'Cálculo del Punto de Reorden (ROP) y Stock de Seguridad (Safety Stock)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-graph-up-arrow fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Punto de Reorden: Cuándo Emitir la Orden de Compra con Exactitud Matemática</h5>
            <p class="mb-0 small">Esperar a que el estante quede vacío para pedir mercancía al proveedor garantiza un quiebre de stock. El Punto de Reorden te dice el número exacto de unidades al que debe bajar el inventario para encender la alarma de compra.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/3kSM2bu0KkA" title="Cómo Calcular el PUNTO DE REORDEN en Inventarios" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Fórmula Universal del Punto de Reorden (ROP)</h4>
    <p>El <strong>Punto de Reorden (Reorder Point - ROP)</strong> es el nivel de existencias que dispara una nueva orden de compra para que el camión del proveedor llegue exactamente cuando el inventario operativo llegue a su nivel de seguridad:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <code class="fs-6 fw-bold">Punto de Reorden (ROP) = (Demanda Diaria Promedio × Tiempo de Entrega en Días) + Stock de Seguridad</code>
    </div>
    <ul>
        <li><strong>Demanda Diaria Promedio (d):</strong> Cuántas unidades se venden o consumen en promedio cada día (Ventas mensuales / 30).</li>
        <li><strong>Tiempo de Entrega / Lead Time (L):</strong> Los días exactos que tarda el proveedor desde que recibe la orden de compra hasta que descarga la mercancía en el almacén.</li>
        <li><strong>Stock de Seguridad (SS):</strong> El colchón de reserva destinado a absorber picos inesperados de demanda o demoras del transporte.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-success me-2"></i>2. Cálculo del Stock de Seguridad (Safety Stock)</h4>
    <p>Para no sobredimensionar el inventario ni quedarse corto, se calcula el Stock de Seguridad considerando la variabilidad del proveedor y del mercado:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center">
        <code>Stock de Seguridad (SS) = (Venta Diaria Máxima × Plazo Máximo de Entrega) - (Venta Diaria Promedio × Plazo Promedio)</code>
    </div>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        <strong>Ejemplo Real de Oficina:</strong><br />
        - Vendemos en promedio <strong>20 cajas de aceite al día</strong> (en días picos vendemos 35).<br />
        - El proveedor tarda en promedio <strong>5 días</strong> en entregar (si se retrasa tarda 8 días).<br /><br />
        Cálculo del Stock de Seguridad: <code>(35 × 8) - (20 × 5) = 280 - 100 = 180 cajas</code>.<br />
        Cálculo del ROP: <code>(20 × 5) + 180 = 100 + 180 = 280 cajas</code>.<br /><br />
        <em>Veredicto operativo:</em> En el instante en que el conteo de almacén marque <strong>280 cajas</strong>, el analista debe emitir la orden de compra de inmediato.
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Considerar el Lead Time del proveedor como días de calendario en lugar de días hábiles:</strong> Si el proveedor trabaja solo de lunes a viernes y promete ''5 días de entrega'', una orden emitida un miércoles llegará el miércoles siguiente (7 días calendario de espera real).</li>
        <li><strong>Mantener el mismo ROP en temporadas altas (Navidad / Día de la Madre):</strong> La demanda promedio cambia drásticamente en temporadas pico. Los parámetros de ROP y Stock de Seguridad deben recalcularse estacionalmente para no quebrar inventario en las semanas de mayores ventas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Calculaste el ROP considerando el Lead Time real del proveedor puerta a puerta?</li>
            <li>¿Tienes configurado un Stock de Seguridad para proteger a la empresa de retrasos logísticos?</li>
            <li>¿Ajustas los parámetros de demanda antes de iniciar temporadas comerciales altas?</li>
        </ul>
    </div>
</div>', 'Domina la matemática de reabastecimiento: Punto de Reorden (ROP), tiempo de entrega del proveedor (Lead Time), demanda promedio diaria y cálculo del Stock de Seguridad para resistir retrasos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (100, 100, 'Auditoría de Almacén: Del Marbete al Acta de Diferencias de Inventario', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-clipboard2-check-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Auditoría de Inventario: La Verdad Detrás de las Cifras del Sistema</h5>
            <p class="mb-0 small">Una hoja de cálculo o un sistema ERP puede decir que en la bodega hay 500 laptops. Si al abrir el candado físico del almacén solo hay 480, la empresa tiene una pérdida patrimonial real que debe auditarse, investigarse y ajustarse legalmente.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/YP4584tjhC8" title="Control de Inventarios y Auditoría de Bodega" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Conteo Físico General vs Conteos Cíclicos</h4>
    <p>En la gestión moderna de bodegas existen dos filosofías de auditoría:</p>
    <ul>
        <li><strong>Toma Física Anual Total:</strong> Paralizar toda la empresa durante un fin de semana completo, cerrar puertas y contar cada tornillo del almacén. Es costosa, agota al personal y detecta las pérdidas cuando ya es demasiado tarde para encontrar a los responsables.</li>
        <li><strong>Conteos Cíclicos Continuos (Recomendado):</strong> Auditar todos los días un grupo pequeño de SKUs según su categoría ABC (los productos A se cuentan semanalmente, los B mensualmente y los C semestralmente). No paraliza la empresa, mantiene el inventario con más del 98% de exactitud todo el año (IRA - Inventory Record Accuracy) y detecta hurtos o errores de digitación en el momento en que ocurren.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tags-fill text-primary me-2"></i>2. La Metodología del Conteo Ciego con Marbetes de Doble Talón</h4>
    <p>Para garantizar que los operarios no ''adivinen'' o copien los saldos teóricos del sistema, se aplica el <strong>Conteo Ciego</strong> utilizando marbetes numerados:</p>
    <ol>
        <li><strong>Marbete de Doble Talón:</strong> Tarjeta física numerada consecutivamente que se adhiere a cada tarima o lote en el estante.</li>
        <li><strong>Primer Conteo (Auditor 1):</strong> Cuenta físicamente las unidades, escribe la cantidad en el Talón 1, lo desprende y lo entrega a la mesa de control sin dejar marca visible en la tarima.</li>
        <li><strong>Segundo Conteo Independiente (Auditor 2):</strong> Pasa otro operario distinto y cuenta la misma tarima, anotando en el Talón 2.</li>
        <li><strong>Confrontación en Mesa de Control:</strong> Si el Talón 1 y el Talón 2 coinciden exactamente, el dato se da por bueno. Si hay discrepancia (uno contó 45 y el otro 48), un supervisor realiza un tercer conteo en su presencia para definir la cifra definitiva.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-file-earmark-diff text-danger me-2"></i>3. Detección de Discrepancias y el Indicador IRA</h4>
    <p>El indicador de calidad logística fundamental es el <strong>IRA (Exactitud del Registro de Inventario)</strong>:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center">
        <code>IRA % = (Cantidad de SKUs con Saldo Físico Exacto / Total de SKUs Auditados) × 100</code>
    </div>
    <p class="small text-muted">Un almacén de clase mundial mantiene un IRA superior al <strong>98%</strong>. Las discrepancias típicas suelen originarse en: errores de digitación en ingresos de compras, códigos de barra cruzados (entregar el producto X pensando que era el producto Y) o sustracción de mercancía.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Entregar la lista con las cantidades teóricas a los operarios que cuentan:</strong> Si el operario ve en el papel que el sistema dice ''50 unidades'', mirará de lejos el estante y escribirá ''50'' para terminar rápido sin contar bulto por bulto. El conteo ciego es la única garantía de verdad.</li>
        <li><strong>Mover mercancía o despachar camiones durante la toma física:</strong> Si el almacén está en proceso de conteo y se reciben despachos de camiones o se mueven tarimas entre pasillos, los productos se contarán dos veces o no se contarán, arruinando toda la auditoría. El almacén debe estar estrictamente ''congelado'' durante la toma de datos.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Implementaste conteos cíclicos semanales para productos de alto valor (Categoría A)?</li>
            <li>¿Aplicas marbetes y conteo ciego sin entregar saldos teóricos al personal de campo?</li>
            <li>¿Documentas cada ajuste de inventario con acta formal firmada por auditoría y gerencia?</li>
        </ul>
    </div>
</div>', 'Domina la técnica de auditoría de inventarios: el conteo cíclico vs la toma física anual, el uso de marbetes numerados de doble talón, el conteo ciego y la conciliación de mermas y faltantes.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (80, 80, 'La Cadencia del Sprint: Planning, Daily, Review y Retrospectiva', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-stopwatch-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Scrum: El Ritmo Cardíaco del Desarrollo Ágil</h5>
            <p class="mb-0 small">Scrum no es un proceso pesado; es un marco liviano que ayuda a personas, equipos y organizaciones a generar valor a través de soluciones adaptativas para problemas complejos mediante inspección y adaptación constante.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/X7gh07V6aKo" title="El Framework Scrum: Sprints, Ceremonias y Artefactos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Sprint como Contenedor Temporal (Timebox)</h4>
    <p>En Scrum, todo el trabajo ocurre dentro de un <strong>Sprint</strong>: una caja de tiempo de duración fija (generalmente de <strong>2 semanas</strong>) que se repite de forma ininterrumpida. Un nuevo Sprint comienza inmediatamente después de la conclusión del Sprint anterior.</p>
    <p>Durante el Sprint no se realizan cambios que pongan en peligro el <em>Sprint Goal (Objetivo del Sprint)</em>, asegurando que el equipo pueda concentrarse sin interrupciones externas.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calendar-event text-primary me-2"></i>2. Las 4 Ceremonias Oficiales de Scrum</h4>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Evento / Ceremonia</th>
                    <th>¿Cuándo ocurre y Duración?</th>
                    <th>Propósito Central</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">1. Sprint Planning</td>
                    <td>Al inicio del Sprint (máximo 4 horas para un Sprint de 2 semanas).</td>
                    <td>Responder: ¿Por qué es valioso este Sprint (Sprint Goal)? ¿Qué se puede entregar? y ¿Cómo se realizará el trabajo técnico?</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">2. Daily Scrum (Reunión Diaria)</td>
                    <td>Todos los días a la misma hora (estrictamente <strong>15 minutos</strong> de pie).</td>
                    <td>Inspeccionar el progreso hacia el Sprint Goal y coordinar el plan del día respondiendo los 3 puntos: Qué hice ayer, qué haré hoy y qué impedimentos bloquean mi trabajo.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">3. Sprint Review</td>
                    <td>Al final del Sprint con los clientes e interesados (Stakeholders).</td>
                    <td>Demostrar en vivo el Incremento de producto terminado funcional y recibir retroalimentación para adaptar el Product Backlog.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">4. Sprint Retrospective</td>
                    <td>Al concluir la Review, antes de iniciar el nuevo Sprint.</td>
                    <td><strong>Inspección interna del equipo:</strong> ¿Qué funcionó bien? ¿Qué falló en nuestros procesos o relaciones? y ¿Qué mejora concreta implementaremos en el próximo Sprint?</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-box text-primary me-2"></i>3. Los 3 Artefactos de Scrum y sus Compromisos</h4>
    <ul>
        <li><strong>Product Backlog:</strong> La lista ordenada y viva de todo lo que se necesita en el producto. Su compromiso es el <strong>Product Goal (Objetivo del Producto)</strong>.</li>
        <li><strong>Sprint Backlog:</strong> El conjunto de elementos del Product Backlog seleccionados para el Sprint actual junto con el plan para entregarlos. Su compromiso es el <strong>Sprint Goal</strong>.</li>
        <li><strong>Incremento:</strong> El peldaño concreto hacia el Objetivo del Producto. Debe cumplir estrictamente la <strong>Definición de Terminado (Definition of Done - DoD)</strong>: probado, documentado y listo para ponerse en producción.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Convertir la Daily en una sesión de reporte de estatus al jefe:</strong> La Daily no es para rendir cuentas al Scrum Master o al gerente; es una conversación entre los propios desarrolladores para sincronizar sus tareas y resolver bloqueos mutuos.</li>
        <li><strong>Saltarse la Retrospectiva por ''falta de tiempo'':</strong> Omitir la retrospectiva condena al equipo a repetir los mismos errores y frustraciones técnicas Sprint tras Sprint, bloqueando la mejora continua.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respetas la duración de 15 minutos de la Daily manteniéndola enfocada en bloqueos?</li>
            <li>¿Definiste un Sprint Goal claro que oriente el esfuerzo del equipo durante las dos semanas?</li>
            <li>¿Cumple cada elemento entregado con la Definición de Terminado (Definition of Done)?</li>
        </ul>
    </div>
</div>', 'Domina el ciclo de vida de Scrum: la caja de tiempo del Sprint (1 a 4 semanas), el Product Backlog, Sprint Backlog, la reunión diaria (Daily de 15 minutos), la Review con stakeholders y la Retrospectiva.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (81, 81, 'La Tríada de la Responsabilidad sin Jefes Tradicionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-people-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Scrum no tiene Jefes de Proyecto: Tiene Equipos Autoorganizados</h5>
            <p class="mb-0 small">En Scrum desaparece la figura autoritaria del ''Project Manager'' que microgestiona tareas individuales. La responsabilidad se distribuye en una tríada equilibrada: Negocio (PO), Proceso (SM) y Calidad Técnica (Equipo de Desarrollo).</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/yRmK3iWA_r0" title="Roles en Scrum: Product Owner, Scrum Master y Developers" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Tríada Oficial de Roles en el Scrum Team</h4>
    <p>Un <strong>Scrum Team</strong> está conformado por un máximo recomendado de 10 personas para mantener la comunicación fluida, y consta de tres responsabilidades específicas:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">Product Owner (PO)</span>
                <h6 class="fw-bold text-dark mb-1">La Voz del Negocio y del Cliente</h6>
                <p class="small text-muted mb-0">Responsable de <strong>maximizar el valor del producto</strong> resultante del trabajo del equipo. Gestiona, prioriza y ordena el Product Backlog. Decide qué se construye primero según el impacto financiero y comercial.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">Scrum Master (SM)</span>
                <h6 class="fw-bold text-dark mb-1">El Líder Servicial y Facilitador</h6>
                <p class="small text-muted mb-0">Responsable de <strong>establecer Scrum según la Guía oficial</strong>. Ayuda al equipo a enfocarse en la entrega de valor, facilita las ceremonias y actúa como un escudo protector eliminando impedimentos externos que bloqueen al equipo.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-warning text-dark mb-2">Developers (Desarrolladores)</span>
                <h6 class="fw-bold text-dark mb-1">Los Creadores del Incremento</h6>
                <p class="small text-muted mb-0">Los profesionales técnicos (programadores, diseñadores UX, evaluadores QA, analistas) que ejecutan el trabajo. Son <strong>autoorganizados y multifuncionales</strong>: nadie les dice técnicamente cómo construir las soluciones.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-primary me-2"></i>2. La Remoción de Impedimentos por el Scrum Master</h4>
    <p>Si durante la reunión diaria un desarrollador reporta: <em>''No puedo probar el módulo porque el departamento de redes no me ha dado acceso al servidor de pruebas y llevo dos días esperando''</em>:</p>
    <ul>
        <li>El desarrollador no debe perder su tiempo lidiando con la burocracia de la empresa.</li>
        <li>El <strong>Scrum Master</strong> asume de inmediato la gestión del impedimento: se reúne con el gerente de redes, gestiona los permisos y desbloquea el camino para que el equipo pueda continuar trabajando sin demoras.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El Product Owner que actúa como Scrum Master a la vez:</strong> Ambos roles tienen un conflicto de interés intrínseco. El PO empuja por maximizar el alcance y la velocidad para el negocio; el SM cuida el ritmo sostenible de trabajo y la salud mental del equipo. Fusionar ambos roles provoca sobreexplotación y código de mala calidad.</li>
        <li><strong>Un Product Owner sin autoridad real para tomar decisiones:</strong> Si para cada cambio de prioridad el PO debe pedir permiso a un comité superior de 5 directores, el equipo se paralizará y se perderá toda la velocidad ágil.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Tiene el Product Owner autonomía total para ordenar el Backlog según el valor de negocio?</li>
            <li>¿Actúa el Scrum Master como líder servicial removiendo impedimentos burocráticos?</li>
            <li>¿Es el equipo de desarrollo multifuncional capaz de llevar una tarea desde el diseño hasta producción?</li>
        </ul>
    </div>
</div>', 'Comprende la estructura de roles en Scrum: el Product Owner (maximiza el valor del negocio), el Scrum Master (líder servicial que remueve impedimentos) y los Developers multidisciplinarios y autoorganizados.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (116, 116, 'Cómo Google, Intel y las Empresas Líderes Alinean sus Metas Ambiciosas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-bullseye fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">OKRs: La Metodología que Hizo Escalar a Google de 40 a 100.000 Empleados</h5>
            <p class="mb-0 small">Los objetivos tradicionales de año nuevo quedan en el olvido en febrero. El framework OKR (Objectives and Key Results) conecta la visión a largo plazo con resultados medibles trimestrales que alinean a toda la empresa hacia el mismo norte.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/kNOfOmjgOik" title="Qué son los OKRs y cómo usarlos en tu negocio" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Fórmula Sagrada de un OKR: John Doerr</h4>
    <p>Creado por Andy Grove en Intel y popularizado por John Doerr en Google, un <strong>OKR</strong> se redacta siguiendo una fórmula estricta:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <span class="fs-6 fw-bold text-primary">"Nosotros lograremos [OBJETIVO CUALITATIVO], medido por [RESULTADOS CLAVE CUANTITATIVOS]."</span>
    </div>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2">El Objetivo (Objective - O)</h5>
                <p class="small text-muted mb-0"><strong>¿Hacia dónde queremos ir?</strong> Debe ser cualitativo, inspirador, ambicioso y fácil de memorizar por cualquier empleado. No contiene números ni porcentajes (ej: <em>''Convertirnos en la plataforma de compras online preferida por su velocidad de entrega en Caracas''</em>).</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-success mb-2">Los Resultados Clave (Key Results - KRs)</h5>
                <p class="small text-muted mb-0"><strong>¿Cómo sabemos si estamos llegando?</strong> Son estrictamente cuantitativos, numéricos y con fecha límite. Cada Objetivo debe tener entre <strong>3 y 5 Resultados Clave</strong> medibles.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-card-checklist text-primary me-2"></i>2. Ejemplo Real de un OKR Corporativo Trimestral</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        <strong>Objetivo (O):</strong> Lograr un nivel de excelencia y velocidad en atención postventa que enamore a los clientes.<br /><br />
        <strong>Resultados Clave (KRs):</strong><br />
        - <strong>KR 1:</strong> Reducir el tiempo promedio de respuesta inicial en WhatsApp de 45 minutos a <strong>menos de 3 minutos</strong>.<br />
        - <strong>KR 2:</strong> Aumentar el índice de satisfacción del cliente (CSAT) del 74% a más del <strong>92%</strong>.<br />
        - <strong>KR 3:</strong> Publicar un centro de ayuda en video resolviendo el 100% de las 10 preguntas más frecuentes de garantías.<br />
        - <strong>KR 4:</strong> Disminuir la tasa de reclamos por despacho tardío del 5% a <strong>menos del 1%</strong>.
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-down-up text-primary me-2"></i>3. Alineación Bidireccional: 50% Top-Down y 50% Bottom-Up</h4>
    <p>A diferencia de los viejos sistemas autoritarios donde la dirección imponía todas las metas desde arriba, en OKR:</p>
    <ul>
        <li>La Gerencia define los 2 o 3 <strong>OKRs de la Compañía</strong> para el año.</li>
        <li>Los equipos y departamentos proponen sus propios <strong>OKRs de Equipo</strong> trimestrales, decidiendo autónomamente cómo ellos van a contribuir a empujar los resultados clave de la empresa.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Resultados Clave con Tareas o Pendientes (To-Do Lists):</strong> Un KR no es una actividad (ej: ''asistir a una reunión'' no es un KR); un KR es un <em>impacto medible</em> (ej: ''aumentar las ventas en $20.000 USD'' sí es un KR).</li>
        <li><strong>Vincular directamente los OKRs al bono salarial:</strong> Si el bono salarial del empleado depende al 100% de cumplir el OKR, el empleado elegirá metas fáciles y mediocres para no arriesgar su dinero. Los OKRs deben ser ambiciosos (Moonshots) donde alcanzar un 70% u 80% ya representa un éxito extraordinario.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Es tu Objetivo cualitativo, inspirador y retador para todo el equipo?</li>
            <li>¿Contiene cada Resultado Clave (KR) un número medible de partida y de meta final?</li>
            <li>¿Limitas los OKRs a máximo 3 objetivos por trimestre para asegurar enfoque y foco?</li>
        </ul>
    </div>
</div>', 'Domina el sistema de metas OKR de Andy Grove y John Doerr: diferencia entre Objetivos cualitativos inspiradores y Resultados Clave (KR) cuantitativos, cadencia trimestral y alineación vertical.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (13, 13, 'El Modelo Hersey-Blanchard: Dirigir, Guiar, Apoyar y Delegar', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-compass-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Liderazgo No es un Rango de Poder; es un Acto de Servicio y Facilitación</h5>
            <p class="mb-0 small">Los jefes tradicionales mandan e infunden temor; los líderes modernos inspiran, desarrollan talento y eliminan obstáculos para que sus equipos alcancen resultados extraordinarios.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/XVNpyCENMyY" title="Modelo de Liderazgo Situacional  Modelo de Hersey Blanchard C.O. Orientación a la tarea la Relación👍" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-diagram-3 text-primary me-2"></i>1. El Modelo de Liderazgo Situacional (Hersey-Blanchard)</h4>
    <p>El error más habitual de los líderes inexpertos es tratar a todos los colaboradores exactamente de la misma manera. El modelo situacional postula que el estilo directivo debe adaptarse a la ''Madurez Operativa'' (combinación de competencia técnica y motivación intrínseca):</p>
    <ul>
        <li><strong>E1 - Dirigir (M1: Baja Competencia / Alta Motivación):</strong> Típico del nuevo empleado entusiasta pero sin experiencia técnica. Requiere instrucciones paso a paso detalladas, supervisión cercana y retroalimentación frecuente.</li>
        <li><strong>E2 - Guiar / Entrenar (M2: Cierta Competencia / Baja Motivación):</strong> El colaborador se da cuenta de que la labor es más difícil de lo esperado y se desanima. El líder debe explicar los ''porqués'', escuchar sus dudas y reanimar su confianza sin descuidar el control técnico.</li>
        <li><strong>E3 - Apoyar / Facilitar (M3: Alta Competencia / Motivación Variable):</strong> El profesional domina técnicamente el trabajo pero duda de su criterio o sufre de síndrome del impostor. El líder debe actuar como facilitador, escuchando sus propuestas y empoderándolo a tomar decisiones.</li>
        <li><strong>E4 - Delegar (M4: Alta Competencia / Alta Motivación):</strong> El colaborador estrella senior. Requiere máxima autonomía, fijación de metas estratégicas y mínima intervención operativa en el ''cómo''.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-heart-pulse text-primary me-2"></i>2. La Seguridad Psicológica como Cimiento del Alto Desempeño</h4>
    <p>El Proyecto Aristóteles de Google analizó cientos de equipos durante años para descubrir qué los hacía excepcionales. La conclusión indiscutible fue la <strong>Seguridad Psicológica</strong> (Psychological Safety):</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small">La creencia compartida por todos los miembros del equipo de que nadie será humillado, ridiculizado o castigado por admitir un error, hacer preguntas sinceras o proponer ideas arriesgadas pero innovadoras.</p>
    </div>
    <p>Cuando el líder castiga públicamente los errores honestos, la gente oculta las fallas, se paraliza la innovación y la empresa entra en decadencia silenciosa.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El Micromanagement asfixiante:</strong> Querer revisar cada punto y coma del trabajo de profesionales senior (M4), destruyendo su motivación y creando cuellos de botella permanentes.</li>
        <li><strong>El ''Abandono por Delegación'':</strong> Tirarle una tarea compleja a un novato (M1) sin acompañamiento ni capacitación y luego enojarse cuando comete un error elemental.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Diagnosticas el nivel de madurez técnica de cada miembro antes de asignarle tareas?</li>
            <li>¿Fomentas la seguridad psicológica admitiendo tus propios errores abiertamente ante tu equipo?</li>
            <li>¿Evitas el micromanagement con colaboradores que han demostrado competencia y confiabilidad?</li>
        </ul>
    </div>
</div>', 'Descubre por qué no existe un único estilo de liderazgo perfecto y aprende a calibrar tu nivel de dirección y apoyo según la competencia y motivación del colaborador.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (154, 154, 'Manejo del ''Policía Bueno / Policía Malo'', Ultimátums y Técnicas de Cierre', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-file-earmark-check-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">El Mejor Cierre de Negociación es Aquel Donde Ambas Partes Duermen Tranquilas</h5>
            <p class="mb-0 small">Un acuerdo firmado bajo coacción, engaño o trampas psicológicas terminará en litigios legales o incumplimientos culposos. Conoce cómo desmontar tácticas agresivas y cerrar acuerdos sólidos y duraderos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/o5tedjYHam8" title="Táctica sucia llamada concesiones infladas #negociar #negociación" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-shield-x text-primary me-2"></i>1. Neutralización de Tácticas Psicológicas Sucias</h4>
    <p>En el mundo empresarial te toparás con contrapartes que utilizan estrategias de manipulación deliberadas. La mejor forma de neutralizarlas es hacerlas explícitas con educación y serenidad:</p>
    <ul>
        <li><strong>El ''Policía Bueno / Policía Malo'':</strong> Un negociador se muestra agresivo, exigente e intransigente, y luego sale de la sala, mientras su compañero se muestra amable y comprensivo diciendo: <em>''Mi jefe es durísimo, fírmame esto rápido antes de que vuelva''</em>. <strong>Cómo neutralizarlo:</strong> Dirígete al policía bueno y dile con una sonrisa: <em>''Agradezco tu amabilidad, pero reconozco la dinámica. Nosotros negociamos con el fondo del acuerdo y no con presiones emocionales; hablemos de los términos objetivos''</em>.</li>
        <li><strong>El ''Mordisqueo de Última Hora'' (Nibbling):</strong> Cuando todo está acordado y los bolígrafos están sobre la mesa, la contraparte lanza: <em>''Ah, por cierto, supongo que el transporte y la instalación están incluidos sin costo adicional, ¿verdad?''</em>. <strong>Cómo neutralizarlo:</strong> No cedas por el apuro de cerrar; responde de inmediato: <em>''Con mucho gusto incluimos transporte e instalación; eso tiene un costo de $150 o podemos mantener el despacho en bodega como acordamos. ¿Cuál de las dos opciones prefieren?''</em>.</li>
        <li><strong>Falsos Ultimátums (''Lo toma o lo deja''):</strong> Responder con calma: <em>''Entiendo que esa es su posición actual. Si esas son las únicas condiciones posibles, lamentablemente no tenemos un acuerdo. Sigamos en contacto para futuros proyectos''</em>. Con frecuencia, el ultimátum es un farol que se desvanece al demostrar que no temes levantarte.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-pen text-primary me-2"></i>2. La Redacción y Blindaje del Memorándum de Entendimiento (MoU)</h4>
    <p>Las palabras se las lleva el viento; el cierre formal requiere un documento escrito que sintetice con precisión milimétrica los compromisos mutuos:</p>
    <ol>
        <li><strong>Resumen Escrito Inmediato:</strong> Al terminar la reunión, enviar un correo formal: <em>''Para consolidar lo conversado hoy y asegurar que todos estemos alineados, adjunto el resumen de los puntos acordados...''</em>.</li>
        <li><strong>Cláusulas de Escalabilidad y Fuerza Mayor:</strong> Prever contingencias como fluctuaciones cambiarias severas, escasez de materias primas o fallas energéticas con fórmulas de ajuste automáticas.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar cabos sueltos ''de palabra'':</strong> Acordar temas críticos de manera verbal por amistad o pena de parecer desconfiado. Si no está en el contrato, no existe.</li>
        <li><strong>Celebrar la victoria humillando a la otra parte:</strong> Salir de la reunión diciendo abiertamente que ''les sacaste hasta el último centavo'' genera rencor y sabotajes operativos durante la ejecución del contrato.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Neutralizas tácticas sucias señalando la técnica con serenidad y sin perder los estribos?</li>
            <li>¿Cobras las solicitudes adicionales de última hora impidiendo el efecto mordisqueo?</li>
            <li>¿Envías una minuta escrita de compromisos inmediatamente al finalizar la sesión?</li>
        </ul>
    </div>
</div>', 'Aprende a desarticular tácticas sucias de negociación, gestionar la técnica del mordisqueo (Nibbling) y redactar acuerdos claros a prueba de litigios.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (145, 145, 'Guía de Rutinas: Formación, Reglas de la 3ª Persona y Preguntas con Do/Does', 'Reading', '<h4>1. Usos del Present Simple</h4>
<p>El <strong>Present Simple</strong> se utiliza para describir hábitos, rutinas diarias, horarios establecidos y hechos que son verdades permanentes:</p>
<ul>
    <li><em>The Earth revolves around the Sun.</em> (Verdad científica permanente).</li>
    <li><em>I drink coffee every morning at 7:00 AM.</em> (Hábito o rutina).</li>
</ul>

<h4>2. Reglas Ortográficas de la 3ª Persona Singular (He, She, It)</h4>
<p>En oraciones afirmativas, los verbos añaden una terminación al conjugarse con <em>He, She o It</em>:</p>
<ul>
    <li><strong>Regla General:</strong> Añadir <code>-s</code> &rarr; <em>work &rarr; works</em>, <em>speak &rarr; speaks</em>, <em>live &rarr; lives</em>.</li>
    <li><strong>Verbos terminados en -o, -sh, -ch, -ss, -x:</strong> Añadir <code>-es</code> &rarr; <em>go &rarr; goes</em>, <em>watch &rarr; watches</em>, <em>wash &rarr; washes</em>, <em>kiss &rarr; kisses</em>, <em>fix &rarr; fixes</em>.</li>
    <li><strong>Consonante + -y:</strong> Cambia la ''y'' por <code>-ies</code> &rarr; <em>study &rarr; studies</em>, <em>fly &rarr; flies</em>. (Pero si precede vocal: <em>play &rarr; plays</em>).</li>
</ul>

<h4>3. Negación e Interrogación con Do y Does</h4>
<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Tipo</th><th>Estructura</th><th>Ejemplo</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>Afirmativa</strong></td><td>Sujeto + Verbo (+s/es)</td><td><em>She works in an office.</em></td></tr>
            <tr><td><strong>Negativa</strong></td><td>Sujeto + <strong>don''t / doesn''t</strong> + Verbo base</td><td><em>She <strong>doesn''t work</strong> on Saturdays.</em></td></tr>
            <tr><td><strong>Pregunta</strong></td><td><strong>Do / Does</strong> + Sujeto + Verbo base?</td><td><em><strong>Does</strong> she work here? &mdash; Yes, she does.</em></td></tr>
        </tbody>
    </table>
</div>

<h4>4. Adverbios de Frecuencia (Adverbs of Frequency)</h4>
<p>Indican con qué regularidad se produce una acción: <em>Always (100%), Usually (80%), Often (60%), Sometimes (40%), Rarely/Seldom (10%), Never (0%)</em>.</p>
<div class="alert alert-info border-0 p-3 rounded-3">
    <strong>Posición del Adverbio:</strong> Se ubica <strong>ANTES del verbo principal</strong> (<em>I <strong>always drink</strong> tea</em>), pero <strong>DESPUÉS del verbo To Be</strong> (<em>He is <strong>always</strong> punctual</em>).
</div>', 'Aprende a formular oraciones afirmativas, negativas e interrogativas en Present Simple, las reglas ortográficas de -s/-es y la ubicación de adverbios de frecuencia.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (231, 231, 'Panel de Control, Dominios, Moneda e Información Legal de la Empresa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shop fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Shopify: La Plataforma que Democratizó el Comercio Electrónico Global</h5>
            <p class="mb-0 small">Vender por internet ya no requiere contratar un equipo de ingenieros para programar servidores durante seis meses. Con Shopify, cualquier negocio puede tener una tienda online de clase mundial funcionando en menos de una semana.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/9m-2pxDlkqU" title="Tutorial de Shopify para Principiantes - Crea Tu Primera Tienda Online" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Arquitectura Cloud de Shopify (SaaS)</h4>
    <p>A diferencia de soluciones autoalojadas como WooCommerce o Magento donde la empresa debe pagar por hosting, actualizar servidores y parchar vulnerabilidades de seguridad manualmente, <strong>Shopify</strong> opera como un servicio SaaS totalmente administrado:</p>
    <ul>
        <li><strong>Infraestructura Elástica:</strong> Soporta millones de visitas simultáneas durante eventos masivos de compras (como Black Friday) sin que la página web caiga.</li>
        <li><strong>Certificado SSL Gratuito y Cumplimiento PCI-DSS Nivel 1:</strong> La máxima certificación bancaria para el procesamiento seguro de tarjetas de crédito sin riesgo legal para el comerciante.</li>
        <li><strong>Ecosistema de Aplicaciones:</strong> Acceso a miles de extensiones en la Shopify App Store para conectar WhatsApp, programas de fidelización y logística local de despachos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-gear-fill text-primary me-2"></i>2. Configuración Esencial de la Tienda</h4>
    <p>Antes de diseñar banners o subir productos, se deben configurar los cimientos operativos en el menú <em>Configuración</em> de la esquina inferior izquierda:</p>
    <ol>
        <li><strong>Detalles de la Tienda:</strong> Nombre legal de la empresa, RIF / Cédula jurídica, dirección física y moneda de la tienda (ej: USD o moneda local). <em>(Nota crítica: Cambiar la moneda principal tras recibir la primera venta requiere soporte técnico de Shopify, elígela con cuidado).</em></li>
        <li><strong>Dominio Personalizado:</strong> Conectar un dominio propio profesional (ej: <code>mitienda.com</code>) en lugar de utilizar el subdominio genérico <code>mitienda.myshopify.com</code> que resta confianza institucional a los compradores.</li>
        <li><strong>Páginas de Políticas Legales Obligatorias:</strong>
            <ul>
                <li>Política de Reembolso y Devolución (plazos, quién paga el flete de retorno, condiciones del producto).</li>
                <li>Política de Privacidad y Tratamiento de Datos Personales.</li>
                <li>Términos y Condiciones del Servicio.</li>
                <li>Información de Envíos y Tiempos Estimados de Entrega.</li>
            </ul>
        </li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-palette text-primary me-2"></i>3. Selección y Personalización del Tema (Editor de Temas)</h4>
    <p>Shopify ofrece temas gratuitos de alto rendimiento optimizados para celulares (como <strong>Dawn</strong> o <strong>Sense</strong>):</p>
    <ul>
        <li>El 80% de las ventas por internet en América Latina se realizan desde teléfonos móviles; diseña siempre pensando primero en la experiencia móvil (Mobile First).</li>
        <li>Configura una paleta de colores limpia (máximo 3 colores), tipografías legibles y un encabezado fijo con barra de búsqueda rápida y carrito de compras visible.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Lanzar la tienda sin retirar la contraseña de acceso:</strong> Durante la etapa de construcción, la tienda está protegida por una contraseña de desarrollo. Antes del lanzamiento público, debes entrar en <em>Tienda online ➔ Preferencias</em> y desmarcar la casilla ''Habilitar contraseña''.</li>
        <li><strong>Ignorar las páginas de contacto e información legal:</strong> Las pasarelas de pago (Stripe, PayPal, bancos locales) rechazan tiendas que no muestran claramente un teléfono, correo corporativo y dirección física de atención al cliente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Vinculaste un dominio propio .com con certificado SSL activo?</li>
            <li>¿Publicaste las cuatro políticas legales obligatorias en el pie de página de la tienda?</li>
            <li>¿Comprobaste la velocidad y legibilidad del diseño en dispositivos móviles?</li>
        </ul>
    </div>
</div>', 'Conoce el backend de Shopify: configuración regional (monedas, huso horario), vinculación de dominio propio .com, políticas legales obligatorias (términos, reembolsos, privacidad) y personalización del tema visual.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (11, 11, 'Configuración Profesional, Catálogo de Productos, Respuestas Rápidas y Etiquetas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-whatsapp fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">WhatsApp: El Canal con Mayor Tasa de Apertura del Mundo</h5>
            <p class="mb-0 small">Mientras que los correos electrónicos tienen una tasa de apertura de apenas el 18% al 22%, los mensajes de WhatsApp alcanzan un asombroso 98% de lectura en los primeros 15 minutos. Usar una cuenta personal en lugar de una cuenta Business le cuesta miles de dólares en ventas perdidas a cualquier empresa.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/ZyIFFFc6odc" title="WhatsApp Business - Potencia Tu Negocio con Brevo" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. WhatsApp Estándar vs WhatsApp Business</h4>
    <p>Utilizar una cuenta personal para atender clientes transmite informalidad y dificulta la gestión de prospectos. <strong>WhatsApp Business</strong> es una aplicación gratuita diseñada para empresas que incorpora herramientas comerciales ausentes en la versión estándar:</p>
    <ul>
        <li><strong>Perfil de Empresa Institucional:</strong> Muestra el logotipo de la marca, horarios de atención presencial, dirección física con enlace directo a Google Maps, correo electrónico corporativo y catálogo de productos.</li>
        <li><strong>Mensaje de Bienvenida Automático:</strong> Saluda al cliente en el milisegundo en que escribe por primera vez, transmitiendo atención inmediata 24/7.</li>
        <li><strong>Mensaje de Ausencia Programable:</strong> Informa cortésmente si el cliente escribe fuera del horario de oficina, indicándole a qué hora se le responderá y ofreciéndole consultar el catálogo mientras tanto.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>2. Respuestas Rápidas (Atajos de Teclado con ''/'')</h4>
    <p>Uno de los mayores sumideros de tiempo para los asesores comerciales es escribir 50 veces al día la misma información bancaria, los precios de envío o la dirección de la tienda. En WhatsApp Business se programan <strong>Respuestas Rápidas</strong> activadas con una barra inclinada (<code>/</code>):</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <div class="row g-2 font-monospace small">
            <div class="col-md-4"><code>/bancos</code> ➔ Datos de cuenta bancaria y Pago Móvil.</div>
            <div class="col-md-4"><code>/envios</code> ➔ Tarifas de encomiendas y tiempos de entrega.</div>
            <div class="col-md-4"><code>/horario</code> ➔ Horario de apertura de las sucursales.</div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tags-fill text-success me-2"></i>3. El Embudo de Etiquetas de Color (Funnel de Clientes)</h4>
    <p>WhatsApp Business permite clasificar las conversaciones hasta con 20 <strong>Etiquetas de Colores</strong> personalizadas, funcionando como un CRM visual en la palma de la mano:</p>
    <ol>
        <li><span class="badge bg-primary">Azul</span> <strong>Nuevo Prospecto:</strong> Cliente que preguntó por primera vez y aún no ha cotizado.</li>
        <li><span class="badge bg-warning text-dark">Amarillo</span> <strong>Cotización Enviada:</strong> Ya se le enviaron precios; requiere seguimiento a las 24 horas.</li>
        <li><span class="badge bg-danger">Rojo</span> <strong>Pago Pendiente:</strong> Confirmó que va a comprar pero aún no ha transferido.</li>
        <li><span class="badge bg-success">Verde</span> <strong>Pagado / Por Despachar:</strong> Pago verificado en banco listo para empaque.</li>
        <li><span class="badge bg-secondary">Gris</span> <strong>Cliente Cerrado / Fidelizado:</strong> Venta completada para futuras ofertas.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Enviar mensajes masivos no solicitados a personas que no tienen tu número guardado:</strong> WhatsApp tiene políticas estrictas contra el SPAM. Si envías el mismo mensaje comercial a 100 personas desconocidas y varios marcan tu chat como ''Bloquear y Reportar'', WhatsApp suspenderá tu número de teléfono de forma permanente en menos de 2 horas.</li>
        <li><strong>Tardar más de 15 minutos en responder en horario de oficina:</strong> En ventas digitales, la velocidad de respuesta es el factor número uno de cierre. Si tardas 2 horas en contestar ''¿cuánto cuesta?'', el cliente ya le habrá comprado a tu competidor por internet.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Configuraste tu perfil de empresa con dirección física, horarios y logo en alta resolución?</li>
            <li>¿Programaste respuestas rápidas (/) para tus datos de pago, envíos y preguntas frecuentes?</li>
            <li>¿Clasificas cada chat entrante con etiquetas de color según su etapa de compra?</li>
        </ul>
    </div>
</div>', 'Configura WhatsApp Business como una herramienta comercial de élite: perfil verificado de empresa, catálogo interactivo con enlaces directos, automatización de mensajes y organización con etiquetas de color.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (12, 12, 'Auditoría Interna y del Macroentorno para Identificar Oportunidades Reales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-compass-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La Estrategia es el Arte de Elegir qué NO Hacer</h5>
            <p class="mb-0 small">Toda empresa dispone de recursos limitados (tiempo, talento y capital financiero). La planificación estratégica analiza con frialdad el entorno para apostar los recursos en las batallas comerciales donde la organización tiene ventajas competitivas reales.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/PHWo40WdzZo" title="¿Qué es el Análisis FODA y cómo realizarlo? Economía de la Empresa" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Matriz F.O.D.A. (SWOT) Cruzada</h4>
    <p>El error más habitual es llenar una cuadrícula de FODA con cuatro listas de palabras y archivarla en una gaveta. Una <strong>Matriz FODA Cruzada</strong> conecta los factores internos con los factores externos para generar planes de acción estratégicos concretos:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Estrategia Cruzada</th>
                    <th>Cruce de Factores</th>
                    <th>Objetivo Estratégico</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-success">Estrategias FO (Ofensivas)</td>
                    <td>Fortalezas Internas + Oportunidades Externas</td>
                    <td><strong>Atacar y Crecer:</strong> Utilizar las ventajas competitivas de la empresa para conquistar nuevos mercados o lanzar productos aprovechando la coyuntura favorable.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">Estrategias DO (Reorientación)</td>
                    <td>Debilidades Internas + Oportunidades Externas</td>
                    <td><strong>Superar Limitaciones:</strong> Aprovechar una oportunidad de mercado para corregir una debilidad interna (ej: asociarse con un socio logístico para suplir la falta de flota propia).</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Estrategias FA (Defensivas)</td>
                    <td>Fortalezas Internas + Amenazas Externas</td>
                    <td><strong>Blindarse:</strong> Utilizar la solidez de la marca o la liquidez financiera para resistir la llegada de un competidor extranjero agresivo.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Estrategias DA (Supervivencia)</td>
                    <td>Debilidades Internas + Amenazas Externas</td>
                    <td><strong>Minimizar Daños:</strong> Reducir costos, fusionar áreas o abandonar líneas de producto no rentables para evitar la quiebra en un entorno de crisis.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-globe-americas text-primary me-2"></i>2. El Marco PESTEL para Analizar el Macroentorno</h4>
    <p>Una empresa no opera en el vacío. El análisis <strong>P.E.S.T.E.L.</strong> evalúa las 6 fuerzas externas que la organización no puede controlar pero a las que debe adaptarse obligatoriamente:</p>
    <ul>
        <li><strong>Político:</strong> Estabilidad gubernamental, políticas arancelarias y acuerdos comerciales internacionales.</li>
        <li><strong>Económico:</strong> Tasas de inflación, paridad cambiaria de divisas, tasas de interés bancarias y poder adquisitivo real del consumidor.</li>
        <li><strong>Social:</strong> Cambios demográficos, hábitos de consumo saludable y preferencias culturales de las nuevas generaciones.</li>
        <li><strong>Tecnológico:</strong> Avances en inteligencia artificial, penetración del comercio electrónico y automatización de procesos.</li>
        <li><strong>Ecológico / Ambiental:</strong> Regulaciones de huella de carbono, cambio climático y reciclaje de empaques.</li>
        <li><strong>Legal:</strong> Normativas laborales, leyes de protección al consumidor y reformas tributarias.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Factores Internos con Externos:</strong> Las Fortalezas y Debilidades son 100% <em>internas</em> (la empresa puede cambiarlas: equipo humano, calidad del producto, tecnología). Las Oportunidades y Amenazas son 100% <em>externas</em> (el mercado las impone: inflación, leyes, competencia).</li>
        <li><strong>Redactar un FODA basado en ilusiones en lugar de datos auditados:</strong> Poner como fortaleza ''tenemos excelente servicio al cliente'' cuando las encuestas reales de satisfacción muestran un 30% de quejas es un autoengaño que destruye la validez del plan.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Construiste la matriz cruzada (FO, DO, FA, DA) con acciones concretas?</li>
            <li>¿Auditaste las 6 dimensiones del análisis PESTEL para anticipar riesgos externos?</li>
            <li>¿Respaldaste cada fortaleza y debilidad con métricas cuantitativas auditadas?</li>
        </ul>
    </div>
</div>', 'Domina el diagnóstico de negocio: matriz FODA cruzada (estrategias FO, FA, DO, DA) y análisis del macroentorno PESTEL (Político, Económico, Social, Tecnológico, Ecológico y Legal).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (18, 18, 'De la Multicanalidad Aislada a la Experiencia Unificada sin Fricciones', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shuffle fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Cliente No Ve Canales, Ve una Sola Marca</h5>
            <p class="mb-0 small">El 78% de los usuarios modernos utiliza más de dos canales para completar una consulta o reclamo. Conoce cómo conectar sistemas CRM y protocolos para brindar una experiencia continua y homogénea.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/GA2_t6KJCZw" title="¿Qué es OMNICANALIDAD? 🤔 Implementa una ESTRATEGIA OMNICANAL exitosa" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-diagram-3-fill text-primary me-2"></i>1. Multicanalidad vs Omnicanalidad: La Gran Diferencia</h4>
    <p>Muchas empresas se jactan de ser modernas porque tienen WhatsApp, redes sociales y correo, pero operan en silos aislados:</p>
    <ul>
        <li><strong>Multicanalidad (Enfoque Tradicional en Silos):</strong> La empresa dispone de varios canales (teléfono, correo, tienda física), pero no están integrados tecnológicamente entre sí. Si un cliente escribe por Instagram, lo mandan a llamar por teléfono, y al llamar, el agente le pide que vuelva a explicar todo desde cero. Esto genera una frustración enorme en el consumidor.</li>
        <li><strong>Omnicanalidad (Enfoque Integrado Moderno):</strong> Todos los canales convergen en una plataforma centralizada (como Zendesk, Freshdesk o Zoho CRM). Si el cliente inició una consulta por WhatsApp a las 9:00 am y a las 2:00 pm llama por teléfono, el agente ve de inmediato en pantalla todo el historial de mensajes previos y puede continuar la conversación sin pedir repeticiones.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-journal-check text-primary me-2"></i>2. Homogeneidad del Tono de Voz de Marca (Tone of Voice)</h4>
    <p>Para construir una imagen corporativa sólida, las pautas de comunicación deben ser consistentes independientemente del canal utilizado:</p>
    <ol>
        <li><strong>Cortesía y Claridad:</strong> Respuestas siempre respetuosas, sin jergas técnicas incomprensibles ni modismos locales confusos.</li>
        <li><strong>Velocidad y Precisión:</strong> Mientras que en el canal telefónico o chat web la expectativa de respuesta es inmediata (menos de 60 segundos), en canales de correo electrónico la respuesta formal no debe exceder las 4 a 8 horas hábiles.</li>
        <li><strong>Manual de Respuestas Tipo (Templates Humanizados):</strong> Utilizar plantillas de respuesta predefinidas para agilizar el trabajo, pero editándolas siempre para incluir el nombre del cliente y detalles específicos de su caso, evitando sonar como un contestador automático frío.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Derivar al cliente de un canal a otro sin resolver:</strong> Decirle por chat <em>''Para eso tiene que llamar al 0800''</em> y cuando llama, decirle <em>''Para eso tiene que enviar un correo''</em>. Esta práctica destruye la reputación corporativa en redes sociales.</li>
        <li><strong>Bots automatizados mal configurados en WhatsApp:</strong> Menús infinitos de 15 opciones numéricas donde nunca se le da la oportunidad al cliente de hablar con un ser humano real para resolver un caso complejo.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Revisas el historial de tickets del cliente antes de responder una llamada o mensaje nuevo?</li>
            <li>¿Mantienes el mismo estándar de calidez y profesionalismo en correo, chat y teléfono?</li>
            <li>¿Personalizas las plantillas predefinidas agregando el nombre y contexto del cliente?</li>
        </ul>
    </div>
</div>', 'Descubre cómo integrar canales físicos, telefónicos, WhatsApp, chat web y correo para que el cliente no tenga que repetir su historia en cada interacción.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (17, 17, 'La Distinción Crítica entre Urgencia e Importancia en el Trabajo Diario', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-grid-1x2-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Lo Urgente Raras Veces es Importante; lo Importante Raras Veces es Urgente</h5>
            <p class="mb-0 small">El presidente Dwight D. Eisenhower estructuró uno de los modelos de toma de decisiones más eficaces de la historia. Aprende a distinguir lo que exige atención inmediata de lo que genera impacto estratégico real.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/LHtUrHUPs4E" title="LA MATRIZ DE EISENHOWER. PRODUCTIVIDAD Y GESTIÓN DE TIEMPO - RESUMEN ANIMADO" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-diagram-3-fill text-primary me-2"></i>1. Los 4 Cuadrantes de la Matriz de Eisenhower</h4>
    <p>La mayoría de los profesionales pasan el día agotados porque reaccionan a las demandas ajenas en lugar de gobernar su tiempo con base en prioridades reales:</p>
    <ul>
        <li><strong>Cuadrante 1: Urgente e Importante (El Cuadrante del Estrés y las Crisis):</strong> Vencimientos inaplazables de impuestos, caídas de servidores centrales, accidentes laborales o quejas de clientes VIP a punto de rescindir contratos. <strong>Acción: HACER DE INMEDIATO</strong>. Debe mantenerse bajo control para no vivir en burnout constante.</li>
        <li><strong>Cuadrante 2: No Urgente pero Importante (El Cuadrante de la Grandeza y el Liderazgo):</strong> Planificación estratégica, capacitación continua, prevención de fallas mecánicas, creación de relaciones profesionales y diseño de procesos automatizados. Como no tiene una alarma que suene hoy, la gente suele posponerlo semanas o meses. <strong>Acción: PLANIFICAR Y AGENDAR BLOQUES INNEGOCIABLES</strong>. Aquí es donde se construye el éxito profesional a largo plazo.</li>
        <li><strong>Cuadrante 3: Urgente pero No Importante (El Cuadrante del Engaño):</strong> La mayoría de las llamadas telefónicas no programadas, notificaciones de chats grupales de trabajo y solicitudes de favores de última hora de otros departamentos que no aportan a tus metas clave. <strong>Acción: DELEGAR O AUTOMATIZAR</strong>.</li>
        <li><strong>Cuadrante 4: Ni Urgente Ni Importante (El Cuadrante del Desperdicio):</strong> Navegación ociosa en redes sociales durante horas laborales, reuniones interminables sin orden del día o cotilleos de pasillo. <strong>Acción: ELIMINAR SIN CULPA</strong>.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-hourglass-split text-primary me-2"></i>2. Ley de Parkinson y Ley de Carlson</h4>
    <p>Dos principios fundamentales de la psicología del trabajo que debes dominar:</p>
    <ol>
        <li><strong>Ley de Parkinson:</strong> <em>''El trabajo se expande hasta llenar todo el tiempo disponible para su realización''</em>. Si te das 3 semanas para redactar un informe que toma 4 horas, tardarás 3 semanas completas llenas de procrastinación. Ponte plazos artificiales cortos y exigentes (Timeboxing) para forzar el enfoque ejecutivo.</li>
        <li><strong>Ley de Carlson:</strong> <em>''Todo trabajo interrumpido es menos eficaz y toma mucho más tiempo que si se realiza de forma continua''</em>. Cada vez que atiendes una interrupción de 2 minutos, tu cerebro tarda entre 15 y 23 minutos en recuperar la concentración profunda previa.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Vivir atrapado en el Cuadrante 3 confundiéndolo con trabajo productivo:</strong> Responder 80 correos intrascendentes al día y terminar la jornada con la frustrante sensación de que no avanzaste en nada verdaderamente importante.</li>
        <li><strong>No programar tiempo para el Cuadrante 2:</strong> Dejar la planificación estratégica para ''cuando tenga un tiempito libre''. El tiempo libre nunca llegará si no lo bloqueas activamente en tu agenda.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Clasificas tu lista diaria de pendientes según los 4 cuadrantes de Eisenhower?</li>
            <li>¿Dedicas al menos 90 minutos diarios al Cuadrante 2 (planificación y mejora de procesos)?</li>
            <li>¿Fijas plazos de entrega ajustados utilizando la Ley de Parkinson a tu favor?</li>
        </ul>
    </div>
</div>', 'Descubre cómo escapar del cuadrante de las crisis continuas y aprende a priorizar las actividades estratégicas que realmente mueven la aguja del negocio.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (233, 233, 'Configuración de Checkouts, Métodos de Pago Locales y Envíos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-credit-card-2-front-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">El Checkout: Donde el Interés se Convierte en Dinero Real</h5>
            <p class="mb-0 small">Si un cliente llega al final del proceso de compra y no encuentra su medio de pago preferido o descubre costos de envío sorpresa que no esperaba, abandonará la compra de inmediato. Diseñar un checkout fluido es vital para la rentabilidad.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/t7uXibObexI" title="Micro Curso: Pasarelas de Pago - Todo lo que debes saber" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Métodos de Pago: Pasarelas Automáticas vs Pagos Manuales</h4>
    <p>En el comercio electrónico actual de América Latina y mercados mixtos, se debe ofrecer un abanico balanceado de opciones de pago:</p>
    <ul>
        <li><strong>Pasarelas Automáticas (Stripe, Shopify Payments, Mercado Pago, PayPal):</strong> Procesan tarjetas de crédito y débito de forma instantánea. El dinero se acredita en la cuenta del comerciante y el pedido pasa automáticamente a estado <em>''Pagado''</em>, activando el despacho en almacén sin intervención humana. Cobran una comisión por transacción (típicamente entre 2.9% y 4.5% + $0.30 USD).</li>
        <li><strong>Métodos de Pago Manuales (Transferencias Bancarias Locales, Pago Móvil, Zelle):</strong> El cliente finaliza el pedido y la pantalla le muestra los datos bancarios de la empresa con instrucciones para enviar el comprobante de pago por WhatsApp o correo. El pedido queda en estado <em>''Pago Pendiente''</em> hasta que un operador administrativo verifica los fondos en la cuenta bancaria y marca manualmente el pedido como pagado.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-truck text-primary me-2"></i>2. Configuración Estratégica de Zonas y Tarifas de Envío</h4>
    <p>En el menú <em>Configuración ➔ Envío y entrega</em>, se deben estructurar las tarifas para no perder dinero en fletes ni espantar a los clientes:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <h6 class="fw-bold text-dark mb-2">Las 3 Estrategias de Flete Más Exitosas</h6>
        <ol class="small mb-0">
            <li><strong>Envío Gratis Condicional (Free Shipping Threshold):</strong> Establecer envío gratuito para compras superiores a cierto monto (ej: <em>''Envío Gratis en compras mayores a $50 USD''</em>). Esta estrategia eleva el Ticket Promedio de compra porque los clientes agregan un producto adicional para no pagar el envío.</li>
            <li><strong>Tarifa Plana Simple (Flat Rate):</strong> Cobrar una tarifa fija estándar (ej: $4 USD a toda la ciudad), sin importar el peso. Fácil de entender para el comprador.</li>
            <li><strong>Tarifas Calculadas por Transportista:</strong> Conectar servicios de encomiendas (MRW, Zoom, Tealca, DHL, FedEx) para que el sistema calcule el costo exacto según el código postal y peso volumétrico del paquete.</li>
        </ol>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-lock-fill text-primary me-2"></i>3. Optimización del Proceso de Checkout (Cero Fricción)</h4>
    <p>Para reducir el abandono en la pantalla de pago:</p>
    <ul>
        <li>Activar la opción de <strong>Comprar como invitado</strong>: No obligues al cliente a crear una cuenta con contraseña antes de comprar; permite que compre ingresando únicamente su correo o teléfono.</li>
        <li>Reducir campos innecesarios: Desactiva el campo ''Segunda línea de dirección'' o ''Nombre de la empresa'' si vendes a consumidores finales (B2C).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Despachar mercancía con comprobantes de pago manuales falsos:</strong> En pagos manuales (Zelle o Pago Móvil), los ciberdelincuentes editan capturas de pantalla con Photoshop. La regla de oro es: <em>''NUNCA despachar un pedido basándose en una captura de pantalla enviada por el cliente; despachar ÚNICAMENTE cuando el dinero esté efectivamente disponible en el portal bancario oficial de la empresa''</em>.</li>
        <li><strong>Costos ocultos sorpresa en el último paso:</strong> Si el cliente ve un producto por $20 y en el último paso del checkout le agregas $15 de impuestos y envíos imprevistos, el 70% de los usuarios abandonará la cesta enfadado. Sé transparente con las tarifas desde la página de inicio.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Probaste el flujo completo de compra realizando un pedido de prueba en modo test?</li>
            <li>¿Definiste claramente los datos bancarios e instrucciones para pedidos con pago manual?</li>
            <li>¿Configuraste la regla de Envío Gratis sobre un monto mínimo para elevar el ticket promedio?</li>
        </ul>
    </div>
</div>', 'Configura la pasarela de pagos: tarjetas internacionales (Shopify Payments, Stripe, PayPal), pagos móviles/transferencias manuales, configuración de zonas de envío (tarifas planas y envío gratis).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (235, 235, 'Apertura de Caja, Medios de Pago y Procedimiento de Cierre sin Descuadres', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cash-coin fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La Caja es el Punto Neurálgico de la Confianza Comercial</h5>
            <p class="mb-0 small">Un cajero o asistente comercial competente no solo cobra con rapidez; es un auditor en primera línea que custodia los ingresos del negocio, detecta billetes adulterados y entrega cuentas claras al centavo en cada turno.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/pdBbhMfaqf4" title="Cómo hacer un ARQUEO DE CAJA | Asientos contables por Ajuste" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Protocolo de Apertura: El Fondo Fijo de Caja (Caja Chica / Sencillo)</h4>
    <p>Antes de abrir las puertas al público, el asistente de caja debe recibir y verificar el <strong>Fondo Fijo Inicial</strong> destinado exclusivamente a dar cambio a los primeros clientes de la mañana:</p>
    <ul>
        <li>Contar físicamente cada billete y moneda en presencia del supervisor antes de firmar el acta de entrega.</li>
        <li>Verificar la denominación del sencillo: una caja con puros billetes grandes no podrá operar con los primeros clientes que paguen compras pequeñas.</li>
        <li>Organizar la gaveta de caja de menor a mayor denominación y con todos los billetes orientados hacia el mismo lado para acelerar el cobro y evitar confusiones en horas pico.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-credit-card-2-back-fill text-primary me-2"></i>2. Operación de Medios de Pago y Verificación de Seguridad</h4>
    <p>Durante la jornada comercial se manejan múltiples canales de cobro con protocolos específicos:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Medio de Pago</th>
                    <th>Protocolo Operativo Obligatorio</th>
                    <th>Punto Crítico de Control</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold">Puntos de Venta (POS)</td>
                    <td>Digitar el monto en el datáfono, verificar que coincida con la pantalla de la caja y esperar el váucher de <em>''Aprobado''</em>.</td>
                    <td><strong>Guardar el váucher firmado:</strong> Si la máquina no emite váucher o dice ''Rechazada'', la venta no se ha cobrado aunque el cliente afirme que le llegó el mensaje bancario.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Efectivo en Divisas / Moneda Local</td>
                    <td>Verificar medidas de seguridad: marca de agua a contraluz, hilo de seguridad magnético y tinta de color variable al inclinar el billete.</td>
                    <td>Nunca guardar el billete en la gaveta hasta haber entregado el cambio completo al cliente (para evitar disputas sobre si entregó un billete de $20 o de $50).</td>
                </tr>
                <tr>
                    <td class="fw-bold">Pago Móvil / Transferencias</td>
                    <td>Verificar en el portal bancario institucional el número de referencia y la disponibilidad efectiva de los fondos.</td>
                    <td>Desconfiar de capturas de pantalla de teléfonos móviles ajenos; solo vale la confirmación interna en pantalla de caja.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator text-success me-2"></i>3. Procedimiento Oficial de Arqueo y Cierre de Caja (Corte Z / X)</h4>
    <p>Al finalizar el turno se realiza el <strong>Arqueo Ciego de Caja</strong>:</p>
    <ol>
        <li>Cerrar la sesión de cobro y emitir el reporte del datáfono (Lote / Cierre de Terminal POS).</li>
        <li>Separar el monto exacto del Fondo Fijo Inicial para guardarlo en la bolsa del día siguiente.</li>
        <li>Contar el dinero restante en efectivo por denominación y sumar los váuchers físicos de tarjetas de crédito/débito.</li>
        <li>Imprimir el <em>Corte Z</em> del software de facturación y confrontar la fórmula universal: <code>Total Contado Físico - Ventas Registradas en Sistema = Diferencia (Sobrante o Faltante)</code>.</li>
        <li>Firmar el acta junto al supervisor de turno documentando cualquier novedad.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar la gaveta de dinero abierta mientras se atiende a otro cliente:</strong> La gaveta de caja debe cerrarse con traba metálica después de cada transacción para prevenir hurtos por distracción.</li>
        <li><strong>Mezclar dinero personal con el dinero de la caja:</strong> Guardar el teléfono o billetera personal dentro de la gaveta de la empresa está terminantemente prohibido por las normas de auditoría interna de retail.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Contaste físicamente el fondo inicial de caja antes de iniciar el turno de ventas?</li>
            <li>¿Verificaste la emisión exitosa del váucher del datáfono antes de entregar la mercancía?</li>
            <li>¿Mantienes los billetes ordenados por denominación con la gaveta de caja siempre trabada?</li>
        </ul>
    </div>
</div>', 'Domina el manejo de la estación de caja: recepción del fondo fijo inicial (sencillo/cambio), operación de puntos de venta (POS), detección de billetes falsos y elaboración del acta de arqueo ciego.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (253, 253, 'Protección de Secretos Comerciales y Canales de Denuncia Segura', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-incognito fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">La Información es el Activo Más Valioso de la Empresa</h5>
            <p class="mb-0 small">La fuga de datos confidenciales o la complicidad ante fraudes corporativos acarrean responsabilidades civiles y penales directas. Aprende a resguardar la información y usar canales de denuncia seguros.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/iiNkZWuht2s" title="Protección de datos personales y confidencialidad de la información" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-file-earmark-lock text-primary me-2"></i>1. Acuerdos de Confidencialidad (NDA) y Secretos Industriales</h4>
    <p>En la era digital, la ventaja competitiva de una compañía reside en sus algoritmos, bases de datos de clientes, estructuras de costos y planes de expansión:</p>
    <ul>
        <li><strong>Información Confidencial:</strong> Todo dato contable, técnico, comercial o personal al que se tiene acceso en razón del cargo y que no es de dominio público general.</li>
        <li><strong>Vigencia Post-Laboral:</strong> Los acuerdos de confidencialidad y la legislación mercantil establecen que el deber de secreto industrial se mantiene vigente incluso años después de haber renunciado o finalizado la relación laboral con la empresa.</li>
        <li><strong>Prohibición del Uso de Información Privilegiada (Insider Trading):</strong> Utilizar datos no públicos (ej. saber antes del anuncio oficial que la empresa será vendida o que cerrará un contrato multimillonario) para beneficio financiero propio o de terceros es un delito grave.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-megaphone text-primary me-2"></i>2. Canales de Denuncia Ética y Protección al Denunciante (Whistleblowing)</h4>
    <p>Los canales de denuncia ética son herramientas institucionales confidenciales que permiten a los colaboradores reportar malas prácticas corporativas sin temor a represalias laborales:</p>
    <ol>
        <li><strong>Anonimato y Confidencialidad Garantizada:</strong> Las líneas éticas modernas suelen ser operadas por firmas auditoras independientes externas a la empresa para asegurar que la identidad del denunciante esté técnicamente blindada.</li>
        <li><strong>Conductas Denunciables:</strong> Fraude financiero, malversación de fondos, sobornos a funcionarios públicos o clientes, acoso sexual o laboral, robo continuado de inventario y falsificación de balances.</li>
        <li><strong>Política de Cero Represalias (Non-Retaliation Policy):</strong> Las corporaciones serias penalizan con despido inmediato a cualquier supervisor que intente degradar, aislar o despedir a un empleado por haber presentado una denuncia de buena fe.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Compartir datos sensibles por chats informales:</strong> Enviar listas de clientes con números de cédula, correos y tarjetas por grupos personales de WhatsApp viola normativas internacionales de protección de datos (RGPD / Habeas Data).</li>
        <li><strong>Utilizar el canal ético para vendettas personales:</strong> Presentar denuncias falsas o maliciosas por enemistad personal satura el sistema de cumplimiento y puede generar sanciones disciplinarias contra el difamador.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Bloqueas tu pantalla cada vez que te levantas de tu estación de trabajo en la oficina?</li>
            <li>¿Mantienes absoluta discreción sobre costos, sueldos y clientes en conversaciones fuera del trabajo?</li>
            <li>¿Conoces el enlace o número de la línea ética confidencial de tu empresa?</li>
        </ul>
    </div>
</div>', 'Domina las obligaciones legales de no divulgación (NDA), el manejo de datos de clientes y el funcionamiento de las líneas éticas anónimas para denunciar fraudes.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (238, 238, 'Procedimientos de Garantía, Libro de Reclamaciones y Resolución Positiva', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-heart-pulse-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Paradoja de la Recuperación del Servicio</h5>
            <p class="mb-0 small">Los estudios de retención en retail demuestran que un cliente que tuvo un problema con un producto y fue atendido con rapidez, empatía y solución inmediata se vuelve más leal a la marca que un cliente que nunca tuvo ningún inconveniente.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/4heWWZvAut0" title="Administración de Devoluciones y Cambios" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Método L.A.S.T. para Desescalar Situaciones Tensas</h4>
    <p>Cuando un cliente llega al mostrador furioso, alzando la voz por un producto defectuoso, el peor error del asistente es ponerse a la defensiva o discutir. Los entrenadores de servicio al cliente enseñan la técnica <strong>L.A.S.T.</strong>:</p>
    <div class="row g-2 mb-4">
        <div class="col-md-3">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">L - Listen (Escuchar)</span>
                <p class="small mb-0 text-muted">Dejar que el cliente exprese toda su frustración sin interrumpir. El cliente necesita desahogar su energía emocional antes de estar listo para escuchar soluciones lógicas.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">A - Apologize (Disculparse)</span>
                <p class="small mb-0 text-muted">Disculparse por la molestia o inconveniente ocasionado (no significa aceptar culpa personal): <em>''Lamento mucho el tiempo que ha perdido por este inconveniente, entiendo perfectamente su molestia''</em>.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-warning text-dark mb-2">S - Solve (Resolver)</span>
                <p class="small mb-0 text-muted">Proponer una solución concreta e inmediata dentro de las políticas de la empresa: cambio por un producto nuevo probado en el momento o emisión de nota de crédito.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-secondary mb-2">T - Thank (Agradecer)</span>
                <p class="small mb-0 text-muted">Agradecer por señalar el fallo: <em>''Gracias por informarnos sobre este lote, nos ayuda a revisar con el fabricante y asegurar la calidad de nuestros productos''</em>.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-clipboard-check-fill text-primary me-2"></i>2. Protocolo de Inspección Física del Producto Devuelto</h4>
    <p>Antes de autorizar un cambio o devolución, el asistente debe realizar la verificación técnica de los 4 puntos:</p>
    <ol>
        <li><strong>Comprobante Fiscal de Compra:</strong> Factura original, ticket de caja o registro digital del cliente en el sistema.</li>
        <li><strong>Plazo de Garantía Vigente:</strong> Comprobar que la solicitud esté dentro de los días estipulados por la política de la empresa (ej: 7 días para cambio directo en tienda y 30 a 90 días por garantía de fábrica).</li>
        <li><strong>Estado Físico del Empaque y Accesorios:</strong> Verificar que contenga el manual, cables, cargadores originales y que la caja no esté destrozada.</li>
        <li><strong>Descarte de Mal Uso o Manipulación Indebida:</strong> Constatar que el equipo no presente golpes por caída, humedad (sensores de líquido mojados en electrónicos) o sellos de garantía violados por talleres no autorizados.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-file-earmark-text-fill text-primary me-2"></i>3. Emisión de Notas de Crédito y Manejo del Libro de Reclamaciones</h4>
    <p>Si el cliente no desea cambiar el artículo por otro en ese momento, el procedimiento contable correcto es emitir una <strong>Nota de Crédito</strong> en el software de facturación:</p>
    <ul>
        <li>La nota de crédito reingresa el artículo devuelto al stock (o lo envía al almacén de averías si está dañado) y genera un saldo a favor que el cliente puede utilizar en compras futuras.</li>
        <li>Si el cliente exige plasmar su reclamo en el <strong>Libro de Reclamaciones formal</strong>, entrega el formato con amabilidad y serenidad. Registrar un reclamo es un derecho legal del consumidor; atenderlo con respeto previene sanciones de los organismos de protección al consumidor.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tomarse los reclamos como ataques personales:</strong> El cliente está molesto con el producto o con el servicio de la empresa, no contigo. Mantén el tono de voz calmado, pausado y profesional; nunca respondas con sarcasmo o agresividad.</li>
        <li><strong>Reintegrar productos defectuosos a la góndola de venta regular:</strong> Si aceptas la devolución de un producto con falla y lo vuelves a colocar en el estante de venta, otro cliente lo comprará al día siguiente y el problema se multiplicará por dos. Los productos dañados deben enviarse de inmediato al área de merma/garantías con su etiqueta de fallo.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aplicaste la técnica LAST de escucha activa y empatía ante clientes enojados?</li>
            <li>¿Inspeccionaste accesorios, empaque y sellos de garantía antes de procesar el cambio?</li>
            <li>¿Etiquetaste y aislaste el producto defectuoso para que no regrese a las estanterías de venta?</li>
        </ul>
    </div>
</div>', 'Transforma quejas en fidelidad: política legal de cambios y garantías, auditoría física de productos devueltos, emisión de notas de crédito y la técnica LAST para desescalar clientes irritados.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (251, 251, 'La Brújula Moral y Operativa de la Organización', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-award-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La Cultura se Demuestra con Hechos, No con Palabras</h5>
            <p class="mb-0 small">Los valores corporativos no son un póster decorativo en la recepción; son los principios rectores que determinan cómo una empresa trata a sus empleados, clientes y proveedores ante cualquier encrucijada financiera o moral.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/RV9YrstWny0" title="Cómo definir MISIÓN, VISIÓN y VALORES organizacionales PASO a PASO 🎯 +EJEMPLOS prácticos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-compass text-primary me-2"></i>1. Fundamentos: Misión, Visión y Valores Operativos</h4>
    <p>Toda organización exitosa y sostenible en el tiempo se fundamenta en un marco de identidad estratégica claro:</p>
    <ul>
        <li><strong>Propósito Supremo y Misión:</strong> La misión define qué hace la empresa hoy, para quién trabaja y cuál es el valor diferencial que entrega. Responde a preguntas vitales: <em>¿Qué necesidad humana resolvemos? ¿Cuál es nuestro estándar innegociable de servicio?</em>.</li>
        <li><strong>Visión de Futuro:</strong> Representa el destino aspiracional a mediano y largo plazo (habitualmente 3 a 5 años). No es una fantasía irreal, sino una meta inspiradora pero alcanzable que moviliza el esfuerzo de todas las áreas de la compañía.</li>
        <li><strong>Valores Corporativos en Acción:</strong> Los valores son el filtro moral de la toma de decisiones. Un valor como ''Honestidad'' debe traducirse en comportamientos observables: nunca facturar productos no entregados, reportar mermas reales y no mentir a los clientes sobre fechas de despacho.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-diagram-3 text-primary me-2"></i>2. Cómo se Manifiesta la Cultura Organizacional</h4>
    <p>Peter Drucker popularizó la célebre frase: <em>''La cultura se come a la estrategia en el desayuno''</em>. Una empresa puede tener la mejor tecnología y la estrategia financiera más sofisticada, pero si su cultura es tóxica, caracterizada por la desconfianza, el secretismo y el individualismo, los resultados inevitablemente colapsarán:</p>
    <ol>
        <li><strong>Ritos y Comunicación Interna:</strong> La forma en que los líderes reconocen los logros, transmiten las malas noticias y celebran el trabajo en equipo define el clima emocional de la oficina.</li>
        <li><strong>Coherencia del Liderazgo:</strong> Si los directores exigen puntualidad pero llegan tarde, o exigen austeridad mientras despilfarran en lujos personales, la moral de los colaboradores se destruye. El ejemplo visible de los jefes es el principal transmisor de valores.</li>
        <li><strong>Alineación de Compensación y Reconocimiento:</strong> Lo que una empresa realmente premia con aumentos o ascensos es lo que los empleados aprenden a valorar. Si se premia al vendedor estrella aunque falsifique reportes, la empresa está enviando el mensaje de que la ética es secundaria.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-building-check text-primary me-2"></i>3. Caso de Estudio Empresarial: Johnson & Johnson y la Crisis de Tylenol</h4>
    <p>En 1982, cápsulas de Tylenol adulteradas con cianuro por un saboteador externo provocaron la muerte de siete personas en Chicago. En lugar de encubrir el incidente o minimizar el riesgo para salvar sus utilidades inmediatas, el CEO de Johnson & Johnson, James Burke, apeló al <em>''Credo''</em> de la empresa (su declaración de valores escrita en 1943):</p>
    <div class="card bg-light border-start border-primary border-4 p-3 mb-3">
        <p class="mb-1 fst-italic">"Creemos que nuestra primera responsabilidad es ante los médicos, enfermeras y pacientes; las madres y padres y todos los que usan nuestros productos..."</p>
        <span class="small text-muted">— Credo Corporativo de Johnson & Johnson</span>
    </div>
    <p>Siguiendo este principio, la compañía retiró de inmediato 31 millones de botellas de Tylenol de los estantes en todo Estados Unidos con un costo directo de más de $100 millones de dólares, colaboró abiertamente con el FBI e inventó el primer sello de seguridad triple inviolable de la industria farmacéutica. Como resultado, la marca recuperó la confianza total del público y sigue siendo líder mundial indiscutible.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Redactar valores abstractos e inaplicables:</strong> Colocar palabras como ''Sinergia holística'' o ''Perfección paradigmática'' sin explicar qué significan en el trabajo diario crea cinismo entre los empleados.</li>
        <li><strong>Incoherencia entre discurso y práctica (Doble Moral):</strong> Exigir servicio al cliente mientras se reduce deliberadamente la calidad del producto vendido para abaratar costos sin avisar.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Conoces de memoria la misión y visión de tu empresa para orientar tus decisiones laborales diarias?</li>
            <li>¿Tus acciones de esta semana fueron coherentes con los valores declarados de tu organización?</li>
            <li>¿Priorizas la integridad y la reputación a largo plazo por encima de atajos oportunistas a corto plazo?</li>
        </ul>
    </div>
</div>', 'Conoce cómo los valores declarados se transforman en conductas medibles del día a día, guiando las decisiones desde el operario hasta la alta dirección.', 40, 1, true);
INSERT INTO public."Lessons" VALUES (256, 256, 'Diagnóstico Preciso de Necesidades y Asertividad Comunicativa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-ear-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Escuchar para Comprender, No Solo para Responder</h5>
            <p class="mb-0 small">La mayoría de los asesores interrumpen al cliente antes de que termine de formular su problema. Quien domina la escucha activa y el sondeo estratégico ahorra tiempo, evita malentendidos y cierra más operaciones.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/la1F2U7YZTY" title="La Escucha Activa, ¿En Qué Consiste?" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-filter-circle text-primary me-2"></i>1. La Anatomía de la Escucha Activa</h4>
    <p>Escuchar activamente implica un compromiso mental total con el mensaje del interlocutor, prestando atención no solo a las palabras textuales sino a la carga emocional subyacente:</p>
    <ul>
        <li><strong>Silencio Atento:</strong> Permitir que el cliente exponga su situación completa sin interrupciones abruptas durante al menos 45 a 60 segundos.</li>
        <li><strong>Asentimiento Corporal y Verbal:</strong> Acompañar el relato con sutiles movimientos afirmativos de cabeza e interjecciones breves (<em>''Comprendo perfectamente'', ''Ya veo'', ''Entendido''</em>) que confirman la recepción del mensaje.</li>
        <li><strong>Toma de Notas:</strong> En solicitudes complejas o reclamos de garantías, anotar datos clave (códigos de factura, fechas, números de modelo) demuestra seriedad profesional y respeto.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-question-diamond text-primary me-2"></i>2. El Embudo de Preguntas (Funnel de Indagación)</h4>
    <p>Para guiar una conversación de servicio con agilidad, los asesores expertos utilizan una secuencia estructurada de preguntas:</p>
    <ol>
        <li><strong>Preguntas Abiertas de Exploración:</strong> Comienzan con <em>Qué, Cómo, Cuándo o Para qué</em>. Sirven para que el usuario exprese libremente su necesidad: <em>''¿Qué tipo de uso diario le dará al equipo?''</em> o <em>''¿Cómo podemos ayudarle el día de hoy?''</em>.</li>
        <li><strong>Preguntas Cerradas de Confirmación:</strong> Se responden con un ''Sí'' o un ''No'' o seleccionando entre alternativas concretas: <em>''¿Desea facturación a nombre de empresa o persona natural?''</em>, <em>''¿Prefiere entrega en tienda o despacho a domicilio?''</em>.</li>
        <li><strong>La Técnica del Parafraseo Reflejo:</strong> Consiste en repetir con tus propias palabras la esencia de lo planteado por el cliente antes de ofrecer la solución: <em>''Permítame verificar si le he entendido bien, don Carlos: lo que usted requiere es cambiar el repuesto adquirido ayer porque no coincide con las medidas de su vehículo, ¿es correcto?''</em>. Cuando el cliente dice ''Sí, exactamente eso'', la tensión emocional desaparece porque se siente 100% comprendido.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Interrumpir al cliente para adelantarle la solución:</strong> Aunque ya sepas la respuesta a los 10 segundos, interrumpirlo le hace sentir menospreciado y eleva su agresividad defensiva.</li>
        <li><strong>Asumir necesidades sin preguntar:</strong> Entregar un producto basándose en suposiciones erróneas genera devoluciones costosas y quejas formales.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Dejas hablar al cliente sin interrumpirlo durante su exposición inicial?</li>
            <li>¿Utilizas el parafraseo reflejo para confirmar requerimientos antes de ejecutar la acción?</li>
            <li>¿Tomas notas escritas en casos complejos para evitar repetir preguntas innecesarias?</li>
        </ul>
    </div>
</div>', 'Aprende el arte de escuchar el doble de lo que hablas: técnica de parafraseo, preguntas abiertas vs cerradas y cómo empatizar sin perder el control de la conversación.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (263, 263, 'El Modelo de Daniel Goleman: Autoconocimiento, Autorregulación y Empatía', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-heart-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Talento Técnico Abre Puertas; la Inteligencia Emocional las Mantiene Abiertas</h5>
            <p class="mb-0 small">Los profesionales técnicamente brillantes pero emocionalmente inestables o conflictivos terminan estancados o despedidos. Aprende a dominar tus respuestas bajo presión y construir relaciones laborales sólidas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/LoHw4BkmROY" title="La inteligencia emocional en el trabajo  | Gabriel Rodríguez González | TEDxBUAP" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-brain text-primary me-2"></i>1. Los 5 Pilares de la Inteligencia Emocional según Daniel Goleman</h4>
    <p>La inteligencia emocional no consiste en reprimir las emociones, sino en reconocerlas, comprender su origen y gestionarlas de forma constructiva para alcanzar objetivos:</p>
    <ul>
        <li><strong>1. Autoconciencia (Self-Awareness):</strong> La capacidad de identificar en tiempo real lo que sientes y cómo influye en tu rendimiento. Conocer con precisión tus fortalezas y debilidades sin autoengaño.</li>
        <li><strong>2. Autorregulación (Self-Regulation):</strong> La habilidad de pausar antes de reaccionar. No actuar impulsivamente por ira, pánico o frustración. Mantener el autocontrol ante provocaciones o crisis.</li>
        <li><strong>3. Motivación Intrínseca:</strong> El impulso interno por superarse, aprender y hacer un trabajo de calidad por orgullo profesional y autorrealización, más allá del dinero o la presión externa.</li>
        <li><strong>4. Empatía Activa:</strong> La capacidad de sintonizar con los sentimientos, perspectivas y preocupaciones de los compañeros de equipo, adaptando la comunicación a sus realidades.</li>
        <li><strong>5. Habilidades Sociales:</strong> Liderazgo, influencia positiva, gestión constructiva del conflicto y capacidad de inspirar colaboración armónica entre personas con personalidades distintas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-primary me-2"></i>2. La Técnica del ''Espacio de Pausa'' ante la Frustración</h4>
    <p>Viktor Frankl escribió: <em>''Entre el estímulo y la respuesta hay un espacio. En ese espacio reside nuestro poder para elegir nuestra respuesta''</em>:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small"><strong>Protocolo de Autorregulación en 3 Pasos:</strong> Cuando recibas un correo agresivo o un reclamo injusto: <strong>1. Pausa:</strong> No respondas de inmediato (espera 20 minutos). <strong>2. Respira diafragmáticamente:</strong> Inhala en 4 segundos, mantén 4 y exhala en 4 para oxigenar la corteza prefrontal. <strong>3. Responde con hechos:</strong> Elimina adjetivos emocionales y enfócate en datos objetivos y soluciones prácticas.</p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir asertividad con agresividad:</strong> Creer que ''ser sincero y directo'' justifica hablar con arrogancia, humillar o gritar a los colegas.</li>
        <li><strong>El secuestro emocional en reuniones públicas:</strong> Perder los estribos, levantar la voz o abandonar una sala de juntas airadamente arruina la credibilidad profesional de años en 30 segundos.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Reconoces tus detonantes emocionales de estrés antes de perder la calma?</li>
            <li>¿Evitas enviar correos o mensajes importantes cuando sientes enojo o indignación?</li>
            <li>¿Te esfuerzas por entender el punto de vista del otro antes de juzgar sus acciones?</li>
        </ul>
    </div>
</div>', 'Descubre por qué el Coeficiente Emocional (EQ) predice el éxito profesional y los ascensos directivos con el doble de precisión que el Coeficiente Intelectual (IQ).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (243, 243, 'La Mesa de Ayuda Corporativa y el Flujo de Resolución de Incidencias', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-headset fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Soporte Técnico es el Pulmón Operativo de la Empresa</h5>
            <p class="mb-0 small">Un técnico sobresaliente no solo sabe reparar computadores; sabe escuchar al usuario estresado, diagnosticar la causa raíz sin dar rodeos y registrar cada acción en el sistema de tickets para alimentar la base de conocimiento corporativa.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/7kEM9ZaD7jQ" title="Soporte Técnico: L1, L2, L3" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Estructura Jerárquica del Soporte IT (L1, L2, L3)</h4>
    <p>En organizaciones formales bajo el estándar ITIL, la atención a problemas tecnológicos se organiza en niveles para maximizar la eficiencia y no saturar a los ingenieros senior con incidencias básicas:</p>
    <ul>
        <li><strong>Nivel 1 (Tier 1 / Help Desk):</strong> Primer punto de contacto con el usuario. Atiende llamadas, correos o tickets web. Realiza el triaje inicial, restablece contraseñas, verifica conexiones físicas de cables, asiste en configuraciones sencillas de correo y resuelve problemas conocidos con guías paso a paso (SOPs). Resuelve entre el 70% y el 80% de los incidentes en el primer contacto.</li>
        <li><strong>Nivel 2 (Tier 2 / Soporte en Sitio - Desktop Support):</strong> Técnicos de campo que intervienen cuando L1 no puede solucionar el problema de forma remota. Diagnostican fallas físicas de hardware, reemplazan componentes dañados (fuentes de poder, discos duros, pantallas), reinstalan sistemas operativos e inspeccionan puntos de red físicos y conmutadores (switches).</li>
        <li><strong>Nivel 3 (Tier 3 / Especialistas e Ingeniería de Infraestructura):</strong> Administradores de servidores, ingenieros de redes (Cisco/MikroTik), especialistas en bases de datos y desarrolladores de software. Atienden caídas globales de servidores, configuraciones complejas de enrutamiento o fallas en el código de las aplicaciones empresariales.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-ticket-perforated-fill text-primary me-2"></i>2. Gestión de Tickets y Acuerdos de Nivel de Servicio (SLAs)</h4>
    <p>En una empresa, ninguna reparación se realiza ''por favor verbal de pasillo''. Todo requerimiento debe registrarse en un <strong>Sistema de Gestión de Tickets</strong> (como Jira Service Management, Zendesk, GLPI o Freshdesk). Cada ticket se clasifica evaluando dos variables:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Nivel de Prioridad</th>
                    <th>Criterio de Clasificación</th>
                    <th>SLA Típico de Respuesta y Solución</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">Crítica (P1)</td>
                    <td>Afecta a toda la empresa o a un servicio central de facturación/caja. No existe solución alternativa provisional.</td>
                    <td>Respuesta en menos de 15 minutos. Solución en menos de 2 horas.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Alta (P2)</td>
                    <td>Afecta a un departamento completo (ej: el área de contabilidad no puede imprimir cheques en día de cierre).</td>
                    <td>Respuesta en menos de 1 hora. Solución en menos de 4 horas.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-info text-dark">Media (P3)</td>
                    <td>Afecta a un solo usuario, pero este puede continuar trabajando en otras tareas o en un equipo alternativo.</td>
                    <td>Respuesta en menos de 4 horas. Solución en 24 horas hábiles.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-secondary">Baja (P4)</td>
                    <td>Consultas informativas, solicitudes de instalación de programas no urgentes o mejoras visuales.</td>
                    <td>Respuesta en 24 horas. Solución en 48 a 72 horas.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-chat-left-dots-fill text-primary me-2"></i>3. Protocolo de Atención y Comunicación Asertiva con el Usuario</h4>
    <p>Uno de los errores más comunes de los técnicos novatos es utilizar jerga técnica incomprensible con usuarios no especializados. El estándar profesional exige:</p>
    <ol>
        <li><strong>Escucha Activa:</strong> Permitir que el usuario describa qué estaba haciendo cuando ocurrió la falla sin interrumpirle.</li>
        <li><strong>Preguntas de Descarte Guiadas:</strong> ¿El problema ocurrió de repente o después de instalar algo? ¿Apareció algún mensaje de error en pantalla? ¿Otros compañeros de su área experimentan lo mismo?</li>
        <li><strong>Confirmación de Cierre y Retroalimentación:</strong> Antes de cerrar el ticket en el sistema, pedir al usuario que pruebe la función reparada en su presencia para asegurar su total conformidad.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Cerrar tickets sin documentar la solución técnica aplicada:</strong> Dejar el campo de resolución vacío o con un simple ''reparado'' priva a los demás técnicos de consultar la base de conocimiento cuando el problema se repita.</li>
        <li><strong>Manipular archivos personales del usuario sin autorización previa:</strong> Acceder a carpetas personales o fotos durante una asistencia técnica remota vulnera gravemente la privacidad y la ética profesional.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Registraste cada solicitud en el sistema de tickets asignándole el nivel de prioridad correcto?</li>
            <li>¿Notificaste al usuario los tiempos estimados de atención antes de iniciar la intervención?</li>
            <li>¿Documentaste detalladamente los pasos técnicos realizados en las notas de resolución del ticket?</li>
        </ul>
    </div>
</div>', 'Conoce la arquitectura de la mesa de ayuda (Help Desk / Service Desk), la clasificación de incidentes por impacto y urgencia, cumplimiento de SLAs y protocolo de atención al usuario final.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (52, 52, 'Diseño de Hojas de Cálculo Claras, Ordenadas y Profesionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-file-earmark-excel-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Excel: El Lenguaje Universal de las Finanzas y la Operación</h5>
            <p class="mb-0 small">En cualquier puesto administrativo, desde recepcionista hasta director general, saber estructurar una tabla limpia y comprender cómo Excel trata números y textos es el primer paso hacia la autonomía laboral.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/qtuElizNx9g" title="Cómo hacer una tabla en Excel y aplicar formatos en celdas" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Anatomía de la Cuadrícula y Tipos de Datos</h4>
    <p>Excel organiza los datos en columnas (identificadas por letras: A, B, C...) y filas (identificadas por números: 1, 2, 3...). La intersección de una columna y una fila es una <strong>celda</strong> (ejemplo: <code>B4</code>). El secreto para no frustrarse con fórmulas que fallan es entender cómo Excel interpreta lo que escribes:</p>
    <ul>
        <li><strong>Texto (Cadenas alfanuméricas):</strong> Se alinea automáticamente a la <em>izquierda</em> de la celda. Si un número está alineado a la izquierda, significa que Excel lo guardó como texto (a menudo por tener un apóstrofe inicial o espacios invisibles) y no podrá sumarlo.</li>
        <li><strong>Números puros y Moneda:</strong> Se alinean automáticamente a la <em>derecha</em>. Siempre deben ingresarse sin símbolos de moneda escritos a mano (nunca escribas ''$ 100''; escribe <code>100</code> y aplica el formato de moneda desde la barra superior).</li>
        <li><strong>Fechas:</strong> Para Excel, una fecha es internamente un número entero secuencial (donde el número 1 representa el 1 de enero de 1900). Esto permite restar dos fechas para calcular días de vencimiento o mora.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator-fill text-primary me-2"></i>2. Operadores Matemáticos Básicos y Jerarquía de Operaciones</h4>
    <p>Toda fórmula en Excel debe comenzar obligatoriamente con el signo igual (<code>=</code>) o el signo más (<code>+</code>). Los operadores matemáticos elementales son:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Operación</th>
                    <th>Operador</th>
                    <th>Ejemplo Escrito</th>
                    <th>Resultado Práctico</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Suma</td>
                    <td><code>+</code></td>
                    <td><code>=A1 + B1</code></td>
                    <td>Suma los valores de ambas celdas.</td>
                </tr>
                <tr>
                    <td>Resta</td>
                    <td><code>-</code></td>
                    <td><code>=A1 - B1</code></td>
                    <td>Calcula la diferencia o margen bruto.</td>
                </tr>
                <tr>
                    <td>Multiplicación</td>
                    <td><code>*</code> (Asterisco)</td>
                    <td><code>=C2 * D2</code></td>
                    <td>Calcula Total = Cantidad × Precio Unitario.</td>
                </tr>
                <tr>
                    <td>División</td>
                    <td><code>/</code> (Barra inclinada)</td>
                    <td><code>=E2 / 1.16</code></td>
                    <td>Desglosa la base imponible extrayendo el IVA.</td>
                </tr>
            </tbody>
        </table>
    </div>
    <p class="small text-muted"><strong>Jerarquía de Operaciones (PEMDAS):</strong> Excel siempre resuelve primero los paréntesis, luego potencias, luego multiplicaciones y divisiones, y finalmente sumas y restas. La fórmula <code>=10 + 5 * 2</code> da como resultado <strong>20</strong> (no 30). Si deseas sumar primero, debes agrupar entre paréntesis: <code>=(10 + 5) * 2</code> (que da 30).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-table text-primary me-2"></i>3. La Herramienta ''Dar Formato como Tabla'' (Ctrl + T)</h4>
    <p>Muchos usuarios dibujan bordes negros celda por celda y pintan los encabezados a mano. El método profesional es seleccionar cualquier celda del rango y presionar <code>Ctrl + T</code> para convertir el rango en una <strong>Tabla Oficial de Excel</strong>. Ventajas automáticas inmediatas:</p>
    <ol>
        <li>Filtros automáticos desplegables en cada columna para ordenar de la A a la Z o buscar por montos.</li>
        <li>Fórmulas autorrellenadas: Al escribir una fórmula en una celda, Excel la calcula automáticamente hacia abajo en toda la columna.</li>
        <li>Expansión automática: Si agregas una fila nueva al final, la tabla absorbe el formato y las fórmulas al instante.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir texto dentro de celdas con números:</strong> Escribir <code>100 cajas</code> o <code>$50 USD</code> en la celda impide que Excel reconozca el valor como número, arrojando el temido error <code>#¡VALOR!</code> al intentar sumarlo. Coloca el número puro (<code>100</code>) y especifica la unidad (''Cajas'') en el encabezado de la columna.</li>
        <li><strong>Celdas combinadas en columnas de bases de datos:</strong> Usar ''Combinar y centrar'' sobre filas de datos bloquea el ordenamiento y rompe las fórmulas de búsqueda. Las celdas combinadas solo deben usarse en títulos superiores fuera de la tabla.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste que todos los números estén alineados a la derecha y con formato de moneda o millares?</li>
            <li>¿Respetaste los paréntesis en fórmulas combinadas de suma y multiplicación?</li>
            <li>¿Convertiste tus listas de datos en Tablas Oficiales con Ctrl + T para habilitar filtros rápidos?</li>
        </ul>
    </div>
</div>', 'Domina la cuadrícula de Excel: tipos de datos (texto, número, fecha, moneda), operadores matemáticos (+, -, *, /), formateo de tablas oficiales con filtros y atajos esenciales de navegación.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (246, 246, 'Infraestructura Física de Redes, Norma T568B y Diagnóstico de Conectividad', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-2-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Sin Red Física Confiable no Existe Transformación Digital</h5>
            <p class="mb-0 small">El Wi-Fi es cómodo, pero las estaciones de trabajo fijas, servidores de bases de datos, impresoras de alto volumen y cámaras de seguridad corporativas requieren cableado estructurado físico de alta calidad para garantizar estabilidad y cero latencia.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/laWefp80lz4" title="¿Qué es el CABLEADO ESTRUCTURADO?" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Norma de Ponchado T568B: Código de Colores Estándar</h4>
    <p>Para armar cables de red directos (patch cords) utilizados para conectar computadoras a conmutadores de red (switches) o rosetas de pared, el estándar corporativo dominante en todo el continente americano es la norma <strong>TIA/EIA-568-B (T568B)</strong>.</p>
    <p>El cable de par trenzado UTP cuenta con 8 conductores organizados en 4 pares. Mirando el conector RJ45 de frente con la patilla plástica de traba hacia abajo y los pines dorados hacia arriba, el orden riguroso de izquierda a derecha (pin 1 al pin 8) es:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <div class="row g-2 font-monospace small">
            <div class="col-md-3"><strong>Pin 1:</strong> Blanco / Naranja</div>
            <div class="col-md-3"><strong>Pin 2:</strong> Naranja</div>
            <div class="col-md-3"><strong>Pin 3:</strong> Blanco / Verde</div>
            <div class="col-md-3"><strong>Pin 4:</strong> Azul</div>
            <div class="col-md-3"><strong>Pin 5:</strong> Blanco / Azul</div>
            <div class="col-md-3"><strong>Pin 6:</strong> Verde</div>
            <div class="col-md-3"><strong>Pin 7:</strong> Blanco / Marrón</div>
            <div class="col-md-3"><strong>Pin 8:</strong> Marrón</div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tools text-primary me-2"></i>2. Procedimiento de Crimpeado y Testeo de Cables</h4>
    <ol>
        <li>Desforrar aproximadamente 2.5 cm de la cubierta exterior del cable UTP con la cuchilla pelacables sin cortar el aislante de los conductores internos.</li>
        <li>Destrenzar cada par y peinarlos en línea recta para eliminar curvaturas.</li>
        <li>Ordenar los hilos exactamente bajo la norma T568B y cortar los extremos parejos a unos 1.2 cm con la cuchilla de corte transversal de la ponchadora.</li>
        <li>Introducir los hilos firmemente dentro del conector RJ45 asegurando que la cubierta exterior de PVC quede aprisionada dentro de la garganta del conector para que no se suelte por tirones.</li>
        <li>Introducir en la pinza crimpadora y presionar con firmeza hasta el fondo.</li>
        <li><strong>Comprobación Obligatoria:</strong> Conectar ambos extremos a un <em>Tester de Cable de Red</em> y constatar que las 8 luces LED se enciendan secuencialmente del 1 al 8 sin saltos ni cruces.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-terminal-fill text-dark me-2"></i>3. Diagnóstico de Conectividad por Consola (CLI de Windows)</h4>
    <p>Cuando un usuario reporta ''no tengo internet'', un técnico nunca adivina; abre el símbolo del sistema (<code>cmd.exe</code>) y ejecuta el árbol de diagnóstico lógico:</p>
    <ol>
        <li><code>ipconfig /all</code>: Verifica si el computador tiene una dirección IP válida asignada por DHCP (ej: <code>192.168.1.105</code>). Si tiene una IP que empieza por <code>169.254.x.x</code> (APIPA), significa que el computador no tiene comunicación con el router y no recibe asignación de red.</li>
        <li><code>ping 127.0.0.1</code>: Prueba el adaptador de red local (Loopback). Si responde, la tarjeta de red interna está funcionando.</li>
        <li><code>ping [IP_Puerta_de_Enlace]</code> (ej: <code>ping 192.168.1.1</code>): Prueba la comunicación física con el router principal. Si no responde, la falla está en el cable o en el puerto del switch.</li>
        <li><code>ping 8.8.8.8</code>: Prueba la salida real a internet (servidores DNS de Google). Si responde, el enlace con el proveedor de internet está activo.</li>
        <li><code>ping google.com</code>: Prueba la resolución de nombres de dominio (DNS). Si el ping a 8.8.8.8 funciona pero a google.com falla, el problema es que el servidor DNS configurado no resuelve nombres.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar los pares destrenzados más de 1.3 cm dentro del conector:</strong> El trenzado de los cables existe específicamente para anular la diafonía y la interferencia electromagnética (Crosstalk). Destrenzar demasiado el cable causa caídas intermitentes de velocidad y errores de transmisión en redes Gigabit.</li>
        <li><strong>Asignar IPs estáticas duplicadas:</strong> Al configurar impresoras de red o cámaras de seguridad CCTV, si asignas una IP fija que ya está en uso por una computadora o dentro del rango dinámico del DHCP sin reservarla previamente, provocarás un <em>Conflicto de Direcciones IP</em> que desconectará a ambos dispositivos.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste con tester electrónico que los 8 pines tengan continuidad perfecta antes de conectar el cable a la pared?</li>
            <li>¿Etiquetaste ambos extremos del cable de red con la identificación del punto en el pach panel del rack?</li>
            <li>¿Verificaste la conectividad completa ejecutando los 5 pasos de ping en la consola de comandos?</li>
        </ul>
    </div>
</div>', 'Aprende a ponchar cables de red UTP Categoría 5e/6 bajo la norma T568B con conectores RJ45. Diagnostica conectividad con comandos Ping, Traceroute e Ipconfig, y configura direccionamiento IP fijo para impresoras y DVRs.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (244, 244, 'Diagnóstico Electrónico, Protocolo ESD y Desensamble Profesional', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cpu-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">El Diagnóstico Preciso Ahorra Presupuesto y Tiempo</h5>
            <p class="mb-0 small">Cambiar piezas al azar hasta que el equipo funcione es una mala práctica. Un técnico calificado utiliza herramientas de medición, códigos de sonido del BIOS y pruebas de estrés para identificar el componente exacto averiado.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/SRFvGeLt18I" title="🖥️ Mantenimiento Correctivo en Windows: Repara tu PC Paso a Paso 🔧" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Protocolo ESD (Descarga Electroestática) y Seguridad en Taller</h4>
    <p>El cuerpo humano puede acumular miles de voltios de electricidad estática generada por la fricción de la ropa o el calzado sobre pisos sintéticos. Aunque para nosotros es una chispa imperceptible, una descarga de apenas 100 voltios puede destruir los transistores microscópicos de una memoria RAM o una tarjeta madre.</p>
    <p>Antes de abrir cualquier equipo, es obligatorio seguir el <strong>Protocolo ESD</strong>:</p>
    <ul>
        <li>Desconectar el cable de poder de la pared y presionar el botón de encendido del gabinete durante 10 segundos para descargar los condensadores residuales de la fuente de poder.</li>
        <li>Utilizar una <strong>pulsera antiestática</strong> conectada a tierra física o tocar una parte metálica no pintada del chasis de la computadora para equilibrar el potencial eléctrico antes de manipular componentes internos.</li>
        <li>Sujetar los módulos de memoria RAM y tarjetas de expansión únicamente por los bordes de la placa de circuito impreso (PCB), sin tocar jamás los contactos dorados de cobre.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-thermometer-high text-danger me-2"></i>2. Mantenimiento Térmico: Limpieza y Sustitución de Pasta Térmica</h4>
    <p>El calor es el enemigo número uno de los semiconductores. El polvo acumulado en los disipadores de aluminio bloquea el flujo de aire y hace que el procesador alcance temperaturas críticas (más de 85°C - 90°C), activando el mecanismo de protección <em>Thermal Throttling</em> (el equipo reduce drásticamente su velocidad o se apaga repentinamente para no quemarse).</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <h6 class="fw-bold text-dark mb-2"><i class="bi bi-wrench-adjustable text-primary me-2"></i>Paso a Paso Profesional de Renovación Térmica</h6>
        <ol class="small mb-0">
            <li>Retirar el disipador con cuidado (si está pegado, encender el equipo unos minutos antes para ablandar la pasta vieja).</li>
            <li>Limpiar los residuos resecos del procesador y la base del disipador utilizando <strong>alcohol isopropílico al 99%</strong> y toallas de microfibra que no desprendan pelusa.</li>
            <li>Aplicar una pequeña cantidad de pasta térmica de alta conductividad (equivalente al tamaño de un grano de arroz o arveja en el centro del procesador).</li>
            <li>Instalar el disipador ejerciendo presión uniforme en cruz (tornillos diagonales opuestos) para que la pasta se distribuya homogéneamente sin formar burbujas de aire.</li>
        </ol>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-hdd-network-fill text-primary me-2"></i>3. Diagnóstico de Almacenamiento con Tecnología S.M.A.R.T.</h4>
    <p>Los discos duros mecánicos (HDD) y unidades de estado sólido (SSD / NVMe) cuentan con el sistema <strong>S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology)</strong>. Mediante utilidades de diagnóstico como <em>CrystalDiskInfo</em>, el técnico debe auditar:</p>
    <ul>
        <li><strong>Sectores Reasignados (Reallocated Sectors Count):</strong> Indica sectores físicos dañados que el disco tuvo que reubicar en su área de reserva. Si este valor es superior a cero en un HDD, el disco está muriendo y debe clonarse de inmediato.</li>
        <li><strong>Porcentaje de Salud en SSDs (Life Left):</strong> Las celdas de memoria flash NAND tienen un límite de ciclos de escritura (TBW). Monitorear este porcentaje previene la pérdida catastrófica de información contable o del sistema operativo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Utilizar alcohol etílico común (al 70%) para limpiar componentes electrónicos:</strong> Contiene un 30% de agua que puede oxidar los circuitos o causar cortocircuitos si no se evapora por completo. Siempre debe usarse alcohol isopropílico de alta pureza.</li>
        <li><strong>Aplicar exceso de pasta térmica:</strong> Si se aplica demasiada cantidad, la pasta se desbordará por los lados hacia el zócalo (socket) del procesador, actuando como aislante térmico o generando cortocircuitos si la pasta contiene compuestos metálicos conductores.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Te aseguraste de descargar la estática antes de tocar módulos de memoria o placa base?</li>
            <li>¿Comprobaste las temperaturas en reposo y bajo carga con software de monitoreo (HWMonitor / Core Temp)?</li>
            <li>¿Auditaste el estado de salud SMART de la unidad de almacenamiento antes de formatear o cambiar piezas?</li>
        </ul>
    </div>
</div>', 'Aprende a diagnosticar fallas de fuente de poder, placa base, procesador y memoria RAM. Aplica medidas antiestáticas (ESD), realiza sustitución de pasta térmica y diagnostica la salud de discos con CrystalDiskInfo (SMART).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (229, 229, 'Solicitud, Pedido de Compra, Entrada de Mercancías y Factura de Proveedores', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cart-check-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">El Circuito ''Procure to Pay'': Abastecer sin Quiebres de Existencia</h5>
            <p class="mb-0 small">Un departamento de compras profesional no espera a que el inventario se agote en el almacén. En SAP B1, el circuito de compras asegura que cada reposición cuente con autorización presupuestaria, recepción física rigurosa y conciliación de facturas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/GMPXAHxoozs" title="¿En qué consiste el proceso Purchase to pay (P2P)? SERES" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las 4 Etapas del Circuito de Compras</h4>
    <p>El flujo formal de abastecimiento en SAP B1 consta de cuatro documentos encadenados:</p>
    <ol>
        <li><strong>Solicitud de Compra (Purchase Request):</strong> Documento interno emitido por un departamento (ej: Mantenimiento o Almacén) solicitando materiales. No tiene impacto financiero ni fiscal externo.</li>
        <li><strong>Pedido de Compra / Orden de Compra (Purchase Order - PO):</strong> Contrato comercial formal enviado al proveedor con los precios y plazos pactados. En SAP <strong>aumenta el valor del ''Stock Solicitado''</strong>.</li>
        <li><strong>Entrada de Mercancías por Compras (Goods Receipt PO - GRPO):</strong> Es el documento emitido en el muelle de descarga del almacén cuando llega el camión del proveedor. <strong>Aquí es donde se incrementa el Stock Físico en los almacenes</strong> y se genera un asiento de pasivo transitorio de provisión.</li>
        <li><strong>Factura de Proveedores (A/P Invoice):</strong> Registro legal de la factura fiscal recibida del proveedor. Liquida el pasivo transitorio, registra el crédito fiscal de IVA y genera la cuenta por pagar definitiva.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-primary me-2"></i>2. La Conciliación a Tres Bandas (Three-Way Matching)</h4>
    <p>Para evitar pagar facturas por mercancía que nunca llegó a la empresa o con sobreprecios no acordados, SAP aplica el principio de control interno de <strong>Confrontación a Tres Bandas</strong>:</p>
    <ul>
        <li>Verifica que los artículos y precios de la <strong>Factura del Proveedor</strong> coincidan exactamente con la <strong>Orden de Compra (PO)</strong> aprobada.</li>
        <li>Verifica que las cantidades facturadas coincidan con la <strong>Entrada de Mercancías (GRPO)</strong> firmada por el jefe de almacén.</li>
        <li>Si existe una discrepancia en cantidad o precio superior a la tolerancia permitida, SAP bloquea automáticamente el documento impidiendo su pago hasta que el comprador aclare la diferencia.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-truck text-primary me-2"></i>3. Costes de Importación y Gastos en Aduana (Landed Costs)</h4>
    <p>Cuando la empresa importa mercancía del extranjero, el costo real del producto no es solo el valor de compra FOB en puerto de origen. Incluye flete marítimo, seguro internacional, aranceles aduaneros e impuestos de nacionalización.</p>
    <p>Mediante el módulo de <strong>Precios de Entrega (Landed Costs)</strong> en SAP B1, el analista asigna estos costos adicionales a la Entrada de Mercancías original (prorrateándolos por peso, volumen o valor comercial). SAP recalcula automáticamente el costo unitario de cada producto en el almacén, asegurando que la empresa conozca su margen de ganancia real.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Registrar la Factura de Proveedores sin vincularla a la Entrada de Mercancías (GRPO):</strong> Si creas la factura directamente sin ''Copiar de'' la GRPO, provocarás que el stock físico se duplique en el sistema o que quede un pasivo transitorio abierto eternamente en la contabilidad.</li>
        <li><strong>No inspeccionar la mercancía antes de firmar la GRPO:</strong> Una vez que la Entrada de Mercancías se añade a SAP, el sistema asume que los artículos están aptos y disponibles para la venta. Si detectas productos rotos o caducados, debes registrar una <em>Devolución de Mercancías</em> de inmediato.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste que la cantidad recibida en almacén coincida con la Orden de Compra aprobada?</li>
            <li>¿Utilizaste ''Copiar a'' desde la GRPO hacia la Factura de Proveedores para asegurar el cruce a tres bandas?</li>
            <li>¿Registraste los costos de flete e impuestos aduaneros a través del asistente de Landed Costs?</li>
        </ul>
    </div>
</div>', 'Domina el circuito de abastecimiento empresarial: de la Solicitud interna de Compra a la Orden de Compra (PO), la Entrada de Mercancías por Compras (GRPO) con aumento de existencias físicas y la Factura de Proveedores.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (230, 230, 'Transferencias de Stock, Ajustes de Inventario y Recuentos Físicos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-boxes fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Control de Inventarios: El Activo Más Valioso de la Empresa</h5>
            <p class="mb-0 small">El dinero de una empresa de comercio no está en el banco; está acumulado en las estanterías del almacén. Gestionar traslados entre sucursales y ejecutar tomas físicas ciegas en SAP garantiza cero pérdidas y cero descuadres contables.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/N4FbW5yrrY8" title="Mejora tu Almacén con el módulo de INVENTARIO" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Gestión Multialmacén y Traslados de Stock</h4>
    <p>En organizaciones con múltiples puntos de venta, SAP B1 permite definir depósitos diferenciados (ej: Almacén Principal 01, Almacén Tienda Centro 02, Almacén de Merma/Averías 99). Para mover existencias entre depósitos se utilizan dos documentos:</p>
    <ul>
        <li><strong>Solicitud de Traslado:</strong> Documento previo donde la tienda solicita reposición a la bodega central. Reserva el stock en el almacén emisor pero no lo descarga físicamente todavía.</li>
        <li><strong>Traslado de Inventario (Inventory Transfer):</strong> Ejecuta el movimiento real. Descarga el inventario del Almacén Origen y lo acredita en el Almacén Destino. Es una transacción puramente logística que <strong>no genera pérdidas ni ganancias</strong>, solo traslada el valor del activo entre cuentas de inventario de cada centro de costo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-clipboard-data-fill text-primary me-2"></i>2. Ajustes de Entrada y Salida por Merma o Donación</h4>
    <p>Cuando un artículo se deteriora, vence o sufre un accidente en la bodega, no puede venderse a clientes. Para darlo de baja legalmente en SAP se utiliza:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Documento en SAP B1</th>
                    <th>Efecto Físico en Stock</th>
                    <th>Efecto Contable</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">Salida de Mercancías (Goods Issue)</td>
                    <td>Disminuye las existencias en el almacén seleccionado.</td>
                    <td>Imputa el valor monetario a una cuenta de <strong>Gasto por Merma, Deterioro u Obsolescencia</strong>.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">Entrada de Mercancías (Goods Receipt)</td>
                    <td>Aumenta las existencias en el almacén seleccionado.</td>
                    <td>Acredita una cuenta de <strong>Ajuste de Inventario / Sobrante Operativo</strong>.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-check2-circle text-primary me-2"></i>3. El Asistente de Recuento de Inventario (Toma Física Ciega)</h4>
    <p>Al finalizar el mes o trimestre, la empresa debe auditar que las existencias teóricas del sistema coincidan con los bultos reales en estantería:</p>
    <ol>
        <li>Abrir el <strong>Documento de Recuento de Inventario</strong> en SAP y seleccionar los almacenes o pasillos a auditar.</li>
        <li><strong>Congelar Artículos (Freeze Items):</strong> Al marcar la casilla ''Fijar'', SAP bloquea temporalmente los artículos seleccionados impidiendo que se emitan facturas o traslados sobre ellos mientras los operarios cuentan en el almacén.</li>
        <li><strong>Conteo Ciego:</strong> Se imprime la hoja de recuento para los auditores <em>sin mostrar las cantidades teóricas</em>, obligándolos a contar físicamente cada unidad sin sesgos.</li>
        <li><strong>Carga de Conteo y Contabilización de Diferencias:</strong> Se ingresan las cifras contadas en SAP. El sistema resalta en rojo las discrepancias y genera automáticamente un documento de <em>Contabilización de Inventario</em> que ajusta el stock contable igualándolo a la realidad física de una sola vez.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mover mercancía entre tiendas físicamente sin registrar el Traslado en SAP:</strong> Provoca que el sistema muestre stock disponible en una tienda donde no hay nada, haciendo que los vendedores pierdan ventas o vendan productos inexistentes.</li>
        <li><strong>Hacer ajustes de inventario manuales sin código de motivo ni autorización gerencial:</strong> En empresas auditadas, cada salida de mercancía por merma debe llevar adjunto el número de acta de auditoría firmado por el jefe de prevención de pérdidas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Congelaste los artículos en SAP antes de iniciar la toma física de inventario en la bodega?</li>
            <li>¿Registraste las mermas mediante ''Salida de Mercancías'' imputadas a la cuenta contable correcta?</li>
            <li>¿Verificaste que los traslados entre tiendas reflejen el almacén emisor y receptor exactos?</li>
        </ul>
    </div>
</div>', 'Gestiona múltiples almacenes en SAP B1. Domina las Solicitudes y Traslados de Inventario entre sucursales, el registro de mermas y el Asistente de Recuento de Inventario (Toma Física Ciega) con ajustes de stock.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (237, 237, 'Control Visual, Reposición Oportuna y Detección de Farderos y Hurtos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-shaded fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Prevención de Pérdidas: Cuidar las Ganancias que se Escapan en Silencio</h5>
            <p class="mb-0 small">La merma por hurto externo, hurto interno y deterioro por manipulación inadecuada puede consumir hasta el 3% o 4% de las ventas totales de una cadena de retail, borrando el margen neto de utilidad del negocio.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/Sl0iAuy_Dto" title="Diseño de sistema de control de merma sección fruver" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las 3 Fuentes Principales de Merma en Comercio</h4>
    <p>Para combatir las pérdidas en piso de venta, se debe entender su origen estadístico:</p>
    <ul>
        <li><strong>Hurto Externo (Farderos y Ocasionales - ~38% de la merma):</strong> Sustracción de productos por parte de supuestos clientes que ocultan artículos entre sus ropas, bolsos forrados de aluminio o carritos de bebés.</li>
        <li><strong>Hurto Interno y Colusión de Empleados (~35% de la merma):</strong> Complicidad entre cajeros y clientes amigos para pasar artículos sin escanear (<em>Sweethearting</em>), consumo no pagado de mercancía en bodegas o sustracción en basuras.</li>
        <li><strong>Merma Operativa y Averías (~27% de la merma):</strong> Productos que se caen de las góndolas por apilamiento inestable, cajas que se abren con cutters de forma torpe cortando la mercancía interna o productos vencidos por no rotar las fechas de caducidad.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-eye-fill text-primary me-2"></i>2. Detección de Modus Operandi y Disuasión con Servicio al Cliente</h4>
    <p>El arma preventiva más poderosa contra el hurto en tiendas minoristas no son las cámaras ocultas, sino la <strong>Atención al Cliente Activa</strong>. El ladrón busca anonimato y rincones ciegos sin supervisión. Cuando un empleado se acerca amablemente y le dice con contacto visual firme:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <span class="fw-bold text-primary fs-6">"Buenos días, veo que le interesan nuestros productos de perfumería. Cualquier consulta estoy aquí al lado para atenderle."</span>
    </div>
    <p class="small text-muted">Esta simple intervención desmantela la oportunidad del fardero sin confrontaciones agresivas, haciéndole saber que está siendo observado activamente por el personal del piso.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-octagon-fill text-danger me-2"></i>3. Señales de Alerta de Comportamiento Sospechoso</h4>
    <ul>
        <li>Personas con ropa excesivamente abrigada o chaquetas gruesas en días calurosos.</li>
        <li>Individuos que miran constantemente al personal y a las cámaras de seguridad en lugar de mirar los productos en los estantes.</li>
        <li>Llevar bolsas grandes de compras de otras tiendas con sellos rotos o mochilas entreabiertas apoyadas en el suelo.</li>
        <li>Tomar productos de alto valor y desplazarse hacia pasillos solitarios o zonas de artículos de bajo costo (ej: llevarse cosméticos caros al pasillo de escobas para esconderlos).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Acusar o retener físicamente a un sospechoso sin protocolo legal:</strong> Acusar a alguien de hurto antes de que cruce la línea de caja sin haber pagado puede acarrear demandas judiciales por difamación y privación ilegítima de libertad. Siempre notifica al personal de seguridad autorizado para que actúe fuera de la línea de cobro.</li>
        <li><strong>Cortar cajas de mercancía nueva con cutters profundos:</strong> Introducir la cuchilla del cutter al máximo al abrir cajas maestras de cartón corta las etiquetas y empaques de los productos internos, generando merma evitable antes de que el artículo llegue a la góndola.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Mantienes contacto visual y saludo activo con todos los clientes en tu zona de pasillo?</li>
            <li>¿Ajustas las cuchillas de corte para no dañar los productos al abrir cajas en bodega?</li>
            <li>¿Revisas periódicamente los puntos ciegos y verificas que los sensores antihurto estén colocados?</li>
        </ul>
    </div>
</div>', 'Custodia la rentabilidad de la sucursal: técnicas de zonificación visual, detección de modus operandi de farderos y bandas de hurto, control de mermas internas y mantenimiento de pasillos despejados.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (261, 261, 'Uso de EPP, Levantamiento Seguro de Pesos y Convivencia con Montacargas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-fill-exclamation fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Seguridad Industrial: En el Almacén, el Cero Accidente es la Prioridad Absoluta</h5>
            <p class="mb-0 small">Un montacargas de 3 toneladas cargado con mercancía no frena en seco como un automóvil. La convivencia entre maquinaria pesada y operarios a pie exige respeto absoluto a las normas de tránsito, señalización y equipo de protección personal.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/mWyEEykWeTY" title="MANEJO MANUAL DE CARGAS Y SEGURIDAD INDUSTRIAL" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Equipo de Protección Personal (E.P.P.) Obligatorio</h4>
    <p>El ingreso a cualquier almacén formal exige portar el kit de bioseguridad y protección mecánica desde el primer minuto:</p>
    <ul>
        <li><strong>Botas de Seguridad con Puntera de Acero o Composite:</strong> Protegen los dedos de los pies ante la caída accidental de cajas pesadas o el impacto de transpaletas manuales. Suela antideslizante resistente a aceites.</li>
        <li><strong>Chaleco Reflectivo de Alta Visibilidad:</strong> Permite que los conductores de montacargas distingan a los peatones en pasillos oscuros o en cruces de muelle a más de 50 metros de distancia.</li>
        <li><strong>Casco de Seguridad (en zonas de racks de altura):</strong> Protege la cabeza contra la caída de objetos desprendidos desde niveles superiores de la estantería.</li>
        <li><strong>Guantes de Nitrilo o Descarne:</strong> Evitan cortes con bordes afilados de cartón, astillas de tarimas de madera y quemaduras por fricción con cuerdas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-person-walking text-primary me-2"></i>2. Ergonomía: La Técnica del Levantamiento Seguro de Cargas</h4>
    <p>Las lesiones lumbares y hernias discales son la principal causa de incapacidad laboral en logística. Ocurren por doblar la cintura manteniendo las piernas rectas para levantar una caja del suelo (lo que multiplica la presión en las vértebras por diez):</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <h6 class="fw-bold text-dark mb-2">Los 5 Pasos del Levantamiento Ergonómico</h6>
        <ol class="small mb-0">
            <li><strong>Separar los pies:</strong> Colocar los pies a la anchura de los hombros, con un pie ligeramente adelantado para mantener una base de apoyo sólida.</li>
            <li><strong>Flexionar las rodillas:</strong> Bajar el cuerpo doblando las rodillas en cuclillas, manteniendo la <strong>espalda recta</strong> en todo momento.</li>
            <li><strong>Pegar la carga al cuerpo:</strong> Abrazar la caja y mantenerla pegada al pecho; cuanto más alejes la carga del cuerpo, más se multiplica el esfuerzo en los lumbares.</li>
            <li><strong>Levantar con la fuerza de las piernas:</strong> Levantarse estirando las piernas (los músculos de los muslos y glúteos son los más fuertes del cuerpo humano; ellos deben hacer el trabajo, no tu columna).</li>
            <li><strong>Girar con los pies, nunca con la cintura:</strong> Si necesitas cambiar de dirección con la carga en brazos, mueve los pies; nunca tuerzas el torso mientras sostienes peso.</li>
        </ol>
    </div>
    <p class="small text-muted"><em>Límites de Carga de la OIT (Organización Internacional del Trabajo):</em> Un operario varón no debe levantar manualmente más de <strong>25 kg</strong> de forma individual (15 kg para mujeres o trabajadores jóvenes). Cualquier bulto que supere ese peso exige levantamiento entre dos personas o el uso de ayudas mecánicas (transpaleta o carretilla).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-truck-front text-danger me-2"></i>3. Reglas de Convivencia con Montacargas (Forklifts)</h4>
    <ul>
        <li><strong>Regla de los 3 Metros:</strong> Todo peatón debe mantener una distancia de seguridad de al menos 3 metros alrededor de un montacargas en movimiento.</li>
        <li><strong>Contacto Visual Obligatorio:</strong> Nunca asumas que el montacarguista te ha visto. Establece contacto visual directo y espera a que el operador detenga el vehículo y te haga una señal con la mano antes de cruzar su pasillo.</li>
        <li><strong>Uso Exclusivo de Pasarelas Peatonales:</strong> Caminar estrictamente por los pasillos peatonales demarcados en verde o amarillo, respetando los espejos parabólicos ciegos en los cruces de esquinas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Utilizar tarimas de madera rotas o rajadas:</strong> Una tarima con tablas fracturadas puede colapsar al levantarla con el montacargas a 6 metros de altura, arrojando una tonelada de peso sobre el pasillo. Las tarimas en mal estado deben desecharse de inmediato.</li>
        <li><strong>Subirse a las uñas de un montacargas o a una transpaleta para alcanzar cajas altas:</strong> Está terminantemente prohibido por las normas internacionales OSHA. Para trabajos en altura se deben utilizar escaleras con barandas de seguridad o plataformas elevadoras certificadas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Portas tu equipo de protección personal (botas de seguridad y chaleco reflectivo)?</li>
            <li>¿Flexionas las rodillas y mantienes la espalda recta al levantar cajas del piso?</li>
            <li>¿Respetas los límites de peso de 25 kg y pides ayuda para cargas voluminosas?</li>
        </ul>
    </div>
</div>', 'Protege tu salud y tu vida en el almacén: técnica ergonómica de levantamiento de cargas sin lesiones lumbares, uso obligatorio de EPP (casco, botas, chaleco) y normas de tránsito seguro con montacargas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (248, 248, 'El Circuito Administrativo de Abastecimiento y Cuentas por Pagar', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-file-earmark-spreadsheet-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Control de Compras: El Dinero que se Ahorra en Compras es Utilidad Pura</h5>
            <p class="mb-0 small">Para ganar $1.000 USD de utilidad neta, una empresa con margen del 10% tiene que vender $10.000 USD adicionales. En cambio, negociar un ahorro de $1.000 USD en compras va directo al 100% como ganancia neta en el balance general.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/WzqqoigQsuk" title="Requisiciones de Compras en Business Central y ERP" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Circuito Documental de Compras en 5 Pasos</h4>
    <p>En cualquier empresa auditada, ningún empleado puede llamar a un proveedor y encargar materiales por teléfono sin respaldo documental. El circuito oficial exige:</p>
    <ol>
        <li><strong>Requisición Interna de Compra (Requisition):</strong> El área solicitante (ej: Contabilidad pidiendo resmas de papel, o Taller pidiendo repuestos) llena el formulario interno indicando especificaciones técnicas, cantidad requerida y justificación operativa. Debe estar firmada por el jefe del departamento.</li>
        <li><strong>Cuadro Comparativo de Cotizaciones (Licitación):</strong> El analista de compras solicita presupuestos a un mínimo de <strong>3 proveedores independientes</strong>, comparando en una matriz: precio unitario, tiempo de entrega, condiciones de crédito y garantías.</li>
        <li><strong>Orden de Compra Formal (Purchase Order - PO):</strong> Contrato mercantil legal firmado por la Gerencia que autoriza al proveedor ganador a despachar. Fija de forma inmutable los precios pactados e impuestos de ley.</li>
        <li><strong>Nota de Recepción en Almacén (Goods Receipt):</strong> Al recibir el camión, el almacenista cuenta y verifica que la mercancía esté en perfecto estado antes de firmar la guía de despacho.</li>
        <li><strong>Factura Fiscal y Programación de Pago:</strong> Administración recibe la factura original del proveedor, verifica la coincidencia con la Orden de Compra y la Nota de Recepción (Conciliación a Tres Bandas) y programa la transferencia bancaria según el plazo de crédito pactado (ej: crédito a 30 días).</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-wallet2 text-primary me-2"></i>2. Cuentas por Pagar (CXP) y Flujo de Caja</h4>
    <p>El departamento de Cuentas por Pagar es el encargado de proteger la liquidez de la empresa:</p>
    <ul>
        <li><strong>Aprovechamiento de Descuentos por Pronto Pago:</strong> Muchos proveedores ofrecen condiciones tipo <code>2/10 neto 30</code> (un 2% de descuento si se cancela en los primeros 10 días, o pago neto a los 30 días). Aprovechar estos descuentos representa un rendimiento financiero superior al de cualquier banco.</li>
        <li><strong>Calendario Semanal de Pagos:</strong> En lugar de emitir transferencias todos los días a cualquier hora, las empresas ordenadas fijan un día específico a la semana (ej: los jueves) para procesar pagos a proveedores, facilitando la conciliación bancaria.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Pagar facturas sin la Orden de Compra aprobada adjunta:</strong> Pagar requerimientos verbales o facturas sueltas abre la puerta a fraudes internos, compras a precios inflados y pagos duplicados.</li>
        <li><strong>No solicitar comprobantes de retención fiscal:</strong> En países como Venezuela con agentes de retención de IVA e ISLR (SENIAT), no emitir y archivar los comprobantes de retención dentro del plazo legal acarrea multas tributarias y cierre temporal del establecimiento comercial.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Exiges la Requisición interna firmada antes de cotizar compras departamentales?</li>
            <li>¿Comparas al menos 3 cotizaciones independientes en una matriz de decisión transparente?</li>
            <li>¿Realizas la conciliación a tres bandas (Factura + OC + Recepción) antes de programar pagos?</li>
        </ul>
    </div>
</div>', 'Domina el circuito documental de egresos: la Requisición interna, la solicitud de tres cotizaciones, la emisión de la Orden de Compra (PO), la verificación de recepción y la programación de pagos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (249, 249, 'El Ciclo de Facturación y Cuentas por Cobrar (CXC)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-receipt-cutoff fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Venta no Termina cuando se Entrega el Producto; Termina cuando se Cobra</h5>
            <p class="mb-0 small">Facturar millones no sirve de nada si el dinero queda atrapado en cuentas por cobrar vencidas de clientes morosos. La gestión rigurosa de cartera garantiza que las ventas se conviertan en dinero líquido en el banco.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/8oMGEuH5qT0" title="Flujo Operativo de Ventas y Facturación en ERP" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Cotización Comercial Profesional</h4>
    <p>Una cotización comercial no es solo una lista de precios; es un documento formal que blinda legalmente a la empresa. Toda cotización ejecutiva debe contener obligatoriamente 5 cláusulas clave:</p>
    <ul>
        <li><strong>Tiempo de Validez de la Oferta:</strong> (ej: <em>''Válida por 5 días hábiles a partir de la fecha de emisión''</em>). Protege al negocio frente a fluctuaciones de costos de reposición o inflación.</li>
        <li><strong>Condiciones de Pago:</strong> Anticipo del 50% al ordenar y 50% contra entrega, o crédito a 15 días previa aprobación del departamento financiero.</li>
        <li><strong>Tiempos de Entrega Estimados:</strong> Expresados en días hábiles tras la confirmación del pago o la recepción formal de la orden de compra.</li>
        <li><strong>Desglose de Impuestos de Ley:</strong> Detallar claramente la base imponible y el porcentaje exacto de IVA.</li>
        <li><strong>Lugar de Entrega (Incoterms básicos):</strong> Especificar si el flete está incluido hasta el almacén del cliente o si la mercancía se retira en el mostrador del vendedor.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calendar-range text-primary me-2"></i>2. Gestión de Cartera y Reporte de Antigüedad de Saldos (Aging)</h4>
    <p>En el departamento de <strong>Cuentas por Cobrar (CXC)</strong>, los analistas auditan semanalmente el estado de la cartera clasificando las deudas en tramos de vencimiento:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Tramo de Cartera</th>
                    <th>Estado de Riesgo</th>
                    <th>Acción de Cobranza Profesional</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-success">Por Vencer (0 a 30 días)</td>
                    <td>Riesgo Bajo / Corriente</td>
                    <td><strong>Cobranza Preventiva:</strong> Enviar estado de cuenta cordial 5 días antes del vencimiento recordando la fecha límite de pago y los datos bancarios.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Vencida de 1 a 15 días</td>
                    <td>Riesgo Moderado</td>
                    <td>Llamada telefónica directa de seguimiento al jefe de pagos del cliente solicitando fecha programada de transferencia.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Vencida de 16 a 45 días</td>
                    <td>Riesgo Alto</td>
                    <td><strong>Bloqueo Comercial en ERP:</strong> Suspender automáticamente nuevos despachos o pedidos al cliente hasta que liquide el saldo vencido.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-dark">Más de 60 días</td>
                    <td>Riesgo Crítico / Incobrable</td>
                    <td>Paso a cobro jurídico y aplicación de intereses moratorios pactados contractualmente.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Esperar a que la factura venza para contactar al cliente:</strong> La cobranza moderna es preventiva. Si esperas al día del vencimiento, el cliente te dirá que su programación de pagos ya cerró y que te pagará la semana siguiente. Contáctalo con anticipación.</li>
        <li><strong>Entregar mercancía a crédito sin consultar el límite crediticio en el sistema:</strong> Si un asesor de ventas despacha productos a un cliente que ya tiene el límite de crédito copado o facturas vencidas, la empresa asume un riesgo de incobrabilidad inaceptable.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Incluyen tus cotizaciones plazo de validez, condiciones de pago y desglose fiscal?</li>
            <li>¿Auditas semanalmente el reporte de antigüedad de saldos (Aging) de tus clientes?</li>
            <li>¿Ejecutas llamadas de cobranza preventiva antes de que se cumpla la fecha de vencimiento?</li>
        </ul>
    </div>
</div>', 'Aprende el ciclo de ingresos: elaboración de cotizaciones comerciales con validez legal, emisión de facturas fiscales, seguimiento preventivo de cobranza y gestión de antigüedad de saldos (Aging).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (242, 242, 'Tácticas de Visibilidad: Stoppers, Cenefas, Racks y Negociación en Tienda', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-badge-ad-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Material POP: Romper la Monotonía del Pasillo</h5>
            <p class="mb-0 small">Una góndola llena de botellas idénticas es invisible para el cliente que camina distraído mirando su teléfono celular. El material POP rompe la línea visual, resalta promociones y detiene el paso del comprador en seco.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/uf8lW2dan1A" title="Producción y Montaje de Material POP en Retail" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Tipos de Material P.O.P. (Point of Purchase)</h4>
    <p>El material POP se compone de todos los elementos publicitarios visuales temporales colocados en el punto de contacto con el cliente:</p>
    <ul>
        <li><strong>Stoppers / Rompetráficos:</strong> Carteles plásticos perpendiculares a la góndola que sobresalen hacia el centro del pasillo. Obligan al cliente a ver la marca mientras camina de frente.</li>
        <li><strong>Cenefas (Shelf Strips):</strong> Tiras adhesivas o plásticas que se insertan a lo largo del fleje metálico de la bandeja, destacando los colores de la marca, el slogan o el precio de oferta.</li>
        <li><strong>Dangler / Wobbler:</strong> Cartelitos suspendidos por una tira plástica flexible que se mueven y vibran con las corrientes de aire del pasillo, atrayendo el reflejo visual periférico del ojo.</li>
        <li><strong>Floor Prints (Viniles de Suelo):</strong> Adhesivos de alta resistencia pegados en el piso que guían las pisadas del cliente hacia la sección de la marca.</li>
        <li><strong>Racks y Exhibidores de Cartón (Displays):</strong> Muebles independientes colocados en cabeceras o esquinas estratégicas para campañas específicas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-people-fill text-primary me-2"></i>2. La Relación Estratégica con el Jefe de Piso y Gerente de Tienda</h4>
    <p>El éxito de un mercaderista depende en un 50% de su técnica y en un 50% de sus relaciones interpersonales con el personal de la tienda (jefe de pasillo, jefe de almacén y gerente de sucursal). Un buen mercaderista aplica las siguientes normas de conducta:</p>
    <ol>
        <li><strong>Puntualidad y Respeto a las Normas de Recepción:</strong> Llegar en los horarios permitidos de reposición, utilizar uniforme impecable y portar carnet de identificación y calzado de seguridad en bodega.</li>
        <li><strong>Colaboración y Orden:</strong> Nunca dejar cajas vacías tiradas en el pasillo que obstaculicen el paso de los clientes o causen tropiezos. El pasillo debe quedar más limpio de lo que estaba antes de la reposición.</li>
        <li><strong>Argumentar con Datos de Venta para Ganar Espacios:</strong> Para pedirle al jefe de tienda un espacio adicional en cabecera de góndola, no digas: <em>''Póngame aquí porque se ve bonito''</em>; argumenta con números: <em>''Jefe, este producto creció un 25% en ventas el mes pasado y si le colocamos una cabecera este fin de semana, la tienda aumentará la facturación de esta categoría en $800 USD''</em>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-camera-fill text-primary me-2"></i>3. El Reporte Fotográfico de Auditoría (Antes y Después)</h4>
    <p>Las marcas exigen a sus mercaderistas documentar su trabajo diario mediante aplicaciones móviles de Trade Marketing:</p>
    <ul>
        <li><strong>Foto ''Antes'':</strong> Muestra el estado del anaquel al llegar (desordenado, con huecos o sin precios) para evidenciar el trabajo pendiente.</li>
        <li><strong>Foto ''Después'':</strong> Muestra la góndola 100% frenteada, limpia, con planograma cumplido, precios colocados y material POP instalado.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar material POP deteriorado, roto o desteñido:</strong> Un stopper sucio, doblado o con cinta pegante manchada transmite una imagen de abandono y mala calidad de la marca. Si el material POP está roto, retíralo o cámbialo por uno nuevo.</li>
        <li><strong>Tapar productos con el material publicitario:</strong> Instalar un wobbler o un stopper de tal manera que oculte la etiqueta o el precio de otro producto genera el enfado del jefe de tienda y de las marcas competidoras.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Instalaste el material POP en los puntos autorizados sin tapar otros productos ni precios?</li>
            <li>¿Dejaste el pasillo y el área de góndola totalmente despejados de cajas vacías y basura?</li>
            <li>¿Tomaste y enviaste tu reporte fotográfico del ''Antes y Después'' a tu supervisor de zona?</li>
        </ul>
    </div>
</div>', 'Conquista el punto de venta con material publicitario POP (Point of Purchase): stoppers, cenefas, floor prints y cabezales. Aprende a negociar espacios adicionales con el Gerente de Tienda.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (259, 259, 'Muelle de Carga, Zona de Pulmón, Picking y Despachos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-grid-1x2-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Layout: Diseñar el Espacio para Minimizar Pasos Inútiles</h5>
            <p class="mb-0 small">En un almacén de 2.000 metros cuadrados, el 60% del tiempo de un operario se pierde caminando de un lado a otro buscando productos. Un diseño de layout inteligente reduce las distancias de recorrido a la mitad y acelera los despachos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/sI2-qTBqY0I" title="Layout prácticos para analizar y optimizar los procesos de almacén" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las 5 Zonas Obligatorias de un Almacén Funcional</h4>
    <p>Para que las operaciones fluyan sin colisiones entre montacargas y operarios de a pie, la bodega se divide en zonas bien delimitadas con pintura epóxica de alto tráfico en el suelo:</p>
    <ul>
        <li><strong>Zona de Carga y Descarga (Muelles / Docks):</strong> Área donde atracan los camiones. Requiere rampas niveladoras mecánicas o hidráulicas para compensar la diferencia de altura con la plataforma del vehículo.</li>
        <li><strong>Zona de Recepción y Control de Calidad:</strong> Área de triaje donde se abren las tarimas, se cotejan los albaranes del transportista, se inspecciona el estado de los empaques y se colocan las etiquetas de código de barras internas.</li>
        <li><strong>Zona de Almacenamiento Masivo (Pulmón / Reserva):</strong> Racks pesados de varios niveles (paletización convencional o Drive-In) donde se guardan las tarimas completas que alimentarán las zonas de preparación.</li>
        <li><strong>Zona de Picking / Preparación de Pedidos:</strong> Estanterías bajas o dinámicas de fácil acceso peatonal donde los operarios recogen unidades sueltas para armar los pedidos de los clientes.</li>
        <li><strong>Zona de Consolidación, Embalaje y Despacho:</strong> Mesas de packing donde se verifican los pedidos con lectores láser, se embalan en cajas, se paletizan con film y se colocan en los andenes de salida listos para el camión de ruta.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-repeat text-primary me-2"></i>2. Flujo en ''U'' vs Flujo en Línea Recta (''I'')</h4>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2">Flujo en Forma de ''U'' (El Más Extendido)</h5>
                <p class="small text-muted mb-0">Los muelles de recepción y despacho se ubican en el <strong>mismo frente del edificio</strong>. Permite compartir el patio de maniobras de camiones, reutilizar los equipos de carga (montacargas) en ambas labores y facilita la supervisión centralizada de las operaciones.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-success mb-2">Flujo en Línea Recta (''I'')</h5>
                <p class="small text-muted mb-0">La recepción está en un extremo del almacén y el despacho en el extremo opuesto. Se utiliza en plantas de producción o empresas con volúmenes gigantescos para evitar cualquier cruce o congestión de mercancía en un solo patio.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-geo-alt-fill text-primary me-2"></i>3. Nomenclatura Estándar de Ubicaciones en Racks</h4>
    <p>Para que cualquier operario nuevo encuentre un tornillo en una bodega de 10.000 artículos en menos de 20 segundos, cada hueco del rack cuenta con una coordenada alfanumérica única (ej: <code>P04-M08-N03-P02</code>):</p>
    <ul>
        <li><code>P04</code> ➔ Pasillo número 4.</li>
        <li><code>M08</code> ➔ Módulo o tramo número 8 dentro de ese pasillo.</li>
        <li><code>N03</code> ➔ Nivel o altura 3 de la estantería (contando de abajo hacia arriba).</li>
        <li><code>P02</code> ➔ Posición 2 en la bandeja.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ubicar productos de altísima rotación en el fondo del almacén:</strong> Los productos de mayor venta (Categoría A) deben ubicarse obligatoriamente lo más cerca posible de la zona de despacho para acortar los viajes diarios de los operarios.</li>
        <li><strong>Obstruir los pasillos de tránsito con mercancía ''temporal'':</strong> Dejar tarimas apoyadas en los pasillos principales bloquea el paso de los montacargas y es la causa principal de accidentes por colisión y caídas de mercancía.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Están los pasillos y zonas operativas claramente señalizados con líneas amarillas en el piso?</li>
            <li>¿Ubicaste los productos de mayor rotación cerca de las zonas de consolidación y despacho?</li>
            <li>¿Cada ubicación en los racks cuenta con su etiqueta de código de barras visible y legible?</li>
        </ul>
    </div>
</div>', 'Conoce la arquitectura funcional de un centro de distribución: flujo en ''U'' vs flujo en línea recta (''I''), muelles de recepción, áreas de almacenamiento masivo y zonas de consolidación de envíos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (99, 99, 'El Modelo del Lote Económico de Compra (EOQ - Cantidad Óptima)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-balance fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">La Tensión Sagrada: ¿Pedir Mucho y Poco Frecuente, o Pedir Poco y Seguido?</h5>
            <p class="mb-0 small">Si pides camiones llenos una vez al año, ahorras en fletes pero te arruinas pagando bodegas gigantes y mercancía dañada. Si pides una cajita cada dos días, el flete y la burocracia de facturación devorarán tus ganancias. El modelo EOQ encuentra el punto de equilibrio exacto.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/ywgGvFw6SDo" title="Métodos de Inventario PEPS, UEPS y Promedio Ponderado" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Los Dos Costos Contrapuestos del Inventario</h4>
    <p>Para determinar cuánto comprar en cada pedido, los directores de logística analizan el conflicto entre dos fuerzas financieras:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-danger mb-2"><i class="bi bi-box-arrow-in-down me-2"></i>Costo de Mantener / Almacenar (Holding Cost - H)</h5>
                <p class="small text-muted mb-2">Crece de forma directamente proporcional a la cantidad de stock acumulado en bodega:</p>
                <ul class="small mb-0">
                    <li>Alquiler del metro cuadrado de almacén y energía de refrigeración.</li>
                    <li>Seguros contra incendios y robos.</li>
                    <li>Costo de oportunidad del capital financiero inmovilizado.</li>
                    <li>Riesgo de mermas, caducidades y obsolescencia tecnológica.</li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2"><i class="bi bi-truck me-2"></i>Costo de Ordenar / Pedir (Ordering Cost - S)</h5>
                <p class="small text-muted mb-2">Costo administrativo fijo generado cada vez que se emite una orden de compra:</p>
                <ul class="small mb-0">
                    <li>Flete fijo del camión y peajes.</li>
                    <li>Mano de obra de cotización, emisión de OC y liquidación contable.</li>
                    <li>Tiempo de descarga, conteo físico e inspección de calidad en muelle.</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator-fill text-primary me-2"></i>2. La Fórmula del Lote Económico de Pedido (EOQ)</h4>
    <p>Formulado por Ford Whitman Harris, el modelo <strong>EOQ (Economic Order Quantity)</strong> calcula el tamaño de lote que minimiza la suma de ambos costos:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <code class="fs-6 fw-bold">EOQ = √ [ (2 × Demanda Anual D × Costo de Pedido S) / Costo Unitario de Almacenamiento H ]</code>
    </div>
    <p class="small text-muted">Al graficar ambas curvas, el punto exacto donde la curva del costo de ordenar se cruza con la curva del costo de almacenamiento representa el <strong>Costo Total Mínimo</strong> de operación logística.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-cash-coin text-success me-2"></i>3. Métodos de Valuación de Existencias (FIFO vs Promedio Ponderado)</h4>
    <p>En economías inflacionarias o con variación de precios internacionales, elegir el método contable de valuación impacta directamente en el pago de impuestos:</p>
    <ul>
        <li><strong>Promedio Ponderado (PMP):</strong> Cada vez que entra una compra a un precio distinto, se recalcula el costo unitario medio: <code>Costo Medio = Valor Total en Dinero / Cantidad Total de Unidades</code>. Es el método más estable y extendido en América Latina.</li>
        <li><strong>PEPS / FIFO:</strong> El costo del producto vendido se calcula al precio del lote más antiguo. En inflación, muestra utilidades artificialmente altas que aumentan el pago de impuestos sobre la renta.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Comprar lotes gigantescos solo por obtener un pequeño descuento por volumen:</strong> Si el proveedor te ofrece un 5% de descuento por comprar 5.000 unidades en vez de 500, pero la mercancía ocupará tu almacén durante dos años pagando seguros y arriesgando caducidades, el costo financiero superará con creces el descuento del 5%.</li>
        <li><strong>Ignorar la vida útil del producto al aplicar la fórmula EOQ:</strong> La fórmula matemática del EOQ puede decir que el lote óptimo es de 1.000 unidades, pero si el producto vence en 60 días y tu demanda bimestral es de solo 300 unidades, debes respetar la caducidad por encima del cálculo matemático puro.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Calculaste el costo de almacenamiento anual incluyendo seguros, mermas y costo de capital?</li>
            <li>¿Utilizas el modelo EOQ para balancear los fletes de transporte contra el costo de bodega?</li>
            <li>¿Aplicas el método de Promedio Ponderado de forma consistente en el software contable?</li>
        </ul>
    </div>
</div>', 'Equilibra los dos costos opuestos de la logística: Costo de Mantener Inventario (Holding Cost) vs Costo de Pedir (Ordering Cost). Domina la fórmula matemática del Lote Económico (EOQ) de Ford Harris.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (250, 250, 'Presentación de Resultados a la Gerencia: Claridad, Métricas y Decisiones', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-clipboard2-data-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">El Resumen Ejecutivo: La Regla de la Página Única</h5>
            <p class="mb-0 small">Los directores y gerentes generales no tienen tiempo para leer informes de 80 páginas llenos de rodeos. Un asistente administrativo de alto nivel sintetiza el pulso financiero y operativo de la empresa en una sola página contundente.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/dzh7faTkHCk" title="Diseño de Informes Ejecutivos y Tableros de Control" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Estructura Estándar de un Informe Ejecutivo (One-Pager)</h4>
    <p>Todo informe dirigido al comité de dirección debe organizarse en 4 bloques visuales limpios:</p>
    <ol>
        <li><strong>Encabezado Institucional:</strong> Fecha, autor, departamento y objetivo del reporte en una sola línea (ej: <em>''Balance Operativo y Financiero - Cierre Tercer Trimestre 2026''</em>).</li>
        <li><strong>Panel de Métricas Clave (KPIs):</strong> 4 tarjetas destacadas con los números sagrados del mes (Ventas Reales vs Meta Presupuestaria, Margen Bruto %, Cobranza Efectiva y Saldo en Bancos).</li>
        <li><strong>Análisis de Variaciones Significativas:</strong> Explicación concisa de las desviaciones mayores al 5% (ej: <em>''Los costos de transporte aumentaron un 8% debido al alza de tarifas de fletes interurbanos''</em>).</li>
        <li><strong>Plan de Acción y Recomendaciones Concretas:</strong> Propuestas operativas con responsable y fecha límite para corregir las desviaciones observadas.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-cash-stack text-success me-2"></i>2. Conceptos Financieros Básicos que Todo Asistente Debe Dominar</h4>
    <p>Para hablar con solvencia con la gerencia, se deben dominar las líneas maestras de un estado financiero:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <div class="font-monospace small">
            <strong>(+) Ingresos Operativos Netos (Ventas Totales sin IVA)</strong><br />
            <strong>(-) Costo de Ventas (Costo de adquisición de la mercancía vendida)</strong><br />
            <span class="text-primary fw-bold">(=) Utilidad Bruta (Gross Profit)</span><br /><br />
            <strong>(-) Gastos Operativos de Administración y Ventas (Sueldos, alquileres, servicios, publicidad)</strong><br />
            <span class="text-success fw-bold">(=) EBITDA (Utilidad antes de Intereses, Impuestos, Depreciaciones y Amortizaciones)</span><br /><br />
            <strong>(-) Depreciaciones, Amortizaciones e Intereses Financieros</strong><br />
            <strong>(-) Impuesto sobre la Renta (ISLR)</strong><br />
            <span class="text-danger fw-bold">(=) Utilidad Neta (El dinero limpio que queda para los accionistas)</span>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Presentar datos crudos sin interpretación cualitativa:</strong> Pegar una tabla con 500 números sin explicar qué significan es una pérdida de tiempo. La labor del analista es resaltar: <em>''La sucursal Norte creció un 14% impulsada por la venta de la nueva línea de calzado''</em>.</li>
        <li><strong>Ocultar malas noticias o errores operativos en el reporte:</strong> Si las ventas cayeron o hubo una pérdida de inventario, presentarlo con honestidad profesional y con un plan correctivo inmediato genera mucha más confianza gerencial que intentar maquillar los números.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Sintetizaste los hallazgos principales en una sola página con formato ejecutivo?</li>
            <li>¿Comparaste las cifras reales del mes contra el presupuesto aprobado y el mes anterior?</li>
            <li>¿Acompañaste cada desviación negativa de una propuesta de acción correctiva concreta?</li>
        </ul>
    </div>
</div>', 'Aprende a sintetizar datos operativos en reportes gerenciales de 1 página: Estado de Resultados simplificado (EBITDA), flujo de caja libre, indicadores de gestión y recomendaciones accionables.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (262, 262, 'Clasificar, Ordenar, Limpiar, Estandarizar y Disciplina en Bodega', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-check-circle-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Metodología 5S: La Base de la Productividad Japonesa</h5>
            <p class="mb-0 small">Un almacén desordenado, sucio y con herramientas tiradas en el piso es la antesala de pérdidas millonarias y accidentes laborales. Las 5S transforman el caos en un entorno de trabajo limpio, seguro y ultraeficiente.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/7qLRjtCFpig" title="METODOLOGIA 5S - EXPLICADA EN 1 MINUTO" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Los Cinco Pilares de las 5S en la Bodega</h4>
    <p>Desarrollada por Toyota en Japón, la metodología <strong>5S</strong> se implementa en secuencia rigurosa:</p>
    <div class="row g-2 mb-4">
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>1. Seiri (Clasificar)</strong><br /><span class="text-muted">Separar lo necesario de lo innecesario y desechar lo inservible.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>2. Seiton (Ordenar)</strong><br /><span class="text-muted">Un lugar para cada cosa y cada cosa en su lugar.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>3. Seiso (Limpiar)</strong><br /><span class="text-muted">Limpiar e inspeccionar para detectar fugas y daños a tiempo.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>4. Seiketsu (Estandarizar)</strong><br /><span class="text-muted">Crear protocolos visuales y listas de chequeo diarias.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>5. Shitsuke (Disciplina)</strong><br /><span class="text-muted">Hacer del orden un hábito voluntario mediante auditorías.</span></div></div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tag-fill text-danger me-2"></i>2. La Campaña de Tarjetas Rojas (Red Tag Campaign)</h4>
    <p>Para iniciar la primera S (Seiri), el equipo recorre el almacén pegando una <strong>Tarjeta Roja</strong> a cualquier objeto sospechoso de ser inútil (cajas rotas, herramientas viejas, tarimas rajadas, repuestos obsoletos de máquinas dadas de baja):</p>
    <ul>
        <li>Todo objeto marcado se traslada a la <em>''Zona de Cuarentena de Tarjetas Rojas''</em> durante 15 días.</li>
        <li>Si en ese lapso ningún departamento reclama el objeto con justificación técnica, se procede a su descarte formal, donación o venta como chatarra, liberando valiosos metros cuadrados en la bodega.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tools text-primary me-2"></i>3. Gestión Visual y Paneles Sombra (Shadow Boards)</h4>
    <p>Para la segunda S (Seiton), el almacén aplica el principio de <strong>Gestión Visual</strong>:</p>
    <ul>
        <li><strong>Paneles Sombra:</strong> Paneles metálicos de herramientas donde está pintada la silueta exacta de cada llave, cutter o cinta. Si falta un instrumento, el hueco vacío avisa de inmediato a todo el equipo qué herramienta no ha sido devuelta a su sitio.</li>
        <li><strong>Líneas de Aparcamiento para Maquinaria:</strong> Zonas delimitadas en el suelo para estacionar transpaletas y cargadores de baterías al final del turno.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Limpieza con una Jornada de Aseo Aislada:</strong> Hacer una limpieza profunda una vez al año antes de la auditoría y dejar que el desorden regrese a la semana siguiente no es aplicar 5S. Las 5S son un estándar diario que se mantiene dedicando los últimos 10 minutos de cada turno a dejar el puesto impecable.</li>
        <li><strong>Falta de Auditorías Periódicas con Puntaje:</strong> Si no se realizan auditorías semanales con una lista de chequeo y un puntaje público exhibido en la cartelera del almacén, el personal perderá el compromiso con el mantenimiento del orden.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Eliminaste del almacén objetos obsoletos mediante la campaña de tarjetas rojas?</li>
            <li>¿Regresas las herramientas a su silueta designada en el panel sombra al finalizar la tarea?</li>
            <li>¿Dedicas los últimos 10 minutos del turno a limpiar y ordenar tu estación de trabajo?</li>
        </ul>
    </div>
</div>', 'Aplica la metodología japonesa de calidad total 5S en la bodega: Seiri (Descarte), Seiton (Orden), Seiso (Limpieza), Seiketsu (Estandarización) y Shitsuke (Disciplina y Auditorías periódicas).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (254, 254, 'La Empresa como Agente de Impacto Positivo Comunitario y Ambiental', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-globe-americas fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">El Éxito Empresarial Debe Beneficiar a la Sociedad</h5>
            <p class="mb-0 small">Una empresa próspera no puede subsistir en una sociedad que fracasa. Conoce cómo la sostenibilidad ecológica, la equidad laboral y el compromiso con la comunidad generan valor sostenible a largo plazo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/CU5CP_JKcfw" title="Responsabilidad social de la empresa y sus ámbitos de actuación ⊛ | Economía de la empresa 29#" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-tree text-success me-2"></i>1. El Modelo de la Triple Cuenta de Resultados (Triple Bottom Line)</h4>
    <p>Atrás quedó la visión del siglo XX donde el único fin de la empresa era maximizar el dividendo a los accionistas sin importar las externalidades causadas. Hoy las organizaciones líderes se evalúan bajo tres dimensiones interconectadas:</p>
    <ul>
        <li><strong>Económica (Profit):</strong> Generación de riqueza, rentabilidad sostenible, pago puntual de salarios justos e impuestos para el desarrollo del país.</li>
        <li><strong>Social (People):</strong> Trato digno a los trabajadores, oportunidades reales de crecimiento profesional, inclusión, seguridad industrial y relaciones de mutuo beneficio con las comunidades locales vecinas.</li>
        <li><strong>Ambiental (Planet):</strong> Reducción de la huella de carbono, eficiencia en el consumo de energía y agua, reciclaje de materiales y gestión responsable de residuos operativos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-award text-success me-2"></i>2. Criterios ESG (Environmental, Social and Governance)</h4>
    <p>Los fondos de inversión globales y las grandes corporaciones exigen actualmente a sus proveedores el cumplimiento de estándares ESG verificables:</p>
    <ol>
        <li><strong>E (Medio Ambiente):</strong> Programas de economía circular, transición a fuentes de energía limpia y eliminación progresiva de plásticos de un solo uso en las operaciones.</li>
        <li><strong>S (Social):</strong> Derechos humanos en la cadena de suministro, erradicación total del trabajo infantil en proveedores agrícolas o textiles, y capacitación continua de la fuerza laboral.</li>
        <li><strong>G (Gobernanza):</strong> Estructuras de gobierno corporativo transparentes, juntas directivas independientes, auditorías financieras externas y tolerancia cero contra la corrupción.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. El Peligro del ''Greenwashing'' (Ecoblanqueo)</h4>
    <p>El greenwashing ocurre cuando una empresa invierte más dinero en publicidad engañosa haciéndose pasar por ecológica que en prácticas reales de mitigación ambiental:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small"><strong>Ejemplo Real:</strong> Una cadena hotelera que coloca carteles pidiendo a los huéspedes no lavar las toallas ''para salvar al planeta'', cuando su verdadero motivo es reducir la factura de lavandería sin implementar ninguna medida real de tratamiento de aguas residuales ni energía solar.</p>
    </div>
    <p>Los consumidores modernos y las redes sociales descubren rápidamente estas inconsistencias, provocando crisis de reputación masivas y boicots comerciales.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir RSE con Filantropía Asistencialista:</strong> Donar dinero esporádico para caridad mientras se pagan sueldos por debajo de la ley a los empleados no es responsabilidad social; la RSE empieza por casa con el bienestar laboral.</li>
        <li><strong>Ignorar el impacto local de las operaciones:</strong> No coordinar con los líderes comunitarios el tránsito de camiones pesados o ruidos nocturnos de la fábrica, generando hostilidad vecinal.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Apagas las luces y equipos de cómputo al finalizar tu jornada en la oficina?</li>
            <li>¿Participas activamente en los programas de voluntariado y reciclaje de tu organización?</li>
            <li>¿Verificas que tus proveedores cumplan con estándares de dignidad laboral y legalidad?</li>
        </ul>
    </div>
</div>', 'Descubre el modelo del Triple Impacto (Personas, Planeta y Beneficios) y cómo las políticas ESG influyen en la valoración y reputación corporativa moderna.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (265, 265, 'El Modelo de Marshall Rosenberg y la Técnica del Feedback SBI (Situación, Conducta, Impacto)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-chat-heart-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">La Asertividad es el Puente entre la Sumisión y la Agresividad</h5>
            <p class="mb-0 small">El 60% de los problemas en las empresas se originan por una mala comunicación interna. Aprende a decir que no con respeto, plantear quejas con elegancia y retroalimentar con el método SBI.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/Gqod-kdSOJk" title="Mapa mental: La Comunicación No Violenta de Marshall Rosenberg" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-flower1 text-primary me-2"></i>1. Los 4 Pasos de la Comunicación No Violenta (CNV)</h4>
    <p>Desarrollada por el psicólogo Marshall Rosenberg, la CNV transforma conversaciones potencialmente destructivas en puentes de colaboración mutua:</p>
    <ul>
        <li><strong>1. Hechos Observables (Sin Juicios ni Etiquetas):</strong> Describir lo que ocurrió como una cámara de video, sin interpretaciones ofensivas. (<em>''En las últimas dos semanas has llegado 25 minutos tarde a tres reuniones''</em> en lugar de <em>''Eres un irresponsable y no te importa el proyecto''</em>).</li>
        <li><strong>2. Expresión del Sentimiento Propio:</strong> Expresar cómo te afecta la situación en primera persona, sin acusaciones (<em>''Me siento preocupado y presionado con los plazos de entrega''</em>).</li>
        <li><strong>3. Identificación de la Necesidad:</strong> Explicar el valor subyacente que está en juego (<em>''Porque necesitamos coordinar los cambios antes de que el cliente revise la plataforma''</em>).</li>
        <li><strong>4. Petición Concreta y Accionable:</strong> Solicitar una acción específica en positivo (<em>''¿Podrías comprometerte a conectarte 5 minutos antes en las reuniones de los martes y jueves?''</em>).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-left-right text-primary me-2"></i>2. El Modelo SBI para Dar Feedback Profesional (Situación - Conducta - Impacto)</h4>
    <p>Desarrollado por el Center for Creative Leadership (CCL), es el estándar de oro en corporaciones multinacionales:</p>
    <ol>
        <li><strong>Situation (Situación Temporal y Espacial):</strong> <em>''Ayer durante la presentación del informe comercial ante la gerencia...''</em></li>
        <li><strong>Behavior (Conducta Específica):</strong> <em>''...interrumpiste al analista en tres ocasiones antes de que pudiera mostrar las gráficas de rentabilidad...''</em></li>
        <li><strong>Impact (Impacto Medible):</strong> <em>''...lo cual hizo que la gerencia percibiera descoordinación interna y el analista se sintiera desvalorizado frente a los directores''</em>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La trampa del ''Elogio Sandwich'' mal ejecutado:</strong> Dar un halago falso, meter una crítica devastadora en el medio y cerrar con otro halago vacío. Hace que los colaboradores sientan desconfianza permanente hacia los cumplidos.</li>
        <li><strong>Dar retroalimentación correctiva en público:</strong> La regla sagrada del liderazgo es: <em>Felicita en público, corrige siempre en estricto privado</em>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Separas los hechos objetivos de tus interpretaciones emocionales al hacer una crítica?</li>
            <li>¿Corriges a tus compañeros o subordinados en privado y nunca frente a clientes o colegas?</li>
            <li>¿Estructuras tus conversaciones difíciles siguiendo el modelo Situación - Conducta - Impacto?</li>
        </ul>
    </div>
</div>', 'Aprende a expresar desacuerdos con firmeza y elegancia: observación vs juicio, necesidades insatisfechas y la estructura SBI para corregir errores sin humillar.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (257, 257, 'Desescalada de Conflictos con el Método LAST y Control Emocional', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-fill-exclamation fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Furia del Cliente No es Personal, es Frustración Operativa</h5>
            <p class="mb-0 small">Cuando un cliente grita o reclama airadamente en el mostrador, no te está atacando a ti como individuo; está desahogando su impotencia ante una promesa rota por la empresa. Aprende el método LAST para desactivar la hostilidad en menos de 3 minutos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/nYEU-ZyfNPg" title="Cómo manejar clientes difíciles / Jorge Martínez Felicidad" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-cpu text-primary me-2"></i>1. La Psicología de la Desescalada</h4>
    <p>El cliente enojado se encuentra en ''secuestro amigdalino'': su cerebro emocional ha tomado el control y no puede procesar explicaciones lógicas ni normativas burocráticas hasta que haya liberado su adrenalina:</p>
    <ul>
        <li><strong>Nunca digas ''Cálmese'' o ''Tranquilícese'':</strong> Esta frase tiene el efecto psicológico opuesto; el cliente siente que se está invalidando su molestia y su nivel de ira se multiplica por diez.</li>
        <li><strong>Mantén el Tono de Voz Más Bajo y Pausado:</strong> Cuando una persona grita y la otra responde con voz calmada, grave y a ritmo moderado, se activa el fenómeno neurobiológico del reflejo especular, obligando inconscientemente al agresor a modular su volumen.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-tools text-primary me-2"></i>2. El Protocolo LAST (Listen, Apologize, Solve, Thank)</h4>
    <p>Utilizado por cadenas de hospitalidad mundial como The Ritz-Carlton y Disney:</p>
    <ol>
        <li><strong>L - Listen (Escuchar con Atención Plena):</strong> Deja que descargue todo su desahogo sin discutir. Muestra empatía genuina con el rostro y la postura.</li>
        <li><strong>A - Apologize (Disculparse en Nombre de la Empresa):</strong> No busques culpables internos (<em>''Eso fue culpa del despachador que es un incompetente''</em>). Una disculpa institucional sincera calma la indignación: <em>''Lamento sinceramente los inconvenientes y el retraso que esta falla técnica le ha ocasionado en su jornada de trabajo''</em>.</li>
        <li><strong>S - Solve (Resolver Proactivamente):</strong> Ofrece una solución viable inmediata o alternativas claras con plazos específicos: <em>''Lo que voy a hacer de inmediato por usted es coordinar el reemplazo del equipo hoy mismo antes de las 4:00 pm''</em>.</li>
        <li><strong>T - Thank (Agradecer el Feedback):</strong> Agradece que haya manifestado el problema: <em>''Muchas gracias por hacernos ver este error; nos ayuda a mejorar nuestros procesos para que esto no vuelva a ocurrir''</em>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Discutir o ponerse a la defensiva con el cliente:</strong> Ganar una discusión técnica a un cliente furioso equivale a perder al cliente y a toda su red de contactos para siempre.</li>
        <li><strong>Escudarse en ''Políticas de la Empresa'' sin dar soluciones:</strong> Decirle fríamente <em>''Es política de la casa y no se puede hacer nada''</em> es la mayor causa de escalada de agresiones físicas y quejas legales contra negocios.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Evitas estrictamente la palabra ''Cálmese'' ante usuarios alterados?</li>
            <li>¿Modulas tu voz deliberadamente a un tono pausado y sereno durante discusiones?</li>
            <li>¿Aplicas los 4 pasos del método LAST (Escuchar, Disculpar, Resolver, Agradecer)?</li>
        </ul>
    </div>
</div>', 'Domina el protocolo psicológico para calmar clientes furiosos en el mostrador: cómo aplicar Escuchar, Disculparse, Resolver y Agradecer sin tomar los ataques como algo personal.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (126, 126, 'El Proceso de Delegación en 5 Pasos y los 7 Niveles de Delegación de Jurgen Appelo', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-share-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Si No Sabes Delegar, Te Convertirás en el Cuello de Botella de Tu Empresa</h5>
            <p class="mb-0 small">Muchos supervisores trabajan 14 horas al día agotados mientras sus colaboradores esperan de brazos cruzados porque ''nadie lo hace como yo''. Aprende a delegar con control y a formar líderes autónomos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/SweH787f9bM" title="¿Cómo DELEGAR sin perder el control? El proceso en 5 pasos para soltar tareas" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-arrow-repeat text-primary me-2"></i>1. El Ciclo de Delegación en 5 Pasos</h4>
    <p>Delegar no es ''deshacerse de trabajo aburrido''; es un proceso pedagógico estructurado para transferir responsabilidad y poder de decisión:</p>
    <ul>
        <li><strong>Paso 1: Definir con Claridad el Resultado Esperado (El ''Qué'' y ''Para Qué''):</strong> Explicar el objetivo final tangible y el impacto en el negocio, dejando libertad en el ''cómo'' se ejecuta siempre que se respeten los estándares éticos y de calidad.</li>
        <li><strong>Paso 2: Asignar al Colaborador Adecuado:</strong> Evaluar las habilidades previas y la carga de trabajo actual de la persona seleccionada.</li>
        <li><strong>Paso 3: Otorgar los Recursos y la Autoridad Formal Necesaria:</strong> No puedes exigir resultados si no le das al colaborador acceso a los presupuestos, software, claves y el respaldo formal ante otros departamentos.</li>
        <li><strong>Paso 4: Establecer Hitos de Revisión Periódicos (Checkpoints):</strong> Fijar fechas intermedias de revisión para corregir desviaciones a tiempo sin caer en la asfixia del control diario.</li>
        <li><strong>Paso 5: Evaluación Final y Reconocimiento Público:</strong> Analizar las lecciones aprendidas y otorgar todo el crédito del éxito al colaborador que ejecutó la tarea.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-sliders text-primary me-2"></i>2. Los 7 Niveles de Delegación (Management 3.0)</h4>
    <p>Jurgen Appelo demostró que la delegación no es blanco o negro, sino un dial gradual de 7 niveles de empoderamiento:</p>
    <ol>
        <li><strong>1. Decir (Tell):</strong> El líder decide y comunica la decisión al equipo.</li>
        <li><strong>2. Vender (Sell):</strong> El líder decide, pero explica las razones para convencer al equipo.</li>
        <li><strong>3. Consultar (Consult):</strong> El líder pide opiniones antes de tomar la decisión final.</li>
        <li><strong>4. Acordar (Agree):</strong> Líder y equipo toman una decisión conjunta por consenso.</li>
        <li><strong>5. Aconsejar (Advise):</strong> El equipo decide, pero el líder da sugerencias si se las solicitan.</li>
        <li><strong>6. Preguntar (Inquire):</strong> El equipo decide de forma autónoma y luego informa al líder.</li>
        <li><strong>7. Delegar Plenamente (Delegate):</strong> El equipo tiene autonomía absoluta sin necesidad de reportar detalles.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Delegación Inversa (El Mono en la Espalda):</strong> Permitir que un colaborador te devuelva un problema diciendo <em>''Jefe, no sé cómo resolver esto, dígame usted qué hago''</em>. El líder debe responder: <em>''Analízalo y tráeme dos opciones viables con sus pros y contras a las 3:00 pm para revisarlas juntos''</em>.</li>
        <li><strong>Quitar la tarea ante la primera dificultad:</strong> Arrebatarle el trabajo al empleado diciendo <em>''Quítate que es más rápido si lo hago yo mismo''</em> destruye para siempre su iniciativa profesional.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aclaras el nivel de autonomía concedido según los 7 niveles de Management 3.0?</li>
            <li>¿Rechazas la delegación inversa exigiendo propuestas de solución antes de responder?</li>
            <li>¿Fijas fechas intermedias de revisión para no enterarte de los desvíos el día de entrega?</li>
        </ul>
    </div>
</div>', 'Aprende a delegar resultados en lugar de métodos: cómo definir criterios de aceptación claros, evitar el retrabajo y liberar tiempo para el trabajo estratégico.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (228, 228, 'De la Cotización a la Factura de Deudores y Cobro', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cash-stack fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">El Circuito ''Order to Cash'': El Flujo de Ingresos de la Empresa</h5>
            <p class="mb-0 small">En SAP B1, vender no es simplemente escribir una factura. Cada paso del circuito comercial cumple una función de control operativo, reserva de existencias y devengo contable inalterable.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/zA9f721dDj0" title="Fundamentos SAP Business One - Crear circuito de ventas" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Flujo Documental Estandarizado de Ventas</h4>
    <p>El ciclo comercial completo en SAP B1 se compone de 5 documentos encadenados mediante el botón <strong>''Copiar a'' (Copy To)</strong> o <strong>''Copiar de'' (Copy From)</strong>:</p>
    <div class="row g-2 mb-4">
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>1. Oferta de Venta</strong><br /><span class="text-muted">Cotización previa al cliente (no mueve stock ni genera contabilidad).</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>2. Orden de Venta</strong><br /><span class="text-muted">Formaliza el pedido. <strong>Aumenta el Stock Comprometido</strong>.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>3. Entrega</strong><br /><span class="text-muted">Albarán de despacho. <strong>Rebaja el stock físico</strong> del almacén.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>4. Factura de Clientes</strong><br /><span class="text-muted">Genera el asiento contable de cobro, IVA y costo de venta.</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>5. Pago Recibido</strong><br /><span class="text-muted">Entrada de dinero a caja o banco, cancelando la deuda del cliente.</span></div></div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator text-primary me-2"></i>2. La Ecuación Sagrada de Inventario en SAP</h4>
    <p>Para no prometer mercancía que ya está comprometida con otros clientes, SAP calcula tres cifras en tiempo real para cada artículo:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <code class="fs-6 fw-bold">Stock Disponible = En Stock Físico - Comprometido (Órdenes de Venta) + Solicitado (Órdenes de Compra)</code>
    </div>
    <p class="small text-muted">Si tienes 100 unidades físicas en la estantería del almacén pero tienes 3 Órdenes de Venta abiertas por 80 unidades en total, tu stock disponible para nuevos clientes es de apenas <strong>20 unidades</strong>. Si intentas emitir una orden por 30 unidades, SAP emitirá una advertencia de déficit de inventario.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-link-45deg text-primary me-2"></i>3. Uso de ''Copiar a'' y Trazabilidad Documental</h4>
    <p>En SAP nunca se digita un documento desde cero si ya existe el documento anterior. Desde la Orden de Venta aprobada, el operador hace clic en el botón inferior <strong>Copiar a ➔ Entrega</strong>:</p>
    <ul>
        <li>SAP transfiere automáticamente los códigos de artículos, cantidades, precios unitarios, descuentos autorizados y datos de despacho sin ningún error de transcripción.</li>
        <li>Si el cliente solo recibe una entrega parcial (ej: 60 de las 100 unidades solicitadas), se modifica la cantidad en la Entrega a 60. La Orden de Venta original permanecerá con estado <em>Abierto</em> por las 40 unidades restantes hasta que se realice el segundo despacho.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear la Factura de Clientes directamente sin emitir la Entrega previa:</strong> En empresas de retail o manufactura con almacenes físicos, saltarse la Entrega provoca que el departamento de logística no reciba la orden de picking para armar el bulto, generando retrasos y discordancias entre lo facturado y lo despachado.</li>
        <li><strong>Cancelar una Entrega una vez que ya ha sido facturada:</strong> No es posible cancelar una entrega cerrada. Si el cliente devuelve la mercancía después de facturada, el procedimiento legal en SAP es emitir una <strong>Nota de Crédito de Clientes (Credit Memo)</strong> que rebaja la deuda contable y reingresa el producto al inventario.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste el saldo de Stock Disponible antes de confirmar la Orden de Venta al cliente?</li>
            <li>¿Utilizaste la función ''Copiar a'' para preservar la trazabilidad y alimentar el Mapa de Relaciones?</li>
            <li>¿Comprobaste que la Factura de Clientes refleje la lista de precios y la alícuota de impuesto correcta?</li>
        </ul>
    </div>
</div>', 'Domina el circuito comercial completo: Oferta de Ventas, Orden de Venta (Sales Order), Entrega (Delivery), Factura de Clientes y Pagos Recibidos. Comprende el impacto en el Stock Comprometido y disponible.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (260, 260, 'Picking por Olas, Lotes, Embalaje Seguro y Paletizado con Film', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-box2-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Picking y Packing: El Corazón Operativo de la Logística</h5>
            <p class="mb-0 small">El picking representa más del 55% de los costos operativos totales de un almacén. Dominar las rutas de recolección y las técnicas de embalaje profesional evita roturas en el transporte y reclamos de clientes insatisfechos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/C4VwS2_GtOc" title="¿Qué es el Picking y el Packing? Guía de Almacén" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Modalidades Avanzadas de Picking</h4>
    <p>Dependiendo del volumen de pedidos de la empresa, el jefe de almacén asigna la modalidad de recolección más eficiente:</p>
    <ul>
        <li><strong>Picking Pedido a Pedido (Discreto):</strong> El operario toma una sola orden de cliente, recorre el almacén recogiendo los artículos y regresa a la mesa de empaque. Es sencillo pero ineficiente para comercio electrónico de alta demanda.</li>
        <li><strong>Picking por Lotes (Batch Picking):</strong> El operario recoge simultáneamente los artículos de 10 o 15 pedidos distintos en un solo viaje por el pasillo (por ejemplo, recoge 40 unidades del artículo A en una sola parada). Posteriormente, en la mesa de consolidación, clasifica las unidades en los casilleros de cada cliente.</li>
        <li><strong>Picking por Zonas (Zone Picking):</strong> El almacén se divide en sectores (ej: Zona Refrigerada, Zona Químicos, Zona Secos). Cada operario permanece en su zona y recolecta únicamente los artículos de su área, pasando la caja al siguiente sector mediante fajas transportadoras (método <em>Pick and Pass</em>).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-archive-fill text-primary me-2"></i>2. La Técnica Profesional del Packing y Paletizado con Film</h4>
    <p>Un mal embalaje provoca que el producto llegue aplastado o roto a manos del cliente. El auxiliar logístico debe aplicar las reglas de protección física:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <h6 class="fw-bold text-dark mb-2">Protocolo de Paletizado Seguro (Pallet Wrapping)</h6>
        <ol class="small mb-0">
            <li><strong>Distribución del Peso:</strong> Colocar las cajas más pesadas y rígidas en la base de la tarima (pallet). Las cajas livianas y frágiles van arriba del todo. Nunca apilar mercancía en forma de pirámide; la carga debe formar un cubo perfecto.</li>
            <li><strong>Traba de Cajas (Patrón Entrelazado):</strong> Alternar el sentido de las cajas entre capa y capa (como los ladrillos de una pared) para que la tarima tenga estabilidad estructural y no se abra en las curvas del camión.</li>
            <li><strong>Aplicación de Film Estirable (Stretch Film):</strong> Amarrar el plástico a la base de madera de la tarima, dar 3 o 4 vueltas de tensión firme en la base, subir traslapando el plástico al 50% ejerciendo tensión constante, y rematar con 3 vueltas en la corona superior para blindar la carga contra humedad y polvo.</li>
        </ol>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-upc-scan text-success me-2"></i>3. Verificación con Lectores Láser de Radiofrecuencia (RF)</h4>
    <p>Para erradicar el error humano de entregar una talla equivocada o un producto diferente, el operario escanea con la terminal móvil (colector de datos) el código de barras de la ubicación en el rack, y luego el código EAN del producto. Si el operario toma el SKU incorrecto, el lector emite un pitido de advertencia en rojo bloqueando la pantalla hasta que tome el artículo correcto.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar espacios vacíos dentro de las cajas de despacho sin material de relleno:</strong> Si envías una caja con huecos de aire, al apilar otra caja encima durante el transporte, la caja inferior se aplastará dañando el producto. Rellena siempre los huecos con papel kraft, bolsas de aire o plástico de burbujas.</li>
        <li><strong>Permitir que las cajas sobresalgan del borde de la tarima de madera:</strong> Si las cajas sobresalen 5 cm fuera del borde del pallet (overhang), pierden más del 30% de su resistencia al apilamiento y sufrirán rasgaduras al rozar con otros pallets en el camión.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Escanéaste cada código de barras con el colector para validar SKU y cantidad?</li>
            <li>¿Apilaste las cajas pesadas abajo y trabaste las capas para evitar derrumbes?</li>
            <li>¿Aseguraste la carga con film estirable amarrado firmemente a la base de madera del pallet?</li>
        </ul>
    </div>
</div>', 'Domina la operativa de despacho: métodos de picking (pedido a pedido, por lotes, por zonas), uso de terminales de radiofrecuencia (RFID), técnicas de embalaje (packing) y paletizado con film estirable.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (258, 258, 'De Clientes Satisfechos a Promotores Incondicionales de la Marca', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-heart-pulse-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Un Cliente Satisfecho Puede Irse; Un Cliente Fidelizado Regresa Siempre</h5>
            <p class="mb-0 small">Captar un cliente nuevo cuesta entre 5 y 7 veces más que retener a uno existente. Conoce las estrategias de lealtad, los detalles inesperados y las métricas para blindar la base de clientes de tu empresa.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/-hQNp7xh_8c" title="Métricas de Customer Experience | Encuesta.com" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-stars text-primary me-2"></i>1. La Diferencia entre Satisfacción y Fidelización</h4>
    <p>La satisfacción es simplemente cumplir con lo prometido en el contrato básico (entregaste el producto que pagó). La satisfacción no garantiza lealtad: si la competencia ofrece un descuento del 10%, el cliente satisfecho se marchará. La fidelización, en cambio, es un vínculo emocional:</p>
    <ul>
        <li><strong>Fidelidad Afectiva:</strong> El cliente confía ciegamente en la honestidad de la empresa y en el trato humano de su personal, por lo que no cotiza con otros competidores.</li>
        <li><strong>Efecto Embajador de Marca:</strong> Recomienda activamente el negocio a familiares, colegas y socios comerciales de forma espontánea y gratuita.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-magic text-primary me-2"></i>2. La Creación de ''Momentos Wow'' (Overdelivering)</h4>
    <p>El Factor Sorpresa consiste en entregar un valor adicional inesperado que no estaba en el acuerdo explícito y que tiene un costo económico mínimo para el negocio pero un valor percibido gigantesco:</p>
    <ol>
        <li><strong>Personalización Extrema:</strong> Recordar el nombre del cliente habitual, su café preferido o el nombre de su mascota al ingresar a la tienda.</li>
        <li><strong>Agilidad de Respuesta Superior:</strong> Resolver una solicitud prometida para dentro de 48 horas en tan solo 3 horas hábiles con una llamada proactiva.</li>
        <li><strong>El ''Regalo de Cortesía Inesperado'':</strong> Un bombón fino en el empaque de despacho, una muestra gratis de un producto complementario nuevo o una nota manuscrita de agradecimiento.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-graph-up-arrow text-primary me-2"></i>3. Medición Científica de la Lealtad: El Net Promoter Score (NPS)</h4>
    <p>El NPS fue creado por Fred Reichheld de Bain & Company y se basa en una sola pregunta con escala de 0 a 10: <em>''¿Con qué probabilidad recomendaría nuestros servicios a un amigo o colega?''</em>:</p>
    <ul>
        <li><strong>Promotores (9 - 10):</strong> Clientes apasionados que compran con frecuencia y atraen nuevos prospectos.</li>
        <li><strong>Pasivos (7 - 8):</strong> Clientes satisfechos pero vulnerables a ofertas de la competencia.</li>
        <li><strong>Detractores (0 - 6):</strong> Clientes insatisfechos que dañan la marca con comentarios negativos en redes y boca a boca.</li>
    </ul>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3 text-center">
        <code class="fs-6 fw-bold">NPS = (% de Promotores) - (% de Detractores)</code>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Descuidar a los clientes antiguos para buscar nuevos:</strong> Ofrecer grandes promociones exclusivas para clientes nuevos mientras a los clientes leales de hace 5 años se les aumentan las tarifas sin ningún beneficio.</li>
        <li><strong>Programas de puntos excesivamente complejos:</strong> Sistemas de acumulación de puntos donde se requieren millones de compras para canjear un premio insignificante, frustrando a la audiencia.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Llamas a tus clientes habituales por su nombre en cada visita?</li>
            <li>¿Entregas pequeños detalles inesperados que superen la expectativa básica contratada?</li>
            <li>¿Mides periódicamente la probabilidad de recomendación de tus clientes con encuestas NPS?</li>
        </ul>
    </div>
</div>', 'Aprende a superar expectativas con el efecto Wow, implementar tarjetas de fidelización, calcular el Valor de Vida del Cliente (LTV) y medir la lealtad con el NPS.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (252, 252, 'Dilemas Morales en la Oficina y Prevención de Conflictos de Interés', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-lock-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Integridad en los Momentos Decisivos</h5>
            <p class="mb-0 small">La ética consiste en hacer lo correcto incluso cuando nadie nos está observando. Conoce los límites formales del código de conducta y cómo blindar tu reputación profesional.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/v97WAu3ZW7Q" title="Consejos de Ética Profesional y Valores | Sociedad San José" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-journal-text text-primary me-2"></i>1. ¿Qué es un Código de Conducta y Por Qué Existe?</h4>
    <p>El Código de Conducta es el documento jurídico e institucional vinculante que traduce la filosofía moral de la empresa en normativas concretas sobre lo que está permitido y lo que está estrictamente prohibido para todos los colaboradores:</p>
    <ul>
        <li><strong>Fronteras Claras:</strong> Establece regulaciones explícitas sobre el uso de recursos empresariales, relaciones interpersonales, acoso laboral o sexual y honestidad en los informes contables.</li>
        <li><strong>Carácter Vinculante:</strong> En la mayoría de las legislaciones laborales, la firma de recepción del Código de Ética al momento de la contratación faculta a la empresa a rescindir el contrato con justa causa ante infracciones graves.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-person-x text-primary me-2"></i>2. Detección y Gestión de Conflictos de Interés</h4>
    <p>Un conflicto de interés surge cuando los intereses personales, familiares o económicos de un colaborador interfieren (o aparentan interferir) con el juicio objetivo que debe ejercer en beneficio exclusivo de su empleador:</p>
    <ol>
        <li><strong>Regalos, Comisiones y Hospitalidad de Proveedores:</strong> Aceptar obsequios de valor significativo, cenas de lujo o viajes pagados por proveedores que concursan en licitaciones de compras compromete la imparcialidad. La regla de oro corporativa establece rechazar regalos superiores a montos simbólicos (ej. lápices promocionales o calendarios) y reportarlos de inmediato al oficial de cumplimiento.</li>
        <li><strong>Contratación de Familiares y Amigos (Nepotismo):</strong> Contratar empresas de cónyuges, hermanos o amigos cercanos sin una licitación abierta y sin declarar el parentesco es una falta grave que perjudica las finanzas corporativas.</li>
        <li><strong>Uso Indebido de Activos de la Empresa:</strong> Utilizar vehículos corporativos, impresoras, software bajo licencia empresarial o el horario de trabajo pagado para actividades comerciales privadas o negocios particulares.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-primary me-2"></i>3. El Test de la Primera Plana (The Front Page Test)</h4>
    <p>Cuando te encuentres frente a una decisión en una ''zona gris'' donde la ley no es totalmente explícita, los expertos en ética aplicada recomiendan someter la decisión al Test de Warren Buffett:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 fst-italic">"Nunca hagas nada en los negocios que no te sentirías completamente cómodo y orgulloso de ver publicado mañana en la primera plana de tu periódico local, para que lo lean tu cónyuge, tus hijos, tus padres y tus vecinos."</p>
    </div>
    <p>Si la respuesta te genera incomodidad, vergüenza o el deseo de ocultar los detalles, la acción es éticamente inaceptable y debes abstenerte de realizarla.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La falacia de ''Todos lo hacen'':</strong> Justificar pequeñas desviaciones éticas (llevarse papelería a casa, adulterar viáticos o registrar horas extras falsas) alegando que otros colegas también lo hacen.</li>
        <li><strong>No declarar un conflicto de interés a tiempo:</strong> Si tu hermano tiene una empresa de suministros que compite legítimamente por una orden de compra, no declararlo por escrito a Recursos Humanos antes del proceso invalida la licitación y genera sospechas de corrupción.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Has leído completamente el Código de Conducta de tu organización este año?</li>
            <li>¿Declaras por escrito cualquier parentesco o interés económico con proveedores o clientes?</li>
            <li>¿Rechazas cortesías costosas de proveedores que puedan comprometer tu criterio profesional?</li>
        </ul>
    </div>
</div>', 'Aprende a identificar y gestionar situaciones donde los intereses personales chocan con los deberes laborales: regalos de proveedores, favoritismo y pluriempleo.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (152, 152, 'El Verdadero Poder en la Negociación: Tu Mejor Alternativa Fuera de la Mesa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-shaded fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Tu Poder de Negociación Depende de Tu Habilidad para Decir ''No'' y Levantarte de la Mesa</h5>
            <p class="mb-0 small">Nunca vayas a una negociación importante sin haber desarrollado previamente tu MAAN. Quien no tiene una alternativa sólida fuera de la mesa está condenado a aceptar condiciones desfavorables o abusivas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/l5hpmrkIemQ" title="Tu ENEMIGO es tu MAYOR FUENTE DE PODER 💀🌩️🌪️" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-crosshair text-primary me-2"></i>1. El MAAN / BATNA (Best Alternative to a Negotiated Agreement)</h4>
    <p>El MAAN es el curso de acción concreto que ejecutarás si las negociaciones actuales fracasan por completo y no se llega a ningún acuerdo formal:</p>
    <ul>
        <li><strong>La Fuente Real del Poder:</strong> El poder en la mesa de negociación no depende de hablar fuerte ni de tener un título rimbombante; reside en la calidad de tu MAAN. Si vas a negociar un aumento de sueldo teniendo ya otra oferta de empleo firme por escrito con un 25% más de sueldo en otra empresa, tu MAAN es fortísimo y negociarás con absoluta serenidad. Si no tienes ahorros ni otra oferta, tu MAAN es débil y serás vulnerable.</li>
        <li><strong>Cómo Fortalecer tu MAAN antes de Negociar:</strong> Antes de sentarte con un proveedor exclusivo, cotiza con tres proveedores alternativos en el mercado, evalúa la posibilidad de fabricar el insumo internamente o contacta importadores internacionales.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrows-collapse text-primary me-2"></i>2. La ZOPA (Zona de Posible Acuerdo) y el Punto de Reserva</h4>
    <p>El Punto de Reserva (Walk-away Price) es el límite financiero absoluto más allá del cual prefieres levantarte e irte antes que firmar un mal negocio:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3 text-center">
        <p class="mb-1 fw-bold text-primary">Diagrama de la ZOPA Financiera:</p>
        <code class="fs-6">[Precio Mínimo de Venta del Vendedor] &lt;--- ZOPA (Rango de Acuerdo Viable) ---&gt; [Precio Máximo del Comprador]</code>
    </div>
    <p>Si el precio mínimo aceptable para el vendedor es $1.000 y el presupuesto máximo autorizado del comprador es $1.300, existe una <strong>ZOPA Positiva</strong> de $300 en la cual cualquier acuerdo intermedio generará valor para ambas partes. Si el comprador solo puede pagar $900, la ZOPA es negativa y no debe forzarse ningún acuerdo.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Revelar tu Punto de Reserva al inicio de la reunión:</strong> Decirle al vendedor <em>''Tengo exactamente $1.200 en el bolsillo''</em> elimina toda posibilidad de conseguir una mejor oferta en la negociación.</li>
        <li><strong>Sobreestimar un MAAN irreal o ficticio:</strong> Creer falsamente que tienes otra opción maravillosa sin haber verificado si el otro proveedor realmente tiene inventario disponible.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Tienes redactado y verificado tu MAAN antes de iniciar cualquier negociación clave?</li>
            <li>¿Calculas con anticipación tu punto de reserva numérico para no firmar acuerdos a pérdida?</li>
            <li>¿Estimas el rango de la ZOPA para saber si existe viabilidad económica real de acuerdo?</li>
        </ul>
    </div>
</div>', 'Descubre por qué quien tiene la mejor alternativa fuera de la mesa tiene el poder negociador. Aprende a calcular tu BATNA y mapear la ZOPA financiera con precisión.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (153, 153, 'El Efecto Anclaje Cognitivo y la Regla Sagrada de las Concesiones Condicionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-anchor fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Concesión Gratuita No se Agradece; Solo Despierta Mayor Avaricia</h5>
            <p class="mb-0 small">Cuando cedes en precio sin exigir nada a cambio, la contraparte no piensa que eres bondadoso; piensa que tu precio inicial era un engaño y te exigirá más rebajas. Domina la gestión táctica de concesiones.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/0AoQBg-q4HQ" title="Por qué es importante conocer la ZOPA (Zona de Posible Acuerdo) ?" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-geo-alt-fill text-primary me-2"></i>1. El Efecto Anclaje Psicológico (Anchoring Bias)</h4>
    <p>Descubierto por los premios Nobel Daniel Kahneman y Amos Tversky: la primera cifra que se pone sobre la mesa actúa como un poderoso imán cognitivo que atrae y condiciona todas las contraofertas posteriores:</p>
    <ul>
        <li><strong>¿Cuándo conviene anclar primero?:</strong> Cuando posees información sólida sobre el valor de mercado y los costos. Al colocar una primera oferta ambiciosa pero fundamentada en criterios técnicos creíbles, obligas a la contraparte a negociar dentro de tu terreno.</li>
        <li><strong>¿Cómo neutralizar un ancla ajena agresiva?:</strong> Si la contraparte lanza un ancla absurda (ej: ofrecer un 70% menos de lo presupuestado), nunca hagas una contraoferta inmediata sobre esa cifra. Rechaza el ancla formalmente: <em>''Esa cifra está fuera de todo estándar de mercado y no podemos utilizarla como punto de partida. Hablemos de costos de reposición y tiempos de entrega''</em>.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-sliders2 text-primary me-2"></i>2. La Regla de Oro: La Concesión Condicional (''Si tú... entonces yo...'')</h4>
    <p>Toda concesión otorgada en una negociación debe tener un costo explícito para la otra parte:</p>
    <div class="card bg-light border-start border-primary border-4 p-3 mb-3">
        <p class="mb-1 fw-bold">Estructura Lingüística Innegociable:</p>
        <p class="mb-0 text-muted"><em>''Si tú estás dispuesto a aumentar el volumen de compra a 500 unidades y pagar de contado en 5 días, entonces yo puedo considerar un descuento del 6% en el precio unitario''</em>.</p>
    </div>
    <p>Al condicionar la rebaja a una contraprestación que beneficie a tu flujo de caja o a tu logística, proteges tu margen de rentabilidad y educas a la contraparte en que cada pedido que haga requerirá reciprocidad.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Hacer concesiones cada vez más grandes a medida que avanza el tiempo:</strong> Las concesiones deben ser decrecientes (ej: si primero cediste $100, la siguiente concesión debe ser de $30 y la última de $10). Si aumentas las concesiones, el rival sabe que todavía tienes mucho margen por entregar.</li>
        <li><strong>Negociar un solo tema a la vez (Negociación Lineal):</strong> Acordar primero el precio de forma aislada te deja desarmado para negociar plazos de entrega o garantías después. Todos los temas deben negociarse en paquetes integrados.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aplicas la fórmula ''Si tú... entonces yo...'' en absolutamente cada concesión?</li>
            <li>¿Planificas concesiones decrecientes para comunicar con claridad la cercanía de tu límite?</li>
            <li>¿Negocias paquetes multidimensionales en lugar de aislar el precio del resto de variables?</li>
        </ul>
    </div>
</div>', 'Domina el sesgo de anclaje de Kahneman y Tversky para posicionar la primera oferta y aprende por qué nunca debes ceder nada sin pedir algo a cambio.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (161, 161, 'Dominio de Google Calendar y Outlook: Cómo Blindar tu Día de Interrupciones', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-calendar3 fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Si No Está en Tu Calendario, No Existe en Tu Vida Profesional</h5>
            <p class="mb-0 small">Las listas tradicionales de pendientes (To-Do Lists) generan ansiedad porque no tienen noción de tiempo real. Aprende la metodología de Bloques de Tiempo (Timeboxing) para recuperar el control de tu agenda.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/AraCTiT9_64" title="La mejor técnica para organizar tu día de alta productividad (Bloques de tiempo)" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-calendar-check text-primary me-2"></i>1. ¿Por Qué las To-Do Lists Tradicionales Fracasan?</h4>
    <p>Tener un papel o una nota con 25 tareas pendientes tiene tres graves defectos estructurales:</p>
    <ul>
        <li><strong>Falta de Estimación Temporal:</strong> No indica cuánto tiempo toma cada tarea ni en qué momento específico del día se ejecutará.</li>
        <li><strong>Efecto Zeigarnik Negativo:</strong> El cerebro se siente abrumado por la cantidad de pendientes abiertos y tiende a escoger las tareas más fáciles e irrelevantes para tacharlas rápido y tener una falsa sensación de logro.</li>
        <li><strong>Vulnerabilidad a Interrupciones:</strong> Si tu calendario está vacío, tus compañeros y jefes verán espacio libre y te programarán reuniones innecesarias durante todo el día.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-clock text-primary me-2"></i>2. La Metodología Timeboxing Paso a Paso</h4>
    <p>El Timeboxing consiste en asignar un bloque de tiempo cerrado en tu calendario digital (Google Calendar u Outlook) a una sola actividad prioritaria:</p>
    <ol>
        <li><strong>La Sesión de Planificación Dominical o de Lunes a Primera Hora (30 min):</strong> Antes de revisar correos, analiza tus metas semanales clave y bloquea los espacios de tiempo necesarios para tus entregables críticos.</li>
        <li><strong>Bloques Temáticos (Day Theming & Task Batching):</strong> Agrupa tareas similares para ejecutarlas en un solo tirón y evitar el costo de cambio cognitivo. Por ejemplo: <em>''Lunes de 2:00 pm a 3:30 pm: Pago a Proveedores y Facturación''</em>; <em>''Todos los días de 11:30 am a 12:00 pm y de 4:30 pm a 5:00 pm: Revisión y Respuesta de Correos''</em>. Fuera de esos horarios, la bandeja de entrada permanece cerrada.</li>
        <li><strong>Margen de Amortiguamiento (Buffer Blocks):</strong> Deja un bloque de 45 a 60 minutos al final de la tarde vacío para absorber imprevistos y urgencias reales sin que se descuadre el resto de tu semana.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Sobrecargar el calendario al 100% sin margen:</strong> Programar tareas espalda con espalda sin dejar ni 5 minutos entre reuniones genera estrés severo y atrasos en cascada.</li>
        <li><strong>Mantener las notificaciones del correo abiertas todo el día:</strong> El clásico ''pop-up'' que avisa la llegada de un nuevo correo interrumpe el flujo cognitivo y destruye la concentración en tareas complejas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Planificas tu semana con bloques de tiempo en calendario antes de abrir el correo el lunes?</li>
            <li>¿Agrupas tareas administrativas rutinarias en bloques de procesamiento por lotes (Batching)?</li>
            <li>¿Resguardas al menos un bloque diario libre de reuniones para trabajo de concentración?</li>
        </ul>
    </div>
</div>', 'Aprende el método Timeblocking utilizado por Elon Musk y Bill Gates: agendar resultados en bloques cerrados de calendario en lugar de listas infinitas de tareas pendientes.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (162, 162, 'La Técnica Pomodoro Clásica y el Combate Contra las Interrupciones', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-stopwatch-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Trabaja con el Tiempo, No Contra el Tiempo</h5>
            <p class="mb-0 small">Francesco Cirillo inventó la Técnica Pomodoro en la universidad usando un reloj de cocina con forma de tomate. Conoce la ciencia neurológica de los ciclos de hiperfoco y pausas de recarga mental.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/3D0-l2O5k8Y" title="Técnica poderosa de productividad! - Técnica Pomodoro - animado" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-clock-history text-primary me-2"></i>1. El Ciclo Pomodoro Estándar</h4>
    <p>El cerebro humano no está diseñado para mantener una atención sostenida de alta intensidad durante 8 horas continuas. La técnica Pomodoro optimiza los ritmos ultradianos:</p>
    <ul>
        <li><strong>Paso 1: Seleccionar una Sola Tarea:</strong> Definir con total precisión qué entregable se completará durante el bloque (ej: redactar la sección 3 del informe).</li>
        <li><strong>Paso 2: Ajustar el Temporizador a 25 Minutos:</strong> Durante estos 25 minutos rige una regla inquebrantable: <em>Cero distracciones</em>. No se revisa el teléfono, no se abren pestañas secundarias y no se responden dudas que no sean de vida o muerte.</li>
        <li><strong>Paso 3: Descanso Corto de 5 Minutos:</strong> Al sonar la campana, levantarse obligatoriamente de la silla. Caminar, tomar un vaso de agua, estirar la espalda o mirar por la ventana. <em>(¡Atención!: No revisar el teléfono ni redes sociales, ya que el cerebro no descansa si se le bombardea con nuevos estímulos visuales)</em>.</li>
        <li><strong>Paso 4: Repetir el Ciclo y Descanso Largo:</strong> Al completar cuatro pomodoros (100 minutos de trabajo neto), tomar una pausa prolongada de 20 a 30 minutos para almorzar o despejar la mente por completo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-clipboard-x text-primary me-2"></i>2. La Hoja de Distracciones y el Manejo de Interrupciones</h4>
    <p>Durante un Pomodoro es natural que el cerebro intente sabotear la concentración con ideas repentinas (<em>''Tengo que comprar pan'', ''¿Habrá respondido el cliente al correo?''</em>):</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small"><strong>La Hoja de Descarga Mental:</strong> Ten una libreta en blanco al lado de tu teclado. Cada vez que te asalte un pensamiento parásito, anótalo en una línea en 3 segundos y regresa de inmediato al Pomodoro. Al terminar los 25 minutos, podrás revisar tu lista de descargas y atender lo que sea necesario.</p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Saltarse los descansos de 5 minutos:</strong> Creer que trabajar 4 horas de corrido sin pausas es más productivo. A partir del minuto 60 la tasa de fatiga mental se dispara y la velocidad de procesamiento cae en picada.</li>
        <li><strong>Usar el descanso para mirar TikTok o Instagram:</strong> Los videos cortos inundan el cerebro de dopamina barata, haciendo que volver al trabajo concentrado sea diez veces más difícil y pesado.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respetas los 25 minutos de enfoque absoluto sin tocar el teléfono móvil?</li>
            <li>¿Te levantas de la silla y descansas la vista de las pantallas en los 5 minutos de pausa?</li>
            <li>¿Anotas pensamientos parásitos en una libreta de descarga sin romper tu ciclo de concentración?</li>
        </ul>
    </div>
</div>', 'Domina los ciclos de concentración de 25 minutos de Francesco Cirillo: cómo estructurar intervalos de descanso activo y gestionar el inventario de distracciones internas y externas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (54, 54, 'Diseño de Diapositivas Ejecutivas de Alto Impacto para Juntas Directivas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-file-earmark-slides-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Diapositiva es una Ayuda Visual, no un Teleprompter</h5>
            <p class="mb-0 small">El error más destructivo en presentaciones corporativas es proyectar párrafos enteros de texto para que el expositor los lea de espaldas al público. La diapositiva debe complementar tu voz, no competir contra ella.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/LIXfGkAca0g" title="Cómo usar PowerPoint [ Guía completa ]" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Regla de Oro 6x6 y Jerarquía Visual</h4>
    <p>Para mantener la atención de un comité directivo o un cliente potencial, se recomienda aplicar el principio de diseño ejecutivo <strong>Regla 6x6</strong>:</p>
    <ul>
        <li>Máximo <strong>6 viñetas (bullets)</strong> por diapositiva.</li>
        <li>Máximo <strong>6 a 8 palabras</strong> por viñeta (oraciones concisas tipo telegrama, no párrafos literarios).</li>
        <li>Una única idea central por diapositiva. Si tienes tres argumentos comerciales distintos, es preferible utilizar tres diapositivas limpias y dinámicas que una sola diapositiva abarrotada de letras microscópicas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-palette-fill text-primary me-2"></i>2. Contraste de Color, Tipografía e Iconografía Vectorial</h4>
    <p>El diseño profesional de diapositivas se basa en tres reglas visuales obligatorias:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">1. Alto Contraste</h6>
                <p class="small text-muted mb-0">Texto oscuro (gris grafito o azul marino profundo) sobre fondo blanco/claro, o texto blanco sobre fondo oscuro. Nunca utilices texto amarillo o verde claro sobre fondos blancos.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">2. Máximo 2 Tipografías</h6>
                <p class="small text-muted mb-0">Una tipografía robusta para títulos (ej: Arial Black, Montserrat o Trebuchet MS) y una limpia sin serifas para el contenido (ej: Calibri, Aptos o Segoe UI).</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">3. Iconos en vez de Puntos</h6>
                <p class="small text-muted mb-0">Reemplaza las tradicionales viñetas de puntos negros por iconos vectoriales limpios que representen el concepto (una moneda para costos, un reloj para plazos, un usuario para clientes).</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-layout-wtf text-primary me-2"></i>3. Estructura Narrativa de Presentación Ejecutiva (Problema ➔ Solución ➔ Impacto)</h4>
    <p>Para presentar una propuesta o un balance trimestral con éxito persuasivo, organiza las diapositivas en tres actos claros:</p>
    <ol>
        <li><strong>El Desafío / Problema Actual (20% del tiempo):</strong> Mostrar la realidad con cifras contundentes (ej: ''El tiempo de despacho aumentó 3 días en el último mes'').</li>
        <li><strong>La Solución Propuesta / Plan de Acción (50% del tiempo):</strong> Explicar la iniciativa paso a paso, los responsables y los recursos necesarios.</li>
        <li><strong>El Retorno / Impacto Económico Esperado (30% del tiempo):</strong> Concluir con la ganancia concreta para la empresa (ej: ''Ahorro proyectado de $12.000 USD anuales y 98% de entregas a tiempo'').</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Abusar de animaciones de entrada y transiciones ruidosas:</strong> Efectos como rebotes, espirales o sonidos de aplausos restan seriedad institucional. Utiliza transiciones sobrias como <em>''Desvanecer'' (Fade)</em> o transiciones suaves de medio segundo.</li>
        <li><strong>Estirar o deformar imágenes y logotipos:</strong> Al redimensionar una imagen corporativa, mantén siempre presionada la tecla <code>Shift</code> y arrastra desde las esquinas diagonales para conservar las proporciones perfectas sin achatarlas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respetaste la regla 6x6 evitando saturar de texto las diapositivas?</li>
            <li>¿El tamaño de letra de los textos principales es de al menos 24pt a 28pt para que sea legible al fondo de la sala?</li>
            <li>¿Probaste el modo Presentador con la tecla F5 y comprobaste el funcionamiento de tus notas del orador?</li>
        </ul>
    </div>
</div>', 'Elimina diapositivas sobrecargadas de texto. Aplica la regla 6x6, el contraste tipográfico, el uso de iconografía vectorial corporativa y la estructuración de narrativas de negocios (Storytelling).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (43, 43, 'De Millones de Registros a Reportes Ejecutivos en Menos de 60 Segundos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-grid-3x3-gap-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Tablas Dinámicas: El Motor de la Analítica Empresarial</h5>
            <p class="mb-0 small">Un reporte que tomaría tres días de trabajo manual escribiendo fórmulas SUMAR.SI.CONJUNTO puede generarse en 30 segundos con una Tabla Dinámica bien configurada, lista para responder cualquier pregunta de la gerencia.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/JTSAnYHbPrc" title="Power Query y Tablas Dinámicas para consolidar datos de Excel" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Los Cuatro Cuadrantes de una Tabla Dinámica</h4>
    <p>Para construir un análisis sólido, la base de datos de origen debe estar en formato tabular puro (sin filas vacías, sin celdas combinadas y con encabezados únicos en la primera fila). Al hacer clic en <em>Insertar ➔ Tabla Dinámica</em>, se abre el panel lateral con cuatro zonas fundamentales:</p>
    <ul>
        <li><strong>Filas (Rows):</strong> Los campos que organizan la información verticalmente (ej: Nombres de Vendedores, Sucursales o Familias de Producto).</li>
        <li><strong>Columnas (Columns):</strong> Los campos que desglosan la información horizontalmente (ej: Meses del año o Canales de Venta: Tienda Física vs E-commerce).</li>
        <li><strong>Valores (Values):</strong> Las métricas numéricas que se desean calcular (ej: Suma de Ventas en USD, Cantidad de Facturas emitidas, Promedio de Descuento).</li>
        <li><strong>Filtros (Filters):</strong> Criterios globales para filtrar todo el informe (ej: Filtrar solo las ventas de la región Centro).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator text-primary me-2"></i>2. Campos Calculados vs Columnas Calculadas en la Base</h4>
    <p>Un error muy común de los principiantes es agregar columnas de cálculo directamente en la base de datos de 100.000 filas (ej: calcular el IVA multiplicando cada fila por 0.16), lo que infla el tamaño del archivo en megabytes innecesarios. En su lugar, el analista profesional crea un <strong>Campo Calculado</strong> dentro de la propia Tabla Dinámica:</p>
    <ol>
        <li>Hacer clic sobre la Tabla Dinámica y entrar en la pestaña superior <strong>Análisis de tabla dinámica</strong>.</li>
        <li>Hacer clic en <strong>Campos, elementos y conjuntos ➔ Campo calculado</strong>.</li>
        <li>Asignar un nombre al campo (ej: <code>IVA_16</code>) y definir la fórmula matemática: <code>= Ventas_Netas * 0.16</code>.</li>
        <li>Excel calculará la métrica al vuelo de forma instantánea sobre el resumen, manteniendo el archivo liviano y ultraveloz.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-funnel-fill text-primary me-2"></i>3. Segmentadores de Datos (Slicers) y Conexiones de Informe</h4>
    <p>Para que una junta directiva o un cliente pueda interactuar con el informe como si fuera una aplicación web moderna, se reemplazan los filtros desplegables aburridos por <strong>Segmentadores de Datos (Slicers)</strong>:</p>
    <ul>
        <li>Botones visuales de clic rápido que filtran la información por Año, Vendedor o Categoría con código de colores.</li>
        <li><strong>Conexiones de Informe (Report Connections):</strong> Al hacer clic derecho sobre un segmentador y seleccionar <em>''Conexiones de informe''</em>, puedes vincular ese único botón a cuatro tablas dinámicas y tres gráficos dinámicos diferentes al mismo tiempo. Al presionar ''2026'', todo el panel ejecutivo se actualiza en sincronía perfecta.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Olvidar actualizar la Tabla Dinámica al cambiar datos en la base:</strong> A diferencia de las fórmulas estándar que se recalculan en tiempo real, las Tablas Dinámicas almacenan una instantánea en memoria (Caché de Tabla Dinámica). Si modificas montos en la tabla base, debes presionar obligatoriamente <code>Alt + F5</code> (o hacer clic en <em>Actualizar</em>) para reflejar los cambios.</li>
        <li><strong>Agrupación de fechas que no funciona:</strong> Si intentas hacer clic derecho sobre una columna de fechas para agrupar por Meses y Años y Excel arroja el mensaje <em>''No se puede agrupar esa selección''</em>, significa que al menos una celda de la columna tiene un espacio en blanco o una fecha escrita como texto. Todas las celdas deben tener formato de fecha válido.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste que la base de datos de origen no tenga subtotales manuales ni celdas combinadas?</li>
            <li>¿Utilizaste campos calculados en lugar de agregar columnas pesadas en la base de datos?</li>
            <li>¿Conectaste tus segmentadores de datos (Slicers) a todos los gráficos del panel de control?</li>
        </ul>
    </div>
</div>', 'Transforma grandes bases de datos en resúmenes visuales interactivos. Domina los cuatro cuadrantes de las Tablas Dinámicas, campos calculados matemáticos, segmentadores visuales de datos y agrupación por fechas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (44, 44, 'De Tareas Manuales de 4 Horas a Procesos de 1 Clic con Visual Basic', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-play-circle-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Automatización es el Salto de Analista a Profesional Imparable</h5>
            <p class="mb-0 small">Si todos los lunes por la mañana descargas un archivo plano del sistema ERP y pasas tres horas borrando columnas, pintando encabezados y aplicando fórmulas idénticas, una macro de 5 líneas de código puede hacer exactamente lo mismo en 2 segundos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/40Am88JtgIU" title="Curso Excel VBA y Macros - Introducción al desarrollo de aplicaciones" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es una Macro y Qué es Visual Basic for Applications (VBA)?</h4>
    <p>Una <strong>Macro</strong> es una secuencia grabada de instrucciones, clics y pulsaciones de teclas que Excel almacena para reproducirlas tantas veces como sea necesario. Debajo del capó, cada acción que realizas en pantalla se traduce automáticamente a un lenguaje de programación formal llamado <strong>Visual Basic for Applications (VBA)</strong>.</p>
    <p>Para comenzar a trabajar con macros, el primer paso técnico obligatorio es activar la pestaña oculta de <strong>Programador (o Desarrollador)</strong> en Excel:</p>
    <ol>
        <li>Ir a <em>Archivo ➔ Opciones ➔ Personalizar cinta de opciones</em>.</li>
        <li>En la columna derecha, marcar la casilla de verificación <strong>Programador</strong> (o Desarrollador) y hacer clic en Aceptar.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-record-btn-fill text-danger me-2"></i>2. Grabación Profesional de Macros: Referencias Absolutas vs Relativas</h4>
    <p>En la pestaña Programador existen dos modos de grabación con comportamientos totalmente distintos:</p>
    <ul>
        <li><strong>Grabación Estándar (Absoluta):</strong> Si grabas una macro que selecciona la celda <code>C5</code> y le aplica negrita, al ejecutar la macro en cualquier otra hoja siempre modificará la celda <code>C5</code> fija. Es perfecta para reportes que siempre tienen la misma estructura fija proveniente del ERP.</li>
        <li><strong>Usar Referencias Relativas:</strong> Al activar este botón antes de grabar, la macro opera respecto a la celda que tengas seleccionada en ese momento (ej: ''baja 2 filas y desplázate 1 columna a la derecha''). Es ideal para procesar listas de tamaño variable donde no sabes cuántas filas habrá cada semana.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-code-slash text-primary me-2"></i>3. Estructura Básica de un Módulo VBA y Asignación de Botones</h4>
    <p>Al presionar <code>Alt + F11</code> se abre el Entorno de Desarrollo Integrado (IDE) de VBA. Una macro bien escrita se estructura dentro de un procedimiento <code>Sub</code>:</p>
    <div class="card border-0 bg-light p-3 mb-3 rounded-3">
        <pre class="font-monospace small mb-0 text-dark">
Sub LimpiarYFormatearReporte()
    '' Desactiva el parpadeo de pantalla para máxima velocidad
    Application.ScreenUpdating = False
    
    '' Aplica formato a los encabezados
    Range("A1:F1").Font.Bold = True
    Range("A1:F1").Interior.Color = RGB(13, 110, 253) '' Azul corporativo
    Range("A1:F1").Font.Color = RGB(255, 255, 255)    '' Texto blanco
    
    '' Autoajustar el ancho de todas las columnas utilizadas
    Cells.EntireColumn.AutoFit
    
    Application.ScreenUpdating = True
    MsgBox "¡Reporte semanal procesado exitosamente en 1 segundo!", vbInformation, "Éxito"
End Sub
        </pre>
    </div>
    <p class="small text-muted"><strong>Creación del Botón de 1 Clic:</strong> Ve a <em>Insertar ➔ Formas ➔ Rectángulo redondeado</em>, dibújalo en la hoja, escribe ''Procesar Reporte'' con diseño elegante, haz clic derecho sobre la forma y selecciona <em>''Asignar macro...''</em> vinculando tu código. A partir de ese momento, cualquier empleado podrá ejecutar el proceso presionando ese botón.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Guardar el archivo como un libro de Excel normal (.xlsx):</strong> El formato estándar <code>.xlsx</code> por motivos de seguridad informática elimina automáticamente todas las macros grabadas al guardar. Todo libro con código VBA debe guardarse obligatoriamente bajo el tipo <strong>Libro de Excel habilitado para macros (*.xlsm)</strong>. Si lo guardas como xlsx, perderás todo el trabajo de programación de la jornada.</li>
        <li><strong>Las macros NO se pueden deshacer con Ctrl + Z:</strong> Cuando ejecutas una macro que borra filas o sobrescribe datos, la memoria de deshecho de Excel se borra por completo. Siempre guarda una copia de respaldo del archivo antes de ejecutar una macro masiva en producción.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Guardaste el libro con la extensión obligatoria .xlsm (habilitado para macros)?</li>
            <li>¿Incluiste Application.ScreenUpdating = False al inicio de tus macros para acelerar la ejecución?</li>
            <li>¿Asignaste la macro a un botón visible e intuitivo para el usuario final?</li>
        </ul>
    </div>
</div>', 'Elimina la monotonía diaria. Habilita la pestaña Programador, graba macros relativas para formatear reportes descargados del ERP, guarda archivos en formato .xlsm y comprende la estructura básica de código VBA.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (34, 34, 'El Motor Matemático de Power BI y el Contexto de Evaluación', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cpu-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">DAX no es Excel: El Poder del Contexto de Filtro</h5>
            <p class="mb-0 small">El error más frecuente al aprender DAX es intentar escribir fórmulas pensando como en las celdas de Excel. En DAX no existen referencias tipo ''A1''; se opera sobre columnas enteras y se evalúan contextos de filtro dinámicos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/iWdHdo58Uos" title="Tutorial rápido: función CALCULATE para sumar en Power BI" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Columna Calculada vs Medida Explícita</h4>
    <p>Para escribir DAX profesional, la primera decisión técnica es saber cuándo usar una columna y cuándo crear una medida:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Característica</th>
                    <th>Columna Calculada</th>
                    <th>Medida Dinámica (DAX Measure)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold">Momento de Cálculo</td>
                    <td>Se calcula una sola vez durante la carga o actualización de datos.</td>
                    <td>Se calcula ''al vuelo'' cada vez que el usuario hace clic o filtra un visual en el tablero.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Consumo de Memoria</td>
                    <td>Almacena un valor físico fila por fila en el disco/memoria RAM (infla el archivo).</td>
                    <td>No consume memoria de almacenamiento; utiliza la CPU momentáneamente para responder la consulta.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Uso Profesional</td>
                    <td>Únicamente cuando necesitas usar el resultado como un filtro o eje en una gráfica (ej: clasificar clientes por Edad).</td>
                    <td><strong>Para todas las operaciones matemáticas y porcentajes:</strong> Sumas, promedios, márgenes, variaciones temporales.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-lightning-charge-fill text-danger me-2"></i>2. La Función Reina de DAX: CALCULATE</h4>
    <p>Si existe una función indispensable en Business Intelligence es <strong>CALCULATE</strong>. Es la única función de DAX capaz de <em>modificar o anular el contexto de filtro</em> impuesto por los visuales del informe:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark">
        <code>Ventas_Venezuela = CALCULATE([Total_Ventas]; DimPaises[Pais] = "Venezuela")</code>
    </div>
    <p class="small text-muted">Sin importar qué país seleccione el usuario en los segmentadores del tablero, esta medida específica siempre calculará únicamente las ventas correspondientes a Venezuela.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-percent text-success me-2"></i>3. Cálculo de Participación de Mercado con ALL()</h4>
    <p>Para calcular qué porcentaje representa cada vendedor sobre el <strong>Total General de la Empresa</strong>, se utiliza la función <code>ALL()</code> dentro de CALCULATE para retirar el filtro de fila:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        1. <code>Total_Ventas = SUM(FactVentas[Monto])</code><br />
        2. <code>Ventas_Todas = CALCULATE([Total_Ventas]; ALL(DimVendedores))</code><br />
        3. <code>% Participacion = DIVIDE([Total_Ventas]; [Ventas_Todas]; 0)</code>
    </div>
    <p class="small text-muted"><em>Consejo profesional:</em> Utiliza siempre la función <code>DIVIDE(Numerador; Denominador; 0)</code> en lugar del operador barra (<code>/</code>). La función DIVIDE previene que la aplicación arroje errores fatales de ''División por Cero'' cuando las ventas son nulas.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear columnas calculadas para sumatorias simples:</strong> Escribir una columna calculada para sumar las ventas de cada fila gasta megabytes de memoria innecesarios. Las sumas siempre deben ser Medidas (<code>SUM</code> o <code>SUMX</code>).</li>
        <li><strong>Usar el operador barra (/) para calcular márgenes:</strong> Provoca errores <code>#ERROR</code> o ''Infinity'' en meses sin ventas. La función <code>DIVIDE</code> maneja divisiones entre cero con total elegancia devolviendo 0 o blanco.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Escribiste medidas explícitas para todas tus métricas en lugar de arrastrar campos numéricos directos?</li>
            <li>¿Utilizaste DIVIDE con valor alternativo cero para todos tus ratios y porcentajes?</li>
            <li>¿Creaste una tabla dedicada exclusiva para almacenar y organizar todas tus medidas DAX?</li>
        </ul>
    </div>
</div>', 'Domina el lenguaje DAX (Data Analysis Expressions). Entiende la diferencia crucial entre Columnas Calculadas (consumen RAM) y Medidas Dinámicas. Domina la función reina CALCULATE, ALL y FILTER.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (35, 35, 'UX/UI para Analistas: Creación de Cuadros de Mando Claros e Intuitivos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-pie-chart-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Storytelling con Datos: Guiar la Mirada hacia la Decisión</h5>
            <p class="mb-0 small">Un panel de control lleno de gráficos abigarrados con 15 colores distintos no informa; aturde. El diseño ejecutivo aplica principios de psicología visual para que el director general entienda el estado del negocio en 5 segundos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/JvWjgIJE77M" title="Data Storytelling: Aprende a contar historias con datos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Patrón de Lectura en ''Z'' (Gutenberg) para Dashboards</h4>
    <p>En la cultura occidental, los ojos exploran una pantalla siguiendo un patrón natural en forma de ''Z'': de izquierda a derecha en la parte superior, bajando diagonalmente hacia la izquierda, y cruzando finalmente hacia la esquina inferior derecha. Los diseñadores de tableros organizan el espacio en tres niveles de profundidad:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">1. Nivel Superior (KPIs Globales)</span>
                <p class="small mb-0 text-muted">Tarjetas grandes con las cifras vitales del mes: <strong>Ventas Totales, Margen Bruto %, Clientes Nuevos y Tasa de Retención</strong>. Respaldadas por un color semáforo (Verde / Rojo) frente a la meta.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">2. Nivel Medio (Tendencia y Desglose)</span>
                <p class="small mb-0 text-muted">Gráficos de líneas para ver la evolución de las ventas a lo largo de los 12 meses, y gráficos de barras horizontales para comparar el desempeño de las 5 sucursales principales.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-secondary mb-2">3. Nivel Inferior (Detalle Operativo)</span>
                <p class="small mb-0 text-muted">Tabla o matriz detallada con la lista de clientes o artículos críticos para que el usuario pueda hacer auditoría fina o exportar a Excel si lo requiere.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-bar-chart-line-fill text-primary me-2"></i>2. Selección Quirúrgica del Tipo de Gráfico</h4>
    <p>Utilizar el gráfico equivocado distorsiona el mensaje de negocio. Aplica la siguiente guía estandarizada:</p>
    <ul>
        <li><strong>Gráficos de Pastel (Donas / Pie Charts):</strong> Terminantemente desaconsejados si tienen más de 3 categorías. El ojo humano tiene dificultades para comparar ángulos; prefiere comparar longitudes de barras.</li>
        <li><strong>Gráficos de Barras Horizontales:</strong> La mejor opción para comparar categorías con nombres largos (ej: ''Servicio Técnico Especializado'' vs ''Venta Mayorista de Insumos'') porque el texto se lee cómodamente de izquierda a derecha sin inclinar el cuello.</li>
        <li><strong>Gráficos de Líneas o Área:</strong> Exclusivos para representar variables continuas en el <strong>tiempo</strong> (días, semanas, meses, trimestres).</li>
        <li><strong>Gráficos de Dispersión (Scatter Plot):</strong> Para analizar la correlación entre dos variables cuantitativas (ej: ¿A mayor descuento otorgado, mayor volumen de compra del cliente?).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-palette text-primary me-2"></i>3. Paleta de Colores y Formato Condicional Semafórico</h4>
    <p>Aplica la regla del 60-30-10:</p>
    <ul>
        <li><strong>60% Color Dominante Neutro:</strong> Fondos blancos o grises muy suaves (<code>#F8F9FA</code>) para no fatigar la vista.</li>
        <li><strong>30% Color Corporativo Secundario:</strong> Azul marino, gris oscuro o grafito para barras, textos principales y marcos.</li>
        <li><strong>10% Color de Acento Semafórico:</strong> Rojo exclusivamente para alertas negativas (ej: rentabilidad bajo cero o caída de ventas) y Verde para metas superadas. Nunca uses colores chillones como adornos decorativos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Llenar la pantalla de visuales sin dejar márgenes en blanco:</strong> El espacio en blanco (White Space) es un elemento de diseño fundamental que permite al cerebro descansar y enfocar la atención en los datos importantes.</li>
        <li><strong>No configurar interacciones entre visuales:</strong> En la pestaña <em>Formato ➔ Editar interacciones</em>, verifica que al hacer clic en un gráfico de barras los demás visuales se filtren limpiamente en lugar de resaltar una porción borrosa.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Organizaste las métricas de mayor a menor jerarquía siguiendo el patrón de lectura en ''Z''?</li>
            <li>¿Evitaste gráficos de pastel con más de 3 rebanadas y usaste barras horizontales para nombres largos?</li>
            <li>¿Probaste el reporte con la vista de diseño móvil (Mobile Layout) para directores que consultan en teléfonos?</li>
        </ul>
    </div>
</div>', 'Diseña tableros de control de nivel C-Level: jerarquía visual en ''Z'', tarjetas de KPI con formato condicional, selección correcta de gráficos (Barras, Líneas, Dispersión) y publicación en Power BI Service.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (72, 72, 'Detección de Outliers, Correlaciones y Distribuciones Estadísticas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-graph-up-arrow fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">EDA: Ver los Datos antes de Entrenar Cualquier Algoritmo</h5>
            <p class="mb-0 small">El Análisis Exploratorio de Datos (EDA) es el paso fundamental para descubrir patrones ocultos, sesgos y anomalías (outliers) que podrían arruinar cualquier modelo de inteligencia artificial o predicción financiera.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/CU0C8SK7fTw" title="Descubre el poder del Análisis Exploratorio de Datos (EDA)" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las Dos Bibliotecas Visuales Estándar: Matplotlib y Seaborn</h4>
    <p>En el ecosistema científico de Python, la visualización se construye sobre dos pilares integrados:</p>
    <ul>
        <li><strong>Matplotlib (pyplot):</strong> La librería base de bajo nivel. Controla cada detalle milimétrico de la figura: títulos, ejes, tamaños de lienzo, etiquetas de texto y guardado en archivos de alta resolución (PNG/PDF vectoriales).</li>
        <li><strong>Seaborn:</strong> Construida sobre Matplotlib, provee estilos modernos de alto impacto visual y funciones preprogramadas para análisis estadístico complejo con una sola línea de código.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-bounding-box-circles text-primary me-2"></i>2. Los 3 Gráficos Indispensables en Todo Análisis Exploratorio</h4>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">1. Histograma (sns.histplot)</h6>
                <p class="small text-muted mb-0">Muestra la <strong>distribución y asimetría</strong> de una variable numérica (ej: Salarios de los empleados). Permite comprobar si los datos siguen una distribución normal acampanada o si están sesgados hacia la izquierda.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">2. Diagrama de Caja (Boxplot)</h6>
                <p class="small text-muted mb-0">Identifica la mediana, el rango intercuartílico (IQR) y los <strong>Outliers (valores atípicos)</strong> representados como puntos aislados fuera de los bigotes (ej: un error de digitación de un precio de $10.000.000).</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-dark mb-1">3. Mapa de Calor (Heatmap)</h6>
                <p class="small text-muted mb-0">Muestra la <strong>matriz de correlación de Pearson</strong> entre todas las variables numéricas, coloreando de azul o rojo intenso aquellas variables fuertemente ligadas entre sí.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-code-slash text-dark me-2"></i>3. Código Python para Generar una Matriz de Correlación Ejecutiva</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <pre class="font-monospace small mb-0 text-dark">
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 6))
matriz_corr = df[[''ingresos'', ''gasto_publicidad'', ''visitas_web'', ''ventas_netas'']].corr()

sns.heatmap(matriz_corr, annot=True, cmap=''coolwarm'', fmt=".2f", linewidths=0.5)
plt.title(''Matriz de Correlación de Indicadores de Negocio'', fontsize=14, pad=15)
plt.tight_layout()
plt.savefig(''correlacion_negocio.png'', dpi=300)
plt.show()
        </pre>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Correlación con Causalidad:</strong> Que dos variables tengan una correlación estadística alta de 0.90 (ej: el aumento en las ventas de helados y el aumento en el uso de gafas de sol) no significa que una cause la otra; ambas son causadas por una tercera variable oculta (el verano caluroso).</li>
        <li><strong>Eliminar outliers sin investigar su origen:</strong> Si un cliente compró $50.000 en una tienda donde el promedio es $100, no siempre es un error; puede ser una compra institucional de un cliente corporativo VIP que debe analizarse por separado.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Graficaste boxplots para detectar valores atípicos que puedan distorsionar la media?</li>
            <li>¿Calculaste la matriz de correlación para descartar variables redundantes antes del modelado?</li>
            <li>¿Guardaste los gráficos en alta resolución (300 DPI) para incluirlos en el informe ejecutivo?</li>
        </ul>
    </div>
</div>', 'Domina el análisis exploratorio visual en Python. Grafica histogramas de distribución, diagramas de dispersión, mapas de calor de correlación (Heatmaps) con Seaborn y detecta valores atípicos (Boxplots).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (73, 73, 'De la Descripción a la Predicción: Regresión y Clasificación Supervisada', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-robot fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Machine Learning: Anticipar el Futuro con Datos Históricos</h5>
            <p class="mb-0 small">El análisis descriptivo nos dice qué pasó en la empresa el año pasado. El Machine Learning nos permite responder qué cliente tiene un 85% de probabilidad de cancelar su suscripción el próximo mes para que podamos actuar antes de que se vaya.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/J8VOHBkNIT0" title="Curso scikit-learn - Temario y Machine Learning en Python" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Aprendizaje Supervisado: Regresión vs Clasificación</h4>
    <p>En el <strong>Aprendizaje Automático Supervisado</strong>, el algoritmo aprende a partir de un conjunto de datos histórico que ya contiene la respuesta correcta (denominada <em>etiqueta o target Y</em>):</p>
    <ul>
        <li><strong>Modelos de Regresión:</strong> La variable objetivo a predecir es un <strong>número continuo</strong> (ej: Predecir el monto de ventas en dólares del próximo trimestre, o el precio de alquiler de una propiedad).</li>
        <li><strong>Modelos de Clasificación:</strong> La variable objetivo es una <strong>categoría binaria o múltiple</strong> (ej: ¿Este cliente pagará el crédito o entrará en mora? [Sí / No]; o ¿Este correo es spam o legítimo?).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-scissors text-danger me-2"></i>2. La Regla de Oro: División Train / Test Split</h4>
    <p>El error más grave de un principiante en ciencia de datos es entrenar el modelo con todos los datos y evaluarlo con esos mismos datos (provocando <em>Sobreajuste o Overfitting</em>: el modelo simplemente ''memoriza'' los datos del pasado pero fracasa estrepitosamente al predecir datos nuevos del mundo real).</p>
    <p>La metodología estricta exige dividir la base de datos en dos conjuntos aislados utilizando Scikit-Learn:</p>
    <ol>
        <li><strong>Conjunto de Entrenamiento (Train - 80% de los datos):</strong> Utilizado por el algoritmo para calibrar sus pesos matemáticos.</li>
        <li><strong>Conjunto de Prueba (Test - 20% de los datos):</strong> Datos nunca vistos por el modelo, utilizados exclusivamente para evaluar su precisión real.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-code-square text-primary me-2"></i>3. Flujo Completo de Código de un Modelo Predictivo en Python</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <pre class="font-monospace small mb-0 text-dark">
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

# 1. Separar variables explicativas (X) de la variable objetivo (y)
X = df[[''gasto_marketing'', ''num_vendedores'', ''visitas_tienda'']]
y = df[''ventas_totales'']

# 2. División en conjuntos de entrenamiento (80%) y prueba (20%)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 3. Instanciar y entrenar el modelo
modelo = LinearRegression()
modelo.fit(X_train, y_train)

# 4. Generar predicciones sobre datos nunca vistos
predicciones = modelo.predict(X_test)

# 5. Evaluar la calidad del modelo con métricas profesionales
r2 = r2_score(y_test, predicciones)
print(f"Coeficiente de Determinación R²: {r2:.3f}")
        </pre>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Fuga de Datos (Data Leakage):</strong> Incluir como variable de entrada una columna que solo se conoce <em>después</em> de que el evento ya ocurrió (ej: incluir ''fecha_de_cancelacion'' para predecir si el cliente cancelará su cuenta). El modelo tendrá un 100% de precisión aparente en pruebas pero será inútil en la vida real.</li>
        <li><strong>Evaluar un modelo de clasificación desbalanceado solo con ''Accuracy'' (Exactitud):</strong> Si en un banco el 99% de las transacciones son legítimas y solo el 1% es fraude, un modelo tonto que prediga ''No es Fraude'' para todas las transacciones tendrá un 99% de exactitud, pero no detectará ningún fraude. En estos casos se deben evaluar métricas como <strong>Precision, Recall y F1-Score</strong>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Dividiste tus datos en conjuntos de Train (80%) y Test (20%) antes de entrenar?</li>
            <li>¿Escalaste las variables numéricas si utilizas algoritmos basados en distancias (KNN / SVM)?</li>
            <li>¿Evaluaste el modelo con métricas de negocio reales (R², RMSE, Curva ROC/AUC)?</li>
        </ul>
    </div>
</div>', 'Entrena tus primeros algoritmos predictivos con Scikit-Learn: división de datos Train/Test, modelos de Regresión Lineal para ventas, Clasificación (Regresión Logística / Árboles) y métricas de exactitud.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (63, 63, 'Visualización Analítica: Gráficos Combinados con Eje Secundario y Líneas de Tendencia', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-bar-chart-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Gráficos con Eje Secundario: Comparar Cifras Gigantes contra Porcentajes</h5>
            <p class="mb-0 small">Si intentas graficar en una misma barra la facturación mensual ($100.000 USD) junto con el margen de ganancia (15%), la línea del 15% quedará pegada al suelo del gráfico en el cero absoluto. El Eje Secundario resuelve este problema al instante.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/ECmDkh50Zz8" title="Cómo hacer un gráfico combinado con eje secundario en Excel" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Por qué es Necesario un Eje Secundario?</h4>
    <p>Cuando un analista financiero debe presentar un informe de gestión, necesita responder dos preguntas en un solo gráfico: <em>¿Cuánto vendimos en volumen monetario?</em> y <em>¿Cuál fue la rentabilidad porcentual de esas ventas?</em></p>
    <p>Dado que las ventas se miden en miles o millones de dólares (escala de 0 a 100.000) y el margen se mide en fracciones porcentuales (escala de 0% a 100%), graficarlos en un solo eje vertical inutiliza la lectura. Un <strong>Gráfico Combinado</strong> asigna el eje vertical izquierdo a las ventas en barras, y crea un eje vertical derecho independiente con escala del 0% al 100% representado por una línea dinámica.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-gear-fill text-primary me-2"></i>2. Paso a Paso para Construir un Gráfico Combinado</h4>
    <ol>
        <li>Seleccionar la tabla de datos que contenga las tres columnas: <code>Mes</code>, <code>Ventas_USD</code> y <code>Margen_%</code>.</li>
        <li>Ir a la pestaña <strong>Insertar ➔ Gráficos recomendados ➔ Cuadro combinado</strong>.</li>
        <li>En la serie <code>Ventas_USD</code>, seleccionar el tipo: <strong>Columnas agrupadas</strong>.</li>
        <li>En la serie <code>Margen_%</code>, seleccionar el tipo: <strong>Línea con marcadores</strong>.</li>
        <li>Marcar la casilla de verificación <strong>Eje secundario</strong> al lado de la serie <code>Margen_%</code>.</li>
        <li>Hacer clic en Aceptar.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-graph-up text-primary me-2"></i>3. Incorporación de Líneas de Tendencia Proyectadas</h4>
    <p>Para estimar si las ventas seguirán creciendo o caerán en los próximos tres meses:</p>
    <ul>
        <li>Hacer clic derecho sobre la serie de datos en el gráfico y seleccionar <em>''Agregar línea de tendencia...''</em></li>
        <li>Elegir el modelo <strong>Lineal</strong> (o Polinómico si el negocio tiene alta estacionalidad).</li>
        <li>En la sección ''Extrapolación / Pronóstico'', indicar hacia adelante <code>3 períodos</code>.</li>
        <li>Marcar la casilla <em>''Presentar el valor R cuadrado en el gráfico''</em>: si el valor R² supera 0.85, la tendencia matemática es altamente confiable para proyecciones presupuestarias.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Saturar el gráfico con líneas de cuadrícula y etiquetas redundantes:</strong> Si cada barra ya tiene una etiqueta de datos con el número encima, el eje vertical izquierdo sobra por completo y debe eliminarse para limpiar el espacio visual.</li>
        <li><strong>Truncar el eje vertical en gráficos de barras:</strong> En gráficos de barras, el eje numérico DEBE comenzar obligatoriamente en cero (0). Si inicias el eje en 80.000 para resaltar diferencias mínimas, estás manipulando visualmente la percepción de los datos, lo que es considerado una mala práctica ética en finanzas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Configuraste el eje secundario para separar montos monetarios de tasas porcentuales?</li>
            <li>¿Comprobaste que el eje vertical de tus gráficos de barras inicie obligatoriamente en cero?</li>
            <li>¿Agregaste títulos de eje claros especificando las unidades monetarias (USD, Bs, Millares)?</li>
        </ul>
    </div>
</div>', 'Domina la graficación profesional: gráficos combinados (Columnas + Líneas) con Eje Secundario para comparar montos en dólares contra porcentajes de margen, y cálculo de líneas de tendencia predictivas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (64, 64, 'Estandarización Corporativa con Plantillas Maestras y Efecto Morph (Transformación)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-collection-play-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">El Patrón de Diapositivas: Blindar la Identidad Visual de la Empresa</h5>
            <p class="mb-0 small">Pegar el logotipo corporativo a mano en cada una de las 40 diapositivas es una pérdida de tiempo que provoca que el logo quede chueco o con tamaños diferentes en cada lámina. Con el Patrón de Diapositivas lo fijas una sola vez y se propaga a todo el archivo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/2rU_g5WAYGc" title="Cómo usar el PATRÓN DE DIAPOSITIVAS en PowerPoint" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es el Patrón de Diapositivas (Slide Master)?</h4>
    <p>El <strong>Patrón de Diapositivas</strong> es la ''capa invisible'' que gobierna el diseño de toda la presentación. Todo lo que coloques en la diapositiva maestra superior (logotipos, número de página, pie de página confidencial, colores institucionales y fuentes) se bloquea en las diapositivas normales de trabajo, impidiendo que los usuarios lo muevan o borren por error.</p>
    <p>Para ingresar al editor maestro:</p>
    <ol>
        <li>Ir a la pestaña <strong>Vista ➔ Patrón de diapositivas</strong>.</li>
        <li>Hacer clic en la diapositiva número 1 ubicada arriba del todo (la Diapositiva Maestra Principal).</li>
        <li>Insertar el logotipo oficial de la empresa en la esquina superior y configurar las fuentes corporativas.</li>
        <li>Hacer clic en <strong>Cerrar vista patrón</strong>. A partir de ese instante, cualquier diapositiva nueva que agregues ya vendrá automáticamente con el logotipo perfecto en su lugar.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-magic text-primary me-2"></i>2. La Transición ''Transformación'' (Morph): Animaciones Cinemáticas sin Esfuerzo</h4>
    <p>La transición <strong>Transformación (Morph)</strong> analiza automáticamente los objetos compartidos entre dos diapositivas consecutivas y calcula una animación fluida de movimiento, tamaño y posición sin necesidad de programar complejas trayectorias de animación manuales:</p>
    <ul>
        <li><strong>Ejemplo Práctico en Negocios:</strong> En la diapositiva 1 tienes una vista general del mapa del país con cuatro sucursales pequeñas. En la diapositiva 2 duplicas la lámina, agrandas el círculo de la sucursal Caracas al centro de la pantalla y aplicas la transición <em>Transformación</em>. Al proyectar, la cámara hará un zoom suave y profesional hacia la sucursal como si fuera una producción audiovisual de televisión.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-card-image text-primary me-2"></i>3. Creación de Marcadores de Posición Personalizados (Placeholders)</h4>
    <p>En el Patrón de Diapositivas puedes insertar <strong>Marcadores de Posición</strong> (para imágenes, texto, tablas o gráficos). Cuando un miembro de tu equipo utilice tu plantilla, solo verá un botón que dice <em>''Haga clic para agregar imagen''</em>: la foto que suba se recortará y adaptará automáticamente al tamaño y forma geométrica definida sin deformar la diapositiva.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Editar el texto de trabajo dentro del Patrón de Diapositivas:</strong> El Patrón solo debe contener elementos estructurales vacíos y marcadores; nunca redactes el contenido específico de tu presentación dentro de la vista patrón porque se repetirá en todas las láminas.</li>
        <li><strong>No cambiar los nombres de los objetos para la transición Morph compleja:</strong> Si deseas transformar un círculo en un cuadrado con la transición Morph, debes abrir el Panel de Selección (<code>Alt + F10</code>) y anteponer dos signos de exclamación al nombre de ambos objetos (ej: <code>!!Figura1</code>) para forzar a PowerPoint a vincularlos en la transformación.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Configuraste los logotipos corporativos en el Patrón de Diapositivas para evitar que se muevan?</li>
            <li>¿Utilizaste la transición Transformación (Morph) para zooms ejecutivos en gráficos y mapas?</li>
            <li>¿Creaste marcadores de posición de imagen para que tu equipo mantenga la estética uniforme?</li>
        </ul>
    </div>
</div>', 'Domina el Patrón de Diapositivas (Slide Master) para crear plantillas institucionales inmutables con logotipos y tipografías fijas. Aplica la transición Transformación (Morph) para animaciones ejecutivas fluidas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (24, 24, 'Productividad 10x en las Tareas Administrativas Diarias', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-speedometer2 fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">De la Teoría a la Automatización del Trabajo Diario</h5>
            <p class="mb-0 small">El verdadero valor de la Inteligencia Artificial en la oficina no es responder preguntas curiosas, sino eliminar horas de tareas administrativas repetitivas como minutas, auditoría de contratos y formulación de hojas de cálculo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/ICqv3erKd84" title="Cómo calcular las horas trabajadas en excel" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Automatización de Minutas y Acuerdos de Reunión</h4>
    <p>Uno de los mayores sumideros de tiempo en las organizaciones es redactar las actas de reunión. Durante una sesión de trabajo de 60 minutos se toman notas rápidas y fragmentadas. Con un prompt bien estructurado, es posible transformar esos apuntes en un documento formal institucional en menos de 30 segundos.</p>
    <p>Para lograrlo, se instruye al modelo para que aplique la estructura estándar de minutas corporativas: <strong>Objetivo de la Sesión, Asistentes Clave, Temas Discutidos, Acuerdos Formalizados y Matriz RACI de Responsables con Fechas Límite</strong>.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-file-earmark-diff-fill text-primary me-2"></i>2. Análisis y Comparativa de Propuestas de Proveedores</h4>
    <p>Cuando un analista de compras recibe tres cotizaciones técnicas de 15 páginas cada una, comparar términos comerciales, tiempos de entrega y coberturas de garantía manualmente toma medio día de trabajo. Con la capacidad de lectura documental de Gemini, se puede cargar el contenido o texto de las tres ofertas y ejecutar un prompt de análisis comparativo:</p>
    <div class="card border-0 bg-light p-3 mb-3 rounded-3">
        <p class="small mb-0 font-monospace text-dark">
            "Actúa como Especialista en Licitaciones Corporativas. A continuación te pego las cotizaciones de Proveedor A, Proveedor B y Proveedor C para la adquisición de 50 equipos de cómputo.<br />
            Genera una matriz comparativa en formato tabla Markdown con las siguientes columnas obligatorias:<br />
            1. Proveedor | 2. Precio Unitario USD | 3. Precio Total con IVA | 4. Tiempo de Entrega en Días Hábiles | 5. Cobertura de Garantía | 6. Condiciones de Pago | 7. Puntos Críticos de Riesgo.<br />
            Al pie de la tabla, incluye un párrafo de veredicto con la opción más costo-eficiente argumentada técnicamente."
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-file-earmark-spreadsheet-fill text-primary me-2"></i>3. Generación y Depuración de Fórmulas Complejas de Excel</h4>
    <p>Muchos profesionales pierden horas buscando en foros de internet cómo anidar funciones complejas como <code>BUSCARX</code>, <code>INDICE/COINCIDIR</code> o <code>SUMAR.SI.CONJUNTO</code>. Para que la IA proporcione la fórmula exacta sin fallos de sintaxis en español, se debe seguir la regla de los tres datos clave:</p>
    <ol>
        <li><strong>Nombres exactos de las hojas y rangos de celdas:</strong> Especificar dónde están los datos de búsqueda y dónde debe escribirse el resultado.</li>
        <li><strong>Criterio lógico de negocio:</strong> Explicar claramente la condición (''si la fecha es menor a hoy y el estado es Pendiente'').</li>
        <li><strong>Idioma y versión de Excel:</strong> Indicar si se utiliza Excel en español (con punto y coma <code>;</code> como separador de argumentos) o en inglés (con coma <code>,</code>).</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos y Prevención</h4>
    <ul>
        <li><strong>Copiar fórmulas a ciegas sin verificar los separadores regionales:</strong> Si tu Excel está configurado con separador de listas punto y coma (<code>;</code>) y copias una fórmula con comas generada para el estándar estadounidense, Excel arrojará un error de sintaxis inmediato.</li>
        <li><strong>No auditar las cifras de las cotizaciones:</strong> Siempre verifica que la IA haya transcrito exactamente las cantidades numéricas de las cotizaciones originales antes de someter el informe al comité directivo.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Estandarizaste el formato de tus actas para que cada acuerdo tenga responsable con nombre y fecha exacta de entrega?</li>
            <li>¿Probaste las fórmulas generadas con al menos dos filas de datos de prueba antes de arrastrarlas a toda la base de datos?</li>
            <li>¿Verificaste que la tabla comparativa refleje los montos con sus respectivos impuestos de ley?</li>
        </ul>
    </div>
</div>', 'Implementa flujos de trabajo de alta velocidad para convertir notas sucias en actas corporativas pulidas, comparar contratos de proveedores y redactar fórmulas avanzadas de Excel a partir de necesidades en lenguaje natural.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (25, 25, 'Uso Ético de la IA: Qué Subir y Qué NUNCA Compartir', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-lock-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Seguridad Informática y Responsabilidad Legal</h5>
            <p class="mb-0 small">El uso irresponsable de la IA pública ha provocado despidos disciplinarios y demandas judiciales en corporaciones globales debido a la filtración de código fuente propietario, nóminas de sueldos e historiales médicos de clientes.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/zvzwh8r0ABY" title="Implementación de privacidad y protección de datos - Curso de ética en el análisis de datos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Anatomía y Origen de las Alucinaciones en LLMs</h4>
    <p>En el ámbito de la inteligencia artificial, una <strong>alucinación</strong> no es un fallo temporal del software ni un virus informático; es el resultado intrínseco de cómo operan los modelos de lenguaje. Dado que el sistema siempre busca generar una respuesta lingüísticamente persuasiva y estadísticamente plausible, cuando carece de datos fácticos sobre un tema oscuro, en lugar de reconocer ''no lo sé'', puede inventar con absoluta seguridad citas bibliográficas inexistentes, sentencias judiciales inventadas o números contables falsos.</p>
    <p>Por esta razón, la regla de oro para cualquier profesional es: <em>''La IA nunca tiene la última palabra; la responsabilidad legal, ética y operativa ante la dirección siempre pertenece al profesional humano que firma el reporte''</em>.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-x text-danger me-2"></i>2. Qué Datos NUNCA Deben Subirse a Modelos de IA Públicos</h4>
    <p>A menos que tu empresa disponga de una instancia empresarial privada (Enterprise) con contrato formal de confidencialidad y cláusula de no-entrenamiento (como Gemini for Workspace Enterprise o ChatGPT Team/Enterprise), debes considerar cualquier plataforma pública como un entorno expuesto. Está terminantemente prohibido introducir:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-danger">
                <tr>
                    <th>Categoría de Información</th>
                    <th>Ejemplos Concretos</th>
                    <th>Riesgo Laboral / Sanción</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold">Datos Personales Identificables (PII)</td>
                    <td>Cédulas de identidad, nombres completos de clientes, números de teléfono, correos personales, historias clínicas.</td>
                    <td>Violación de leyes de protección de datos, multas regulatorias y despido por justa causa.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Secretos Comerciales e Industriales</td>
                    <td>Fórmulas químicas, algoritmos propietarios, márgenes de utilidad confidenciales, costos unitarios de importación.</td>
                    <td>Pérdida de ventaja competitiva y demandas civiles por revelación de secretos empresariales.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Credenciales y Cuentas de Acceso</td>
                    <td>Claves de servidores, contraseñas de correos institucionales, tokens de API de bases de datos, números de tarjetas de crédito.</td>
                    <td>Ataques de ransomware y hackeo masivo a la infraestructura de la empresa.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-success me-2"></i>3. Protocolo de Anonimización y Ofuscación de Datos</h4>
    <p>Si necesitas que la IA analice un caso comercial complejo o un conflicto entre empleados, puedes aprovechar su potencial sin violar ninguna política de seguridad aplicando el <strong>Protocolo de Anonimización Previa</strong>:</p>
    <ol>
        <li><strong>Reemplazo de Nombres Propios:</strong> Convierte ''Lic. Juan Pérez de Distribuidora Caracas C.A.'' en <code>[Gerente de Ventas - Empresa Proveedor A]</code>.</li>
        <li><strong>Normalización de Cifras Sensibles:</strong> Si los ingresos reales son de $485.320 USD, puedes multiplicar todas las cifras por un factor neutro (ej: dividir entre 10) o usar porcentajes relativos en lugar de los montos absolutos.</li>
        <li><strong>Eliminación de Direcciones IP y Rutas de Red:</strong> Reemplaza direcciones de servidores internos por nombres ficticios como <code>servidor-principal.local</code>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confiar en citas de leyes o artículos de código civil sin contrastar:</strong> Los modelos suelen mezclar legislaciones de diferentes países (ej: citar el Código Civil español en un caso laboral venezolano o mexicano). Siempre verifica el texto de la ley en la gaceta oficial vigente.</li>
        <li><strong>Asumir que borrar el chat de la pantalla elimina los datos de los servidores:</strong> En cuentas gratuitas públicas, los datos pueden permanecer en logs de auditoría o ser utilizados para entrenar versiones futuras del modelo si no se ha desactivado manualmente la opción en la configuración de privacidad.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Revisaste que el texto a enviar no contenga números de cédula, cuentas bancarias ni claves de acceso?</li>
            <li>¿Verificaste manualmente cada cifra matemática y cada referencia normativa citada por la IA?</li>
            <li>¿Consultaste con el departamento de TI las políticas internas de la empresa sobre el uso autorizado de herramientas de IA generativa?</li>
        </ul>
    </div>
</div>', 'Protege a tu organización y tu carrera profesional: aprende qué es una alucinación, cómo aplicar protocolos de anonimización (DLP) y cómo respetar las normas internacionales de privacidad sin comprometer la productividad.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (134, 134, 'Fortificación de Identidades: Más Allá de la Clave Tradicional', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-key-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Contraseña Única ya NO es Suficiente</h5>
            <p class="mb-0 small">Las contraseñas débiles o reutilizadas son la causa principal de secuestro de cuentas corporativas. La autenticación moderna requiere combinar factores de conocimiento, posesión e inherencia para garantizar la seguridad.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/xkxYPon37eY" title="Qué es MFA (Autenticación Multifactor) y cómo se usa" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Entropía y Ataques de Fuerza Bruta</h4>
    <p>Las computadoras actuales pueden probar miles de millones de combinaciones de contraseñas por segundo utilizando tarjetas gráficas modernas y tablas precalculadas (Rainbow Tables). Una contraseña como <code>Empresa2024*</code> parece compleja para un ser humano, pero sigue un patrón predecible de diccionario que los programas de ataque descubren en menos de 3 minutos.</p>
    <p>La <strong>entropía</strong> mide la impredecibilidad matemática de una contraseña. El estándar moderno recomienda usar <em>frases de contraseña (passphrases)</em> de al menos 16 a 20 caracteres formadas por 4 o 5 palabras aleatorias sin conexión lógica (ejemplo: <code>camion-jirafa-teclado-naranja-velero</code>). Estas frases son extremadamente fáciles de memorizar para un ser humano, pero computacionalmente imposibles de descifrar por fuerza bruta (tomaría cientos de miles de años de cálculo).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-lock text-primary me-2"></i>2. Los Tres Factores de Autenticación (MFA)</h4>
    <p>La <strong>Autenticación Multifactor (MFA)</strong> exige que el usuario demuestre su identidad combinando al menos dos de las siguientes tres categorías independientes:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">1. Algo que Sabes</span>
                <p class="small mb-0">Información memorizada: Contraseña maestra, código PIN personal o respuestas a preguntas de desafío.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">2. Algo que Tienes</span>
                <p class="small mb-0">Un dispositivo físico en tu posesión: Teléfono móvil con app autenticadora (TOTP como Google Authenticator o Microsoft Authenticator), o llave criptográfica USB física (YubiKey / FIDO2).</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-warning text-dark mb-2">3. Algo que Eres</span>
                <p class="small mb-0">Biometría física única: Huella dactilar, reconocimiento facial por infrarrojos (Windows Hello / FaceID) o escaneo de iris.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-safe2-fill text-primary me-2"></i>3. Gestores de Contraseñas Corporativos (Password Managers)</h4>
    <p>El cerebro humano no está diseñado para recordar 50 contraseñas diferentes de 20 caracteres cada una. La consecuencia inevitable es que los empleados reutilizan la misma contraseña en el correo del trabajo, en su banco y en tiendas online. Si una tienda online secundaria sufre una filtración, los cibercriminales prueban esa misma clave en el correo corporativo (ataque de <em>Credential Stuffing</em>).</p>
    <p>La solución profesional obligatoria es el uso de <strong>Gestores de Contraseñas</strong> (como Bitwarden, 1Password o KeePass). Estos programas cifran todas las contraseñas bajo un algoritmo de grado militar (AES-256) protegido por una única clave maestra robusta combinada con MFA.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confiar en el SMS como segundo factor:</strong> Los mensajes de texto SMS no están cifrados y son vulnerables a clonación de línea telefónica mediante ataques de <em>SIM Swapping</em>. Siempre que el sistema lo permita, utiliza aplicaciones TOTP autenticadoras en lugar de SMS.</li>
        <li><strong>Anotar contraseñas en notas adhesivas (Post-its) en el monitor:</strong> Esto anula toda la inversión tecnológica de la empresa al exponer las credenciales a cualquier visitante físico o personal de limpieza en la oficina.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Tienes activada la Verificación en Dos Pasos (MFA) en tu correo corporativo y cuentas principales?</li>
            <li>¿Cada una de tus cuentas laborales cuenta con una contraseña totalmente distinta a las demás?</li>
            <li>¿Utilizas un gestor de contraseñas cifrado en lugar de guardarlas en un archivo de bloc de notas o Excel?</li>
        </ul>
    </div>
</div>', 'Comprende la matemática detrás de la entropía de contraseñas, la vulnerabilidad de ataques de fuerza bruta y por qué el doble factor de autenticación (TOTP/FIDO2) es el estándar obligatorio corporativo.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (135, 135, 'Defensa Activa ante Ataques Destructivos y Fugas de Tráfico', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-radioactive fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Ransomware: La Mayor Amenaza a la Continuidad del Negocio</h5>
            <p class="mb-0 small">El Ransomware no solo paraliza las operaciones de empresas de cualquier tamaño, sino que amenaza con publicar bases de datos de clientes si no se pagan rescates millonarios en criptomonedas. La prevención y los respaldos inmutables son la única defensa real.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/czuyM80wJJI" title="💻🚨 Malware: La Amenaza Oculta que Puede Robarte TODO🚨💻" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Cómo Opera el Ransomware Moderno? El Ciclo de Doble Extorsión</h4>
    <p>El <strong>Ransomware</strong> es un tipo de malware que se infiltra silenciosamente en los equipos de la red corporativa. A diferencia de los virus antiguos que dañaban el sistema inmediatamente, el ransomware moderno permanece oculto durante semanas (fase de reconocimiento) mapeando todos los servidores compartidos y eliminando copias de sombra locales (Shadow Copies).</p>
    <p>Una vez posicionado, ejecuta un cifrado asimétrico ultraveloz (RSA + AES) sobre todos los documentos comerciales, bases de datos y hojas de cálculo, cambiando sus extensiones y dejando una nota de rescate en el escritorio. Además, hoy en día aplican la <strong>Doble Extorsión</strong>: antes de cifrar, exfiltran gigabytes de contratos confidenciales para amenazar con publicarlos en internet si la directiva no paga el rescate.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-wifi text-primary me-2"></i>2. Vulnerabilidades en Redes Wi-Fi y Ataques Man-in-the-Middle (MitM)</h4>
    <p>Cuando un trabajador en modalidad remota o en viaje de negocios se conecta a la red Wi-Fi abierta de una cafetería, hotel o aeropuerto sin protección, se expone a ataques de intermediario (<em>Man-in-the-Middle</em>):</p>
    <ul>
        <li><strong>Gemelo Malvado (Evil Twin):</strong> El atacante levanta una red Wi-Fi falsa con el mismo nombre del hotel (ej: <code>Hotel_Guest_Free</code>). El computador del usuario se conecta automáticamente y todo el tráfico no cifrado fluye a través de la máquina del ciberdelincuente.</li>
        <li><strong>Red Privada Virtual (VPN) como Escudo:</strong> La regla de oro corporativa al conectarse a cualquier red externa es iniciar de inmediato una <strong>VPN (Virtual Private Network)</strong> institucional. La VPN crea un túnel cifrado punto a punto que encapsula los datos, impidiendo que cualquiera en la red local pueda espiar credenciales o paquetes transmitidos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico de Oficina: Protocolo de Aislamiento Inmediato ante Infección</h4>
    <div class="card border-0 bg-light p-3 rounded-3 mb-4">
        <h6 class="fw-bold text-dark mb-2">Si notas que tus archivos cambian de icono repentinamente o aparece una pantalla de advertencia exigiendo un rescate:</h6>
        <ol class="small mb-0">
            <li><strong>Desconectar inmediatamente el cable de red RJ45 y apagar el Wi-Fi:</strong> Esto corta la propagación lateral del ransomware hacia otros computadores y servidores compartidos de la empresa.</li>
            <li><strong>NO apagar el computador bruscamente:</strong> Déjalo encendido pero desconectado de la red. Apagarlo puede borrar evidencias clave en la memoria RAM que los peritos forenses necesitan para extraer llaves de descifrado.</li>
            <li><strong>Notificar por teléfono de inmediato al Administrador de Sistemas:</strong> Informa la hora exacta del suceso y qué carpetas estaban abiertas.</li>
            <li><strong>NUNCA contactar a los atacantes ni intentar pagar rescates por cuenta propia:</strong> Pagar no garantiza recibir la clave y financia actividades criminales organizadas.</li>
        </ol>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mantener discos duros de respaldo conectados permanentemente al computador:</strong> Si un disco USB de respaldo está conectado a la máquina cuando se activa el ransomware, el malware cifrará tanto los archivos del computador como los del respaldo.</li>
        <li><strong>Desactivar el firewall de Windows o los antivirus para instalar programas piratas:</strong> El software craqueado suele contener troyanos durmientes diseñados para otorgar acceso remoto a bandas de cibercrimen.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Tu sistema operativo y programas de oficina están actualizados con los últimos parches de seguridad?</li>
            <li>¿Utilizas siempre una VPN corporativa cuando trabajas desde redes Wi-Fi externas o públicas?</li>
            <li>¿Tienes claro a quién llamar de inmediato en tu empresa en caso de detectar un comportamiento anómalo en tu computador?</li>
        </ul>
    </div>
</div>', 'Analiza el funcionamiento del Ransomware moderno (cifrado asimétrico forzado y doble extorsión), los riesgos del espionaje en redes Wi-Fi públicas y la configuración de defensas con VLANs y VPNs.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (9, 9, 'Cómo la Tecnología Redefine Modelos de Negocio Tradicionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-rocket-takeoff-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Transformación Digital: Rediseñar Procesos, no solo Comprar Software</h5>
            <p class="mb-0 small">Digitalizar un proceso burocrático y desordenado solo produce un proceso burocrático digitalizado más costoso. La transformación real comienza por simplificar el flujo de trabajo y empoderar a las personas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/EBe51Q7-62k" title="La Revolución Digital: Cómo Cambió Todo" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es la Transformación Digital en las Empresas Reales?</h4>
    <p>Existe la creencia equivocada de que transformar digitalmente una empresa significa comprar computadoras nuevas, escanear papeles o abrir una cuenta de Instagram. En el mundo corporativo contemporáneo, la <strong>Transformación Digital</strong> es la integración estratégica de tecnología en todas las áreas del negocio, provocando un cambio fundamental en cómo la empresa opera y cómo entrega valor a sus clientes.</p>
    <p>Implica derribar los <em>silos de información</em> (departamentos que no se comunican entre sí y guardan datos en hojas de cálculo aisladas) para crear una organización impulsada por datos (<em>Data-Driven Organization</em>), donde las decisiones de inventario, contratación y precios se toman con métricas en tiempo real y no por intuiciones personales de la gerencia.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-people-fill text-primary me-2"></i>2. Gestión del Cambio Cultural y Resistencia del Personal</h4>
    <p>El 70% de las iniciativas de digitalización en empresas fracasan no por problemas en los servidores, sino por la resistencia humana al cambio. Los colaboradores temen que los nuevos sistemas informáticos aumenten su carga de trabajo o amenacen su estabilidad laboral.</p>
    <p>Para mitigar este obstáculo, los líderes de proyectos deben aplicar metodologías probadas de gestión del cambio (como el modelo <strong>ADKAR</strong>):</p>
    <div class="row g-2 mb-4">
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>A</strong>wareness<br /><span class="text-muted">Consciencia del por qué cambiar</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>D</strong>esire<br /><span class="text-muted">Deseo de apoyar el proyecto</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>K</strong>nowledge<br /><span class="text-muted">Conocimiento mediante capacitación</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>A</strong>bility<br /><span class="text-muted">Habilidad práctica en el puesto</span></div></div>
        <div class="col-md"><div class="p-2 bg-light border rounded text-center small"><strong>R</strong>einforcement<br /><span class="text-muted">Refuerzo continuo y métricas</span></div></div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-bar-chart-steps text-primary me-2"></i>3. Los 4 Niveles de Madurez Digital de una Empresa</h4>
    <ol>
        <li><strong>Nivel 1: Analógico / Desconectado:</strong> Procesos en papel, carpetas de archivo físico, comunicación por llamadas telefónicas no registradas y control contable en cuadernos o archivos locales individuales.</li>
        <li><strong>Nivel 2: Digitalizado Básico:</strong> Uso generalizado de hojas de cálculo de Excel para todo, correos electrónicos gratuitos y almacenamiento disperso en computadoras individuales. Alto riesgo de pérdida de datos.</li>
        <li><strong>Nivel 3: Integrado en Servidores / Nube:</strong> Uso de un sistema ERP o CRM centralizado, carpetas compartidas con permisos de seguridad y copias de seguridad automáticas.</li>
        <li><strong>Nivel 4: Optimizado e Inteligente:</strong> Automatización de flujos con bots o scripts (RPA), tableros ejecutivos en Power BI conectados en vivo y aplicación de algoritmos de IA predictiva para anticipar la demanda de inventario.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Implementar software costoso sin capacitar al equipo operativo:</strong> Comprar licencias de miles de dólares para que los empleados sigan usando cuadernos paralelos porque no entienden el software es una de las mayores fuentes de pérdida de capital en las empresas.</li>
        <li><strong>Digitalizar sin liderazgo visible de la Dirección General:</strong> Si los directores no utilizan el sistema y siguen pidiendo reportes impresos en papel, los mandos medios abandonarán el uso de la plataforma digital.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Se involucró a los usuarios finales operativos en las pruebas de selección del nuevo software?</li>
            <li>¿Se diseñó un plan formal de inducción y capacitación con manuales prácticos paso a paso?</li>
            <li>¿Se definieron indicadores clave (KPIs) para medir la reducción de tiempos de proceso tras la digitalización?</li>
        </ul>
    </div>
</div>', 'Descubre qué es verdaderamente la Transformación Digital, cómo superar la resistencia al cambio en los equipos de trabajo y cómo evaluar la madurez tecnológica de una organización.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (90, 90, 'Selección, Implementación y Retorno de Inversión (ROI) en Software', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-3-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">ERP y CRM: Integrar para Conquistar el Mercado</h5>
            <p class="mb-0 small">Una empresa que crece sin un ERP centralizado se convierte en un archipiélago caótico de hojas de Excel donde compras no sabe qué vendió ventas, y finanzas no sabe si hay inventario real para cobrar.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/TLztJtLmKMw" title="SAP ERP: La Columna Vertebral de la Gestión Empresarial | Aprende con PRIME INSTITUTE" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ERP vs CRM: ¿Cuál es la Diferencia y Cómo se Complementan?</h4>
    <p>Aunque ambos son sistemas de software empresarial, cumplen roles totalmente distintos pero simbióticos en la cadena de valor:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2"><i class="bi bi-gear-wide-connected me-2"></i>ERP (Enterprise Resource Planning)</h5>
                <p class="small text-muted mb-2">Mira hacia el <strong>interior y la operación</strong> de la empresa. Gestiona los recursos materiales, productivos y financieros necesarios para cumplir los pedidos.</p>
                <ul class="small mb-0">
                    <li>Contabilidad general, tesorería y cuentas por pagar/cobrar.</li>
                    <li>Gestión de inventarios, almacenes y movimientos de stock.</li>
                    <li>Planificación de compras, órdenes y recepción de mercancía.</li>
                    <li>Facturación legal y liquidación de nóminas de empleados.</li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-success mb-2"><i class="bi bi-people-fill me-2"></i>CRM (Customer Relationship Management)</h5>
                <p class="small text-muted mb-2">Mira hacia el <strong>exterior y el cliente</strong>. Gestiona todas las interacciones, oportunidades comerciales y el ciclo de vida de los prospectos.</p>
                <ul class="small mb-0">
                    <li>Seguimiento de prospectos (leads) y embudos de ventas.</li>
                    <li>Historial completo de llamadas, correos y reuniones con clientes.</li>
                    <li>Automatización de campañas de marketing y fidelización.</li>
                    <li>Módulo de servicio postventa, garantías y resolución de quejas.</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-check2-circle text-primary me-2"></i>2. Las 5 Fases de una Implementación Exitosa de ERP</h4>
    <p>La adopción de un sistema como SAP Business One, Odoo, Oracle o Microsoft Dynamics debe ejecutarse bajo una metodología estricta para evitar sobrecostos catastróficos:</p>
    <ol>
        <li><strong>Fase 1: Levantamiento de Procesos (As-Is):</strong> Documentar detalladamente cómo opera la empresa hoy en día, identificando cuellos de botella y redundancias antes de tocar el software.</li>
        <li><strong>Fase 2: Diseño del Modelo Objetivo (To-Be):</strong> Parametrizar el software para que se adapte a las mejores prácticas de la industria, evitando en lo posible hacer desarrollos a la medida innecesarios que compliquen futuras actualizaciones.</li>
        <li><strong>Fase 3: Migración y Depuración de Datos Maestros:</strong> Limpiar las bases de datos de clientes, proveedores y artículos (eliminando duplicados, productos obsoletos y saldos descuadrados) antes de cargarlos al nuevo sistema.</li>
        <li><strong>Fase 4: Pruebas Integrales de Usuario (UAT):</strong> El personal operativo realiza simulaciones completas del ciclo de venta, compra y facturación en un entorno de pruebas controlado.</li>
        <li><strong>Fase 5: Salida en Vivo (Go-Live) y Soporte Hipercare:</strong> Inicio de la operación real con acompañamiento técnico continuo durante los primeros 30 días para resolver incidencias de arranque.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Migrar datos ''sucios'' del sistema anterior:</strong> Si exportas una base de datos con clientes duplicados y códigos de inventario mal escritos, el nuevo ERP generará informes erróneos desde el primer día de operación.</li>
        <li><strong>Exceso de personalizaciones y código a medida:</strong> Intentar que el ERP haga exactamente lo mismo que hacía la hoja de cálculo antigua encarece el proyecto en un 300% y vuelve imposible actualizar el sistema a nuevas versiones.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Se depuraron y estandarizaron los catálogos de artículos y clientes antes de la migración?</li>
            <li>¿Se asignaron líderes funcionales por cada área (Compras, Ventas, Contabilidad) con tiempo dedicado al proyecto?</li>
            <li>¿Se realizaron pruebas piloto completas con facturas reales antes de apagar el sistema antiguo?</li>
        </ul>
    </div>
</div>', 'Domina la diferencia estructural entre un ERP (Enterprise Resource Planning) y un CRM (Customer Relationship Management). Aprende a auditar procesos y liderar implementaciones exitosas sin frenar las ventas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (91, 91, 'Gestión del Riesgo Tecnológico para Directores y Líderes de Área', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-fill-exclamation fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Ciberseguridad es una Responsabilidad del Consejo Directivo</h5>
            <p class="mb-0 small">Los ciberataques ya no son solo problemas del departamento de sistemas; son riesgos corporativos estratégicos capaces de destruir la cotización bursátil, la confianza de los clientes y la solvencia financiera de la compañía.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/0IS6CDpBcfs" title="BCP, DRP y Gestión de Crisis: diferencias explicadas fácil" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. BCP vs DRP: Los Dos Escudos de la Resiliencia Corporativa</h4>
    <p>En el nivel directivo, es vital dominar la complementariedad entre los dos planes de contingencia más importantes de la organización:</p>
    <ul>
        <li><strong>BCP (Business Continuity Plan - Plan de Continuidad de Negocio):</strong> De alcance <strong>empresarial e integral</strong>. Define cómo la organización continuará operando sus funciones vitales durante una crisis (por ejemplo: si se incendia la sede principal o cae el sistema central, cómo los empleados continuarán atendiendo clientes por teléfono desde sedes alternas o en teletrabajo de emergencia).</li>
        <li><strong>DRP (Disaster Recovery Plan - Plan de Recuperación ante Desastres):</strong> De alcance <strong>estrictamente técnico y de TI</strong>. Se enfoca en los procedimientos paso a paso para restaurar los servidores, bases de datos, redes y aplicaciones de software afectadas hasta devolverlos a su estado normal de operación.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-grid-3x3-gap-fill text-primary me-2"></i>2. Construcción de una Matriz de Riesgos Tecnológicos</h4>
    <p>Para priorizar las inversiones de protección sin gastar dinero a ciegas, los directores deben construir y mantener actualizada la <strong>Matriz de Riesgos IT</strong> evaluando cada amenaza bajo la fórmula universal:</p>
    <div class="p-3 bg-light rounded text-center my-3">
        <code class="fs-6 fw-bold">Nivel de Riesgo = Probabilidad de Ocurrencia (1 a 5) × Impacto Financiero y Reputacional (1 a 5)</code>
    </div>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Escenario de Riesgo</th>
                    <th>Probabilidad</th>
                    <th>Impacto</th>
                    <th>Estrategia de Mitigación Obligatoria</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Infección masiva de Ransomware en servidores centrales</td>
                    <td class="text-center">Media (3)</td>
                    <td class="text-center text-danger fw-bold">Catastrófico (5)</td>
                    <td>Respaldos inmutables WORM fuera de sitio + MFA universal en todas las cuentas de administración.</td>
                </tr>
                <tr>
                    <td>Caída del enlace principal de internet durante día de ventas</td>
                    <td class="text-center text-warning fw-bold">Alta (4)</td>
                    <td class="text-center">Moderado (3)</td>
                    <td>Contratación de un enlace de internet secundario con tecnología distinta (Fibra Óptica + Enlace Satelital/4G).</td>
                </tr>
                <tr>
                    <td>Filtración de base de datos de clientes por empleado desleal</td>
                    <td class="text-center">Baja (2)</td>
                    <td class="text-center text-danger fw-bold">Catastrófico (5)</td>
                    <td>Políticas de Privilegio Mínimo (Zero Trust), cifrado de bases de datos y acuerdos de confidencialidad reforzados.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-megaphone-fill text-primary me-2"></i>3. Gestión de Comunicación en Crisis y Protección de Marca</h4>
    <p>Cuando ocurre una brecha de seguridad (por ejemplo, una filtración de datos), el daño reputacional puede ser diez veces más costoso que el daño técnico. Las mejores prácticas de comunicación en crisis exigen:</p>
    <ol>
        <li><strong>Comité de Crisis Activado:</strong> Conformado por el Director General (CEO), Director de TI (CTO), Director Legal y Director de Comunicaciones.</li>
        <li><strong>Transparencia Controlada:</strong> Admitir el incidente ante las autoridades y clientes afectados en los plazos legales, explicando qué medidas correctivas inmediatas se implementaron para blindar el sistema.</li>
        <li><strong>Canal Único de Vocería:</strong> Ningún empleado individual puede emitir declaraciones o comentarios en redes sociales sobre el incidente; toda comunicación oficial debe provenir exclusivamente del portavoz designado.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ocultar una brecha de seguridad a los clientes:</strong> Ocultar un hackeo suele terminar en filtraciones públicas peores, destruyendo irreversiblemente la confianza comercial y atrayendo multas regulatorias masivas.</li>
        <li><strong>Considerar el plan de continuidad como un documento estático de biblioteca:</strong> Si el BCP fue redactado hace 4 años y cita nombres de personas que ya no trabajan en la empresa o sistemas que ya no existen, no servirá de nada en una emergencia real.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Cuenta la empresa con una póliza de ciberseguro adecuada a su volumen de facturación?</li>
            <li>¿Se realizan simulacros anuales del Plan de Continuidad de Negocio con todo el equipo directivo?</li>
            <li>¿Están claramente definidos los roles y voceros oficiales ante incidentes de ciberseguridad?</li>
        </ul>
    </div>
</div>', 'Aprende a formular matrices de riesgo tecnológico, establecer planes de continuidad de negocio (BCP) y liderar la respuesta corporativa ante crisis informáticas protegiendo la reputación institucional.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (236, 236, 'Cross-Selling, Upselling y Asesoría Consultiva en el Salón de Ventas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-bag-plus-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">De Despachar Productos a Elevar la Rentabilidad de la Tienda</h5>
            <p class="mb-0 small">Un despachador entrega únicamente lo que el cliente le pide en el mostrador. Un asesor de ventas profesional identifica necesidades no verbalizadas y sugiere complementos que aumentan el valor de la compra y la satisfacción del comprador.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/5DKWyV21R0U" title="Cómo potenciar las ventas cruzadas en tu farmacia o tienda" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Diferencia Estratégica entre Upselling y Cross-Selling</h4>
    <p>En el comercio minorista existen dos palancas maestras para incrementar la facturación sin necesidad de traer más clientes a la tienda:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2"><i class="bi bi-arrow-up-circle-fill me-2"></i>Up-Selling (Venta Escalonada Superior)</h5>
                <p class="small text-muted mb-2">Invitar al cliente a adquirir una <strong>versión superior, de mayor calidad o de mayor capacidad</strong> del mismo producto que ya decidió comprar.</p>
                <p class="small mb-0"><strong>Ejemplo en piso:</strong> Si el cliente pide una pintura básica para su casa, el asesor le explica: <em>''Por solo un 15% más de inversión, esta versión lavable y antihongos le evitará tener que volver a pintar el año que viene, ahorrándole mano de obra''</em>.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-success mb-2"><i class="bi bi-plus-circle-fill me-2"></i>Cross-Selling (Venta Cruzada de Complementos)</h5>
                <p class="small text-muted mb-2">Ofrecer <strong>productos accesorios o complementarios indispensables</strong> que el cliente necesitará para usar correctamente el artículo principal.</p>
                <p class="small mb-0"><strong>Ejemplo en piso:</strong> Si compra la pintura, ofrecer la brocha profesional, la cinta de enmascarar, la bandeja plástica y la lija. Si no se los ofreces, el cliente llegará a casa y no podrá pintar, generándole frustración.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-chat-quote-fill text-primary me-2"></i>2. Las Preguntas de Sondeo Abiertas</h4>
    <p>La peor forma de abordar a un cliente en el piso de venta es preguntar: <em>''¿Le puedo ayudar en algo?''</em> (el 95% responderá automáticamente: <em>''No gracias, solo estoy mirando''</em>). El estándar consultivo exige preguntas abiertas con interés genuino:</p>
    <ul>
        <li><em>''Buenos días, bienvenido. ¿Qué proyecto o arreglo está realizando en casa el día de hoy?''</em></li>
        <li><em>''¿Para qué tipo de ocasión o uso específico necesita este calzado?''</em></li>
        <li><em>''¿Ha probado anteriormente este tipo de material o le gustaría comparar dos opciones de rendimiento?''</em></li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. La Métrica del Ticket Promedio (UPT y ATV)</h4>
    <p>Los supervisores de tienda evalúan a su equipo bajo dos métricas de productividad comercial:</p>
    <ul>
        <li><strong>UPT (Units Per Transaction - Unidades por Ticket):</strong> La cantidad promedio de artículos que el cliente se lleva en cada compra. Si un vendedor tiene un UPT de 1.1 y otro tiene un UPT de 2.4, este último está aplicando venta cruzada de accesorios de forma sobresaliente.</li>
        <li><strong>ATV (Average Transaction Value - Ticket Promedio Monetario):</strong> El monto promedio en dólares de cada compra (Ventas Totales / Cantidad de Clientes atendidos).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ofrecer venta cruzada de productos más caros que el artículo principal:</strong> Si el cliente está comprando un par de calcetines de $5, no le ofrezcas una chaqueta de cuero de $150 en la fila de caja; los productos cruzados en mostrador deben representar entre el 10% y el 25% del valor de la compra principal para que la decisión sea casi automática.</li>
        <li><strong>Insistir agresivamente cuando el cliente ya dijo que no:</strong> La venta cruzada es una sugerencia de servicio orientada a evitar olvidos, no un acoso. Si el cliente declina amablemente, agradécele y procede al cobro rápido con una sonrisa.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Sustituiste ''¿Le ayudo en algo?'' por preguntas abiertas de diagnóstico de necesidades?</li>
            <li>¿Ofreciste siempre el producto complementario indispensable antes de cerrar la cuenta?</li>
            <li>¿Monitoreas semanalmente tus unidades por ticket (UPT) para medir tu eficacia comercial?</li>
        </ul>
    </div>
</div>', 'Pasa de despachador pasivo a asesor comercial de alto impacto. Domina la técnica del Up-selling (versión superior), Cross-selling (productos complementarios) y preguntas de sondeo abiertas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (108, 108, 'Posicionamiento Orgánico, Reputación de Vendedor y Logística de Envíos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cart4 fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Marketplaces: Aprovechar el Tráfico Masivo de Millones de Compradores</h5>
            <p class="mb-0 small">Crear una tienda online propia requiere invertir dinero en publicidad para atraer visitas. En plataformas como Mercado Libre y Facebook Marketplace, los millones de compradores ya están ahí buscando con la tarjeta de crédito en la mano.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/kImOYBjqtK8" title="COMO VENDER MAS EN MARKETPLACE DE FACEBOOK" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Algoritmo de Búsqueda de Mercado Libre</h4>
    <p>Para aparecer en las primeras posiciones cuando un cliente busca un producto, se deben optimizar los factores que alimentan el algoritmo de indexación de Mercado Libre:</p>
    <ul>
        <li><strong>Estructura del Título (SEO):</strong> Máximo 60 caracteres. Producto + Marca + Modelo + Característica Principal (ej: <em>''Taladro Percutor Inalámbrico Bosch 18V Con 2 Baterías y Maletín''</em>). Nunca uses adjetivos vacíos como ''Lindo'', ''Barato'' u ''Original'', ya que nadie busca esas palabras en la barra de búsqueda.</li>
        <li><strong>Ficha Técnica Completa al 100%:</strong> Rellenar todos los atributos específicos (voltaje, dimensiones, peso, material, código universal EAN/UPC). Las publicaciones con ficha técnica completa reciben hasta un 40% más de visibilidad en los filtros de la izquierda.</li>
        <li><strong>Foto Principal con Fondo Blanco Puro:</strong> Mercado Libre exige imágenes de mínimo 1200x1200 píxeles con fondo blanco digital (RGB 255,255,255) sin marcas de agua, bordes ni textos promocionales.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-star-fill text-warning me-2"></i>2. El Termómetro de Reputación: La Obsesión del Color Verde</h4>
    <p>En Mercado Libre, tener el termómetro en <strong>Verde Oscuro (MercadoLíder)</strong> es la diferencia entre vender todos los días o no vender nada. El sistema mide tres métricas implacables:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-danger mb-1">Reclamos del Comprador</h6>
                <p class="small text-muted mb-0">Menos del <strong>1.5% al 2%</strong> de tus ventas pueden tener reclamos abiertos. Un reclamo por producto defectuoso o retraso impacta negativamente tu visibilidad.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-warning text-dark mb-1">Tiempo de Despacho</h6>
                <p class="small text-muted mb-0">Entregar el paquete a la agencia de envíos dentro de las primeras <strong>24 horas hábiles</strong>. Si entregas con retraso, el termómetro se pone amarillo de inmediato.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-light rounded border h-100">
                <h6 class="fw-bold text-primary mb-1">Cancelaciones por el Vendedor</h6>
                <p class="small text-muted mb-0">Menos del <strong>0.5% al 1%</strong> de cancelaciones por falta de stock. Si vendes algo que no tienes en bodega y cancelas la venta, la penalización es severa.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-x text-danger me-2"></i>3. Prevención de Estafas en Facebook Marketplace y Entregas Personales</h4>
    <p>A diferencia de Mercado Libre que cuenta con pasarela integrada (Mercado Pago), Facebook Marketplace opera como un tablón de anuncios clasificados donde el riesgo de fraude es mayor:</p>
    <ul>
        <li><strong>NUNCA entregar productos con comprobantes de transferencia diferida o cheques en tránsito:</strong> La estafa más común consiste en depositar un cheque sin fondos en un cajero un viernes en la tarde; el banco muestra el saldo ''en tránsito o diferido'', el comprador exige la entrega, y el lunes el cheque rebota sin fondos. Solo entrega cuando el dinero esté como <strong>Saldo Disponible</strong>.</li>
        <li><strong>Puntos de Encuentro Seguros:</strong> Si realizas entregas personales, cítate siempre en lugares públicos concurridos a plena luz del día (centros comerciales con vigilancia, estaciones de metro o frente a comandos policiales). Nunca acudas a zonas solitarias o desconocidas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tardar en responder las preguntas de los clientes en Mercado Libre:</strong> Responder en menos de 5 minutos multiplica la probabilidad de compra en un 300%. El comprador está comparando tres pestañas abiertas a la vez; el que contesta primero y con amabilidad se lleva la venta.</li>
        <li><strong>Vender en Marketplace sin sincronizar el inventario físico:</strong> Publicar productos sin verificar existencias te obligará a cancelar ventas, destruyendo tu reputación en la plataforma.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Estructuraste los títulos de tus publicaciones con palabras clave de búsqueda sin adjetivos vacíos?</li>
            <li>¿Mantienes tu termómetro de reputación en Verde Oscuro entregando los envíos en menos de 24 horas?</li>
            <li>¿Verificas el saldo disponible real en tu cuenta bancaria antes de entregar productos en persona?</li>
        </ul>
    </div>
</div>', 'Domina las plataformas de mayor tráfico de Latinoamérica: algoritmo de búsqueda en Mercado Libre, títulos SEO optimizados, reputación MercadoLíder, seguridad contra estafas y envíos con Mercado Envíos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (109, 109, 'Análisis de Rentabilidad y Optimización de la Conversión Digital', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cash-stack fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Matemática Detrás del Éxito en E-Commerce</h5>
            <p class="mb-0 small">Vender mucho por internet no garantiza tener ganancias. Si gastas $20 en publicidad digital para vender un producto que te deja $15 de margen de ganancia, estás perdiendo $5 en cada venta. Aprender a calcular el CAC y el ROAS es vital para no quebrar.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/ABRqXRMLt-8" title="Qué es el Embudo de Ventas en Marketing Digital" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-funnel-fill text-primary me-2"></i>1. Las 3 Etapas del Embudo de Ventas (Marketing Funnel)</h4>
    <p>Los clientes atraviesan un proceso psicológico antes de comprar. Se divide en tres fases:</p>
    <ul>
        <li><strong>TOFU (Top of the Funnel - Consciencia / Atracción):</strong> El usuario descubre que tiene un problema o deseo gracias a un video o publicación en redes sociales. El objetivo aquí es atraer atención con contenido educativo o inspirador.</li>
        <li><strong>MOFU (Middle of the Funnel - Consideración / Evaluación):</strong> El cliente compara opciones, lee opiniones, consulta fichas técnicas y evalúa marcas competidoras. Aquí se comparten testimonios y comparativas.</li>
        <li><strong>BOFU (Bottom of the Funnel - Decisión / Conversión):</strong> El cliente está listo para comprar. Requiere ofertas concretas, facilidades de pago, garantías claras y un botón de compra sin fricción.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calculator-fill text-primary me-2"></i>2. Las Tres Métricas Financieras Críticas del Comercio Digital</h4>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Métrica Financiera</th>
                    <th>Fórmula de Cálculo</th>
                    <th>Interpretación de Negocio</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">CAC (Customer Acquisition Cost)</td>
                    <td><code>Gasto Total en Publicidad / Clientes Nuevos Conseguidos</code></td>
                    <td>Cuánto dinero en pauta publicitaria te cuesta conseguir un cliente que pague. Si gastaste $500 en Meta Ads y conseguiste 50 clientes, tu CAC es de $10 USD por cliente.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">LTV (Lifetime Value)</td>
                    <td><code>Ticket Promedio × Frecuencia de Compra al Año × Años de Retención</code></td>
                    <td>La cantidad total de dinero que un cliente dejará en la empresa a lo largo de toda su relación comercial. Si tu LTV es de $80 y tu CAC es de $10, tu negocio es altamente rentable.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">ROAS (Return on Ad Spend)</td>
                    <td><code>Ingresos Generados por Publicidad / Inversión Publicitaria</code></td>
                    <td>El multiplicador de retorno de la pauta. Un ROAS de 4x significa que por cada dólar invertido en anuncios de Facebook/Google, la tienda facturó 4 dólares en ventas.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-percent text-success me-2"></i>3. La Tasa de Conversión (Conversion Rate - CR)</h4>
    <p>En el comercio electrónico mundial, la <strong>Tasa de Conversión promedio oscila entre el 1% y el 3%</strong>:</p>
    <div class="p-3 bg-light rounded border text-center my-3">
        <code class="fs-6 fw-bold">Tasa de Conversión = (Número de Compras / Total de Visitas a la Web) × 100</code>
    </div>
    <p class="small text-muted">De cada 100 personas que entran a tu tienda online o te escriben al WhatsApp, típicamente entre 1 y 3 terminarán comprando. Si tu tasa de conversión es inferior al 0.5%, el problema no es la publicidad; es tu página web (precios poco competitivos, fotos de mala calidad, dudas sobre el envío o métodos de pago engorrosos).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escalar la inversión en publicidad cuando el embudo está roto:</strong> Si tu tienda tiene una tasa de conversión pésima porque el checkout falla, meterle $1.000 USD más de publicidad en Instagram solo aumentará las pérdidas. Primero optimiza la página y la atención por chat, y luego escala la pauta.</li>
        <li><strong>Tener un CAC superior al margen bruto del producto:</strong> Si tu producto deja $8 de ganancia y te cuesta $12 en publicidad conseguir una venta, estás quemando capital en cada pedido. Debes aumentar el ticket promedio con venta cruzada o mejorar los creativos de tus anuncios.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Calculas semanalmente tu CAC y tu ROAS para evaluar la rentabilidad de tus anuncios?</li>
            <li>¿La relación entre tu LTV y tu CAC es de al menos 3 a 1 para asegurar la sostenibilidad del negocio?</li>
            <li>¿Optimizas periódicamente las fichas de producto para elevar la tasa de conversión global?</li>
        </ul>
    </div>
</div>', 'Domina la matemática del comercio digital: etapas del embudo de conversión (TOFU, MOFU, BOFU), cálculo del Costo de Adquisición de Clientes (CAC), Lifetime Value (LTV) y Retorno de Inversión Publicitaria (ROAS).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (8, 8, 'De la Rigidez de Cascada (Waterfall) a la Flexibilidad Adaptativa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-arrow-repeat fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Agile: Responder al Cambio por Encima de Seguir un Plan Ciego</h5>
            <p class="mb-0 small">En el mundo moderno (entorno VICA: Volátil, Incierto, Complejo y Ambiguo), intentar planificar al milímetro un proyecto de dos años en un diagrama de Gantt estático garantiza entregar un producto que el cliente ya no necesita. La agilidad permite entregar valor incremental cada dos semanas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/PozisugkXto" title="¿Qué es Scrum y Metodologías Ágiles? La mejor explicación" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Fracaso del Modelo en Cascada (Waterfall) en Proyectos Complejos</h4>
    <p>El enfoque tradicional de gestión de proyectos (<strong>Waterfall o Cascada</strong>) fue heredado de la industria de la construcción pesada: primero se redactan 500 páginas de requisitos durante 4 meses, luego se diseña durante 6 meses, luego se construye durante un año, y solo al final de los dos años el cliente puede ver el producto terminado.</p>
    <p>Si durante esos dos años la competencia lanzó una tecnología mejor, o las leyes cambiaron, o las necesidades del usuario variaron, el proyecto fracasa por completo tras haber quemado millones de dólares. Por el contrario, las <strong>Metodologías Ágiles</strong> descomponen el proyecto en iteraciones cortas de 1 a 4 semanas, entregando un <em>Incremento de Producto Funcional</em> al final de cada ciclo para recibir retroalimentación inmediata del mercado.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-file-text-fill text-primary me-2"></i>2. Los 4 Valores Fundamentales del Manifiesto Ágil (2001)</h4>
    <p>Firmado por 17 líderes del desarrollo de software en Snowbird, Utah, el <strong>Manifiesto Ágil</strong> declara que, aunque valoramos los elementos de la derecha, valoramos mucho más los elementos de la izquierda:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">Valor 1</span>
                <h6 class="fw-bold text-dark mb-1">Individuos e Interacciones sobre Procesos y Herramientas</h6>
                <p class="small text-muted mb-0">Tener el software de gestión de proyectos más caro del mundo no sirve de nada si las personas del equipo no conversan abierta y transparentemente todos los días.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">Valor 2</span>
                <h6 class="fw-bold text-dark mb-1">Software Funcional sobre Documentación Exhaustiva</h6>
                <p class="small text-muted mb-0">Es infinitamente más valioso entregar una versión funcional que el cliente pueda probar hoy, que entregar manuales de especificaciones teóricas de 200 páginas que nadie leerá.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-warning text-dark mb-2">Valor 3</span>
                <h6 class="fw-bold text-dark mb-1">Colaboración con el Cliente sobre Negociación Contractual</h6>
                <p class="small text-muted mb-0">En lugar de pelear en tribunales por cláusulas rígidas pactadas hace un año, trabajamos como socios con el cliente para adaptar el producto a su verdadero éxito comercial.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-danger mb-2">Valor 4</span>
                <h6 class="fw-bold text-dark mb-1">Respuesta ante el Cambio sobre Seguir un Plan</h6>
                <p class="small text-muted mb-0">El plan es una guía inicial, no una camisa de fuerza. La capacidad de pivotar y ajustar la dirección con agilidad es la mayor ventaja competitiva moderna.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Agilidad con Falta de Planificación o Desorden:</strong> Ser ágil no significa ''no planificar nada e ir improvisando sobre la marcha''. Scrum es un marco extremadamente disciplinado con reglas, ceremonias y métricas de rendimiento rigurosas.</li>
        <li><strong>''Hacer'' Agile sin ''Ser'' Agile (Agile Cosmético):</strong> Pintar tableros con notas adhesivas de colores en la pared pero seguir manteniendo una cultura autoritaria donde los jefes imponen plazos irreales sin escuchar al equipo técnico es una simulación inútil.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Priorizas la entrega de incrementos funcionales periódicos para recibir retroalimentación temprana?</li>
            <li>¿Fomentas la conversación directa y la colaboración por encima de la burocracia documental?</li>
            <li>¿Aceptas los cambios en los requisitos del cliente como una oportunidad de mejora competitiva?</li>
        </ul>
    </div>
</div>', 'Comprende la evolución de la gestión de proyectos: por qué fracasa el modelo tradicional en Cascada en entornos volátiles, los 4 valores y 12 principios del Manifiesto Ágil de 2001.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (82, 82, 'Gestión Visual del Flujo: To Do, In Progress, Done y Límites WIP', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-kanban-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Kanban: Dejar de Empezar y Comenzar a Terminar</h5>
            <p class="mb-0 small">El mal endémico de los equipos de oficina es la multitarea descontrolada: tener 20 proyectos empezados al mismo tiempo y ninguno terminado. Kanban limita el trabajo en curso (WIP) para destrabar el flujo y acelerar las entregas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/B-uwQg7RgH8" title="Tableros Kanban y Límites WIP explicados fácil" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es Kanban y Cuáles son sus Prácticas Clave?</h4>
    <p>Originado en las fábricas de manufactura de Toyota y adaptado al trabajo de oficina por David J. Anderson, <strong>Kanban</strong> (que en japonés significa <em>''tarjeta visual''</em>) es un método para gestionar el flujo de trabajo respetando 6 prácticas fundamentales:</p>
    <ol>
        <li><strong>Visualizar el Flujo de Trabajo:</strong> Mapear en un tablero físico o digital (Jira, Trello, Asana) las etapas por las que atraviesa una tarea.</li>
        <li><strong>Limitar el Trabajo en Curso (WIP - Work In Progress):</strong> Fijar un límite máximo estricto de tarjetas permitidas simultáneamente en cada columna.</li>
        <li><strong>Gestionar el Flujo:</strong> Monitorear cuellos de botella donde las tareas se acumulan atascadas.</li>
        <li><strong>Hacer Explícitas las Políticas del Proceso:</strong> Dejar claro bajo qué criterios exactos una tarea puede moverse a la columna siguiente (Definition of Done).</li>
        <li><strong>Implementar Bucles de Retroalimentación:</strong> Reuniones breves de sincronización frente al tablero.</li>
        <li><strong>Mejorar Colaborativamente (Kaizen):</strong> Optimizar el proceso continuamente mediante datos empíricos.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-slash-circle-fill text-danger me-2"></i>2. El Poder de los Límites WIP (Work In Progress)</h4>
    <p>El corazón de Kanban reside en colocar un número encima de las columnas activas (ej: <code>En Progreso [WIP: 3]</code>):</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <p class="small mb-0">
            Si el límite de la columna <em>''En Revisión''</em> es <strong>2</strong> y ya hay dos tareas allí, <strong>está terminantemente prohibido que nadie empiece una tarea nueva</strong> del Backlog. Los miembros del equipo deben abocarse a ayudar al compañero a destrabar y revisar las dos tareas acumuladas para que pasen a <em>''Terminado''</em> antes de poder tomar trabajo nuevo.<br />
            <strong>El principio supremo:</strong> <em>''Stop Starting, Start Finishing'' (Deja de empezar cosas nuevas y empieza a terminar las que ya están en curso).</em>
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-speedometer2 text-primary me-2"></i>3. Métricas de Rendimiento en Kanban: Lead Time vs Cycle Time</h4>
    <p>Para medir la agilidad del equipo de forma científica se utilizan dos cronómetros:</p>
    <ul>
        <li><strong>Lead Time (Tiempo de Entrega):</strong> El tiempo total transcurrido desde que el cliente solicita el requerimiento hasta que el producto está terminado y funcionando en sus manos. Mide la experiencia del cliente.</li>
        <li><strong>Cycle Time (Tiempo de Ciclo):</strong> El tiempo que el equipo tarda efectivamente trabajando en la tarea desde que pasa de ''Por Hacer'' a ''En Progreso'' hasta que llega a ''Terminado''. Mide la eficiencia interna del equipo técnico.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tratar el tablero Kanban como un simple adorno sin respetar los límites WIP:</strong> Si tienes 15 tareas en la columna ''En Progreso'' con un equipo de 4 personas, no estás usando Kanban; solo tienes un tablero de desorden visual. Los límites WIP deben respetarse con rigor absoluto.</li>
        <li><strong>Mover tareas hacia atrás en el tablero:</strong> En Kanban el flujo siempre se mueve hacia adelante de izquierda a derecha. Si una tarea en revisión tiene un error, no se devuelve a ''Por Hacer''; se le coloca una etiqueta roja de bloqueo y se resuelve prioritariamente en la misma columna.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Configuraste límites de trabajo en curso (WIP) en tus columnas activas?</li>
            <li>¿Priorizas destrabar cuellos de botella antes de iniciar tareas nuevas?</li>
            <li>¿Mides periódicamente el Lead Time y Cycle Time para optimizar tus tiempos de entrega?</li>
        </ul>
    </div>
</div>', 'Optimiza la entrega continua con Kanban: las 6 prácticas esenciales, configuración de columnas de flujo, establecimiento de límites de trabajo en curso (WIP Limits), y medición de Lead Time y Cycle Time.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (117, 117, 'Las Cuatro Perspectivas del Éxito Sostenible según Kaplan y Norton', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-pie-chart fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">Balanced Scorecard: Mirar Hacia Adelante, no por el Espejo Retrovisor</h5>
            <p class="mb-0 small">Evaluar una empresa únicamente por sus balances contables es como conducir un automóvil mirando solo por el espejo retrovisor: ves por dónde pasaste en el pasado, pero no ves los obstáculos del camino que tienes enfrente. El Cuadro de Mando Integral mide los inductores del éxito futuro.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/rf0inv6xeAo" title="El Cuadro de Mando Integral - Balanced Scorecard" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las Cuatro Perspectivas del Balanced Scorecard</h4>
    <p>Formulado por Robert Kaplan y David Norton en Harvard Business School, el <strong>Cuadro de Mando Integral (BSC)</strong> equilibra los resultados financieros de corto plazo con las capacidades humanas y de procesos que aseguran el futuro del negocio:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Perspectiva</th>
                    <th>Pregunta Estratégica Fundamental</th>
                    <th>Métricas e Indicadores Típicos (KPIs)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">1. Financiera</td>
                    <td>¿Cómo debemos aparecer ante nuestros accionistas para tener éxito financiero?</td>
                    <td>Retorno sobre la Inversión (ROI), Margen Operativo EBITDA, Crecimiento de Ingresos y Flujo de Caja Libre.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">2. Clientes / Mercado</td>
                    <td>¿Cómo debemos ser percibidos por los clientes para alcanzar nuestra visión?</td>
                    <td>Cuota de Mercado (Market Share), Índice de Recomendación Neta (NPS), Tasa de Retención y Costo de Adquisición.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">3. Procesos Internos</td>
                    <td>¿En qué procesos de la cadena de valor debemos ser excelentes?</td>
                    <td>Tiempos de Ciclo de Fabricación/Despacho, Tasa de Defectos y Mermas, y Rotación de Inventarios.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">4. Aprendizaje y Crecimiento</td>
                    <td>¿Cómo mantendremos y desarrollaremos nuestra capacidad de cambio y mejora?</td>
                    <td>Horas de Capacitación por Empleado, Clima Laboral, Tasa de Rotación de Talento y Adopción de Nuevas Tecnologías.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-diagram-3 text-primary me-2"></i>2. El Mapa Estratégico de Causa y Efecto</h4>
    <p>El mayor aporte del BSC es demostrar que las 4 perspectivas están encadenadas lógicamente de abajo hacia arriba en una relación de <strong>Causa y Efecto</strong>:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        1. <strong>Si capacitamos al personal en el sistema ERP</strong> (Aprendizaje y Crecimiento)...<br />
        2. ➔ <strong>Los operarios cometerán menos errores y despacharán más rápido</strong> (Procesos Internos)...<br />
        3. ➔ <strong>Los clientes recibirán sus pedidos perfectos a tiempo y estarán felices</strong> (Clientes)...<br />
        4. ➔ <strong>Las ventas aumentarán y las utilidades para los accionistas se multiplicarán</strong> (Financiera).
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tener más de 25 indicadores en el cuadro de mando:</strong> Un tablero con 80 métricas genera ''parálisis por análisis''. La metodología recomienda seleccionar entre 3 y 5 indicadores vitales por perspectiva (máximo 15 a 20 KPIs en total).</li>
        <li><strong>Redactar indicadores sin metas cuantitativas ni responsables asignados:</strong> Todo KPI debe tener una meta numérica concreta, un plazo límite y el nombre del líder de área responsable de su cumplimiento.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Equilibraste tus metas en las 4 perspectivas (Financiera, Clientes, Procesos y Talento)?</li>
            <li>¿Diseñaste el Mapa Estratégico mostrando las relaciones de causa-efecto entre áreas?</li>
            <li>¿Tiene cada indicador un valor actual, una meta esperada y un responsable con nombre?</li>
        </ul>
    </div>
</div>', 'Supera la visión puramente contable. Domina las 4 perspectivas del Balanced Scorecard: Financiera, Clientes, Procesos Internos, y Aprendizaje y Crecimiento, con mapas estratégicos de causa-efecto.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (118, 118, 'Las 4 Disciplinas de la Ejecución (4DX) y Revisiones WBR/MBR', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-fire fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">El Torbellino del Día a Día: El Asesino Número Uno de la Estrategia</h5>
            <p class="mb-0 small">El 90% de los planes estratégicos fracasan no porque la idea fuera mala, sino porque la urgencia cotidiana de apagar fuegos operativos, llamadas de clientes y correos urgentes absorbe el 100% de la energía del equipo, devorando la ejecución.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/dErErlA0hXU" title="Las 4 Disciplinas de la Ejecución (4DX) - Resumen Animado" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las 4 Disciplinas de la Ejecución (Metodología 4DX)</h4>
    <p>Desarrollada por FranklinCovey (McChesney, Covey y Huling), la metodología <strong>4DX</strong> provee las cuatro reglas científicas para ejecutar la estrategia en medio del torbellino:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">Disciplina 1</span>
                <h6 class="fw-bold text-dark mb-1">Enfocarse en lo Crucialmente Importante (MCI)</h6>
                <p class="small text-muted mb-0">Identificar una o máximo dos metas donde el fracaso no es una opción. Fórmula: <em>''Llevar el indicador X de A hacia B para la fecha Z''</em>.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">Disciplina 2</span>
                <h6 class="fw-bold text-dark mb-1">Actuar sobre Medidas Predictivas (Lead Measures)</h6>
                <p class="small text-muted mb-0">Diferenciar medidas históricas (Lag: las ventas pasadas que ya no puedes cambiar) de medidas predictivas que el equipo puede controlar diariamente (Lead: llamadas comerciales y cotizaciones emitidas hoy).</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-warning text-dark mb-2">Disciplina 3</span>
                <h6 class="fw-bold text-dark mb-1">Mantener un Tablero Conmovedor de Resultados</h6>
                <p class="small text-muted mb-0">Un marcador visual simple y público donde cualquier operario entienda en 5 segundos si el equipo está ganando o perdiendo el partido esta semana.</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-danger mb-2">Disciplina 4</span>
                <h6 class="fw-bold text-dark mb-1">Crear una Cadencia de Rendición de Cuentas</h6>
                <p class="small text-muted mb-0">Una reunión semanal obligatoria de 20 minutos donde cada miembro del equipo rinde cuentas de los compromisos de la semana anterior y asume uno nuevo para la próxima.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-calendar2-week-fill text-primary me-2"></i>2. Las Revisiones Operativas WBR y MBR</h4>
    <p>Las organizaciones globales como Amazon o Mercado Libre estructuran su gobierno corporativo mediante dos reuniones rítmicas:</p>
    <ul>
        <li><strong>WBR (Weekly Business Review):</strong> Reunión semanal de 60 minutos enfocada estrictamente en métricas operativas y medidas predictivas. Se analizan desviaciones y se corrigen antes de que termine el mes.</li>
        <li><strong>MBR (Monthly Business Review):</strong> Reunión mensual profunda con la dirección para revisar el estado financiero consolidado (EBITDA), el avance de los OKRs y el reajuste de inversiones.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Intentar cambiar 10 metas estratégicas a la vez:</strong> Si tienes 10 prioridades, en realidad no tienes ninguna. El cerebro humano y las organizaciones solo pueden mantener el enfoque de alto rendimiento en una o dos metas cruciales simultáneamente.</li>
        <li><strong>Permitir que la reunión semanal de rendición de cuentas se convierta en una sesión de quejas:</strong> La reunión semanal 4DX dura estrictamente 20 minutos y solo tiene tres partes: Rendir cuentas del compromiso pasado, revisar el tablero, y asumir el nuevo compromiso para la semana siguiente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Definiste claramente tu Meta Crucialmente Importante (MCI) con la fórmula de A hacia B para Z?</li>
            <li>¿Mides semanalmente medidas predictivas que tu equipo puede influir directamente?</li>
            <li>¿Mantienes una cadencia semanal estricta de rendición de cuentas de 20 minutos?</li>
        </ul>
    </div>
</div>', 'Supera el ''torbellino'' del día a día: aplica el método 4DX (Metas Crucialmente Importantes, Medidas Predictivas, Tablero Conmovedor y Cadencia de Rendición de Cuentas) con reuniones WBR y MBR.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (170, 170, 'La ''Sonrisa Telefónica'', Modulación Vocal y Redacción de Correos Profesionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-telephone-outbound-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">La Voz y la Escritura Son los Espejos de la Calidad Institucional</h5>
            <p class="mb-0 small">Al hablar por teléfono, la entonación y el ritmo transmiten el 85% de la intención del mensaje. Por escrito, la puntuación y la estructura determinan la confianza del lector. Domina ambas disciplinas técnicas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/Fa-ERJaIGvs" title="Que es la Sonrisa telefónica en la comunicación" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-mic text-primary me-2"></i>1. La Sonrisa Telefónica y la Calibración Vocal</h4>
    <p>Aunque el usuario al otro lado de la línea no pueda vernos, la postura corporal y la expresión facial modifican de manera física la apertura de la faringe y la tensión de las cuerdas vocales:</p>
    <ul>
        <li><strong>El Fenómeno de la Sonrisa Auditiva:</strong> Hablar mientras se sonríe físicamente eleva el tono haciéndolo más brillante, cálido y acogedor. Quien atiende encorvado o con la boca apoyada en el escritorio suena fatigado y desinteresado.</li>
        <li><strong>Ritmo y Velocidad de Articulación:</strong> Lo ideal en atención telefónica es hablar a una velocidad promedio de 130 a 150 palabras por minuto. Hablar demasiado rápido genera ansiedad e incomprensión; hablar con lentitud excesiva desespera al usuario.</li>
        <li><strong>Gestión de las Esperas Telefónicas (Mute vs Hold):</strong> Nunca dejes al cliente en espera prolongada sin avisarle. El protocolo estándar exige solicitar permiso antes de poner la llamada en pausa: <em>''¿Me permite un minuto en línea mientras consulto con el área técnica su requerimiento, Sr. Gómez?''</em>, y retomar la llamada cada 45 segundos para agradecer la espera.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-envelope-check text-primary me-2"></i>2. Estructura de un Correo Electrónico de Servicio Profesional</h4>
    <p>Un correo corporativo impecable debe tener una arquitectura limpia de 4 bloques:</p>
    <ol>
        <li><strong>Asunto Específico y Accionable:</strong> Incluir siempre el motivo y el número de caso (ej: <em>''Respuesta a Consulta #4592 - Actualización de Datos de Facturación''</em>). Evitar asuntos genéricos como ''Consulta'' o ''Ayuda''.</li>
        <li><strong>Saludo Personalizado y Apertura Cortés:</strong> <em>''Estimada Sra. Morales, reciba un cordial saludo de parte de [Empresa]''</em>.</li>
        <li><strong>Cuerpo del Mensaje Estructurado con Viñetas:</strong> Ir al grano de inmediato. En lugar de párrafos densos de 10 líneas, utilizar listas con viñetas para explicar los pasos a seguir o los requisitos a enviar.</li>
        <li><strong>Cierre Claro y Datos de Contacto:</strong> Despedida formal, nombre completo del agente, cargo y canales directos de seguimiento.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir en mayúsculas sostenidas:</strong> En la etiqueta digital (Netiquette), redactar un correo o mensaje en MAYÚSCULAS equivale a estar GRITANDO con agresividad al cliente.</li>
        <li><strong>Uso excesivo de diminutivos informales:</strong> Usar expresiones como <em>''un momentico'', ''la facturita'', ''su dinerito''</em> le resta seriedad institucional y autoridad profesional a la empresa.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Sonríes conscientemente antes de descolgar o iniciar una llamada telefónica?</li>
            <li>¿Revisas la ortografía, gramática y nombres propios antes de hacer clic en enviar un correo?</li>
            <li>¿Retomas al cliente cada 45 segundos cuando debes poner la llamada en espera?</li>
        </ul>
    </div>
</div>', 'Domina el arte de proyectar empatía a través de la voz sin soporte visual y aprende a redactar correos ejecutivos claros, estructurados y asertivos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (171, 171, 'Métricas de Mesa de Ayuda: Tiempos de Primera Respuesta y Resolución', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-ticket-perforated-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Medición del Tiempo es el Corazón del Soporte Técnico</h5>
            <p class="mb-0 small">Un buen servicio que llega demasiado tarde ya no es un buen servicio. Conoce los Acuerdos de Nivel de Servicio (SLA) y la administración profesional del ciclo de vida de incidencias.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/yl-i5jXsZBw" title="Osticket v 1.11+ - Niveles de servicio (SLA), gestión de tiempos de respuesta" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-clock-history text-primary me-2"></i>1. ¿Qué es un SLA (Service Level Agreement)?</h4>
    <p>Un Acuerdo de Nivel de Servicio es un compromiso formal entre el proveedor del servicio y el cliente que estipula con precisión matemática los tiempos de atención garantizados:</p>
    <ul>
        <li><strong>Tiempo de Primera Respuesta (FRT - First Response Time):</strong> Los minutos u horas que transcurren desde que el cliente registra el ticket hasta que un agente humano calificado emite la primera respuesta personalizada.</li>
        <li><strong>Tiempo Total de Resolución (TTR - Time to Resolution):</strong> El tiempo total acumulado hasta que la falla queda 100% resuelta y el ticket pasa a estado ''Cerrado'' con la conformidad del usuario.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-layers text-primary me-2"></i>2. Matriz de Priorización de Tickets (P1 a P4)</h4>
    <p>En mesas de ayuda corporativas, las incidencias no se atienden por orden de llegada, sino evaluando el impacto operativo y la urgencia del problema:</p>
    <ol>
        <li><strong>P1 - Crítico (Bloqueo Total del Negocio):</strong> El sistema central de facturación o la pasarela de pagos se cayó; ningún cliente puede comprar. Requiere atención inmediata (FRT &lt; 15 minutos, resolución en &lt; 2 a 4 horas con movilización de ingenieros senior).</li>
        <li><strong>P2 - Alto (Impacto Severo con Alternativa Parcial):</strong> Una sucursal entera no tiene acceso a reportes, pero puede seguir vendiendo manualmente. (Resolución en &lt; 8 horas).</li>
        <li><strong>P3 - Medio (Incidencia Menor / Usuario Individual):</strong> A un usuario específico se le cerró la sesión de su correo o la impresora no responde. (Resolución en 24 a 48 horas).</li>
        <li><strong>P4 - Bajo (Consultas Generales o Mejoras Menores):</strong> Solicitud de cambio de tipografía o dudas sobre una funcionalidad futura. (Resolución programada en sprint ordinario).</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Cerrar tickets unilateralmente sin validación:</strong> Marcar un ticket como ''Resuelto'' en el sistema solo para cumplir las metas del SLA sin haber verificado con el cliente si su problema realmente se solucionó. Genera reaperturas de tickets y enfado mayúsculo.</li>
        <li><strong>No categorizar ni etiquetar las incidencias (Tags):</strong> Si no se etiquetan los tickets por causas (ej: #ErrorFactura, #FallaInternet, #ClaveBloqueada), la gerencia no puede identificar los problemas raíz para eliminarlos definitivamente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Supervisas tu cola de tickets dando estricta prioridad a incidencias P1 y P2?</li>
            <li>¿Verificas con el usuario antes de cerrar formalmente cualquier ticket de servicio?</li>
            <li>¿Cumples con el Acuerdo de Nivel de Servicio (SLA) fijado para tu departamento?</li>
        </ul>
    </div>
</div>', 'Domina el ciclo de vida del ticket en herramientas como Zendesk/Jira: priorización (P1 a P4), cumplimiento de SLAs y escalamiento jerárquico eficiente.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (172, 172, 'La Paradoja de Recuperación del Servicio y Métricas de Experiencia', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-graph-up text-success fs-2"></i>
        <div>
            <h5 class="fw-bold mb-1">Un Reclamo Bien Resuelto es la Mayor Oportunidad de Fidelización</h5>
            <p class="mb-0 small">Las fallas operativas son inevitables; lo imperdonable es la indiferencia corporativa. Conoce la Paradoja de Recuperación del Servicio y los tres indicadores clave: CSAT, CES y FCR.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/2hrbyXdMmqs" title="Si te interesan tus clientes, mide el FCR, CSAT y NPS" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-arrow-repeat text-primary me-2"></i>1. La Paradoja de Recuperación del Servicio (Service Recovery Paradox)</h4>
    <p>Comprobada empíricamente en múltiples investigaciones de Harvard Business Review: cuando una empresa comete un error (ej: demora en un pedido o entrega de un artículo defectuoso), pero reacciona con velocidad fulminante, empatía total y una compensación generosa, el nivel de satisfacción y lealtad final de ese cliente resulta ser significativamente superior al de un cliente que nunca experimentó ninguna falla:</p>
    <ul>
        <li><strong>Empoderamiento en Primera Línea:</strong> Para que la paradoja funcione, los colaboradores de atención deben tener autonomía de decisión económica (ej: potestad de otorgar un descuento del 15% o un mes gratis sin tener que pedir autorización a tres gerentes durante una semana).</li>
        <li><strong>Compensación Justa y Oportuna:</strong> Si el error costó tiempo al cliente, la compensación debe reparar no solo el valor monetario del bien, sino el mal rato emocional vivido.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-speedometer2 text-primary me-2"></i>2. Las Tres Métricas Esenciales de Atención al Cliente</h4>
    <p>Un centro de servicio moderno se administra evaluando tres pilares de rendimiento:</p>
    <ol>
        <li><strong>CSAT (Customer Satisfaction Score):</strong> Mide la satisfacción puntual con una transacción concreta: <em>''¿Cómo califica la atención recibida hoy?''</em> (escala de 1 a 5 estrellas). Una meta corporativa saludable debe superar el 85% de satisfacción.</li>
        <li><strong>CES (Customer Effort Score - Puntuación de Esfuerzo):</strong> Mide qué tan fácil o difícil fue para el cliente resolver su problema: <em>''La empresa facilitó la solución de mi solicitud''</em> (escala de totalmente en desacuerdo a totalmente de acuerdo). Cuanto menor sea el esfuerzo exigido al cliente, mayor será su retención futura.</li>
        <li><strong>FCR (First Contact Resolution - Resolución en el Primer Contacto):</strong> El porcentaje de consultas o reclamos que se resolvieron en la primera interacción, sin necesidad de que el usuario tenga que volver a llamar o escribir. Un FCR elevado reduce costos drásticamente.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Culpabilizar al cliente:</strong> Decirle <em>''Usted no leyó la letra pequeña del contrato''</em> o <em>''Eso le pasa por no saber usar el programa''</em> genera un resentimiento irreconciliable.</li>
        <li><strong>Medir solo la rapidez y no la calidad:</strong> Presionar a los agentes para que corten las llamadas en menos de 2 minutos para inflar las estadísticas, provocando que los casos queden mal resueltos y los clientes tengan que llamar 5 veces más.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Ofreces compensaciones rápidas y proporcionadas cuando la empresa comete un error?</li>
            <li>¿Mides tu indicador de Resolución en el Primer Contacto (FCR) semanalmente?</li>
            <li>¿Evalúas el esfuerzo que le exiges hacer a tus clientes para resolver sus trámites?</li>
        </ul>
    </div>
</div>', 'Descubre cómo un cliente que experimentó una falla y fue compensado de manera magistral puede volverse más leal que quien nunca tuvo ningún problema.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (15, 15, 'Guía Gramatical y Fonética: Sujetos, Formas Afirmativas, Negativas y Contracciones', 'Reading', '<h4>1. Pronombres Personales Sujetos (Personal Subject Pronouns)</h4>
<p>En inglés, a diferencia del español, <strong>el sujeto siempre debe escribirse o pronunciarse</strong> (no existe el sujeto tácito u omitido). La única excepción es el modo imperativo (órdenes directas como <em>''Listen!''</em>).</p>

<div class="table-responsive my-3">
    <table class="table table-bordered table-striped align-middle">
        <thead class="table-dark">
            <tr><th>Pronombre</th><th>Traducción al Español</th><th>Notas de Uso y Pronunciación</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>I</strong></td><td>Yo</td><td>Siempre se escribe con mayúscula, sin importar su posición en la frase.</td></tr>
            <tr><td><strong>You</strong></td><td>Tú / Usted</td><td>Se emplea tanto para el trato informal como formal en singular.</td></tr>
            <tr><td><strong>He</strong></td><td>Él</td><td>Para personas masculinas singulares.</td></tr>
            <tr><td><strong>She</strong></td><td>Ella</td><td>Para personas femeninas singulares.</td></tr>
            <tr><td><strong>It</strong></td><td>Ello / Eso / Animal o Cosa</td><td>Para objetos inanimados, lugares, ideas o animales cuyo sexo se desconoce.</td></tr>
            <tr><td><strong>We</strong></td><td>Nosotros / Nosotras</td><td>Primera persona del plural.</td></tr>
            <tr><td><strong>You</strong></td><td>Vosotros / Ustedes</td><td>Segunda persona del plural (idéntico al singular).</td></tr>
            <tr><td><strong>They</strong></td><td>Ellos / Ellas</td><td>Tercera persona del plural para personas, animales o cosas.</td></tr>
        </tbody>
    </table>
</div>

<h4>2. El Verbo "To Be" (Ser / Estar)</h4>
<p>El verbo <em>To Be</em> es el pilar fundamental del idioma. Posee 3 formas distintas en presente simple: <strong>am</strong>, <strong>is</strong>, <strong>are</strong>.</p>

<div class="row g-3 my-3">
    <div class="col-md-4">
        <div class="card h-100 p-3 border-primary">
            <h6 class="fw-bold text-primary">Forma Afirmativa y Contracciones</h6>
            <ul class="small mb-0 list-unstyled">
                <li>I am &rarr; <strong>I''m</strong> (Yo soy / estoy)</li>
                <li>You are &rarr; <strong>You''re</strong></li>
                <li>He is &rarr; <strong>He''s</strong></li>
                <li>She is &rarr; <strong>She''s</strong></li>
                <li>It is &rarr; <strong>It''s</strong></li>
                <li>We are &rarr; <strong>We''re</strong></li>
                <li>They are &rarr; <strong>They''re</strong></li>
            </ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 p-3 border-danger">
            <h6 class="fw-bold text-danger">Forma Negativa</h6>
            <ul class="small mb-0 list-unstyled">
                <li>I am not &rarr; <strong>I''m not</strong></li>
                <li>You are not &rarr; <strong>You aren''t</strong></li>
                <li>He is not &rarr; <strong>He isn''t</strong></li>
                <li>She is not &rarr; <strong>She isn''t</strong></li>
                <li>It is not &rarr; <strong>It isn''t</strong></li>
                <li>We are not &rarr; <strong>We aren''t</strong></li>
                <li>They are not &rarr; <strong>They aren''t</strong></li>
            </ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 p-3 border-success">
            <h6 class="fw-bold text-success">Forma Interrogativa (Inversión)</h6>
            <ul class="small mb-0 list-unstyled">
                <li><strong>Am I</strong> late?</li>
                <li><strong>Are you</strong> a student?</li>
                <li><strong>Is he</strong> ready?</li>
                <li><strong>Is she</strong> at home?</li>
                <li><strong>Is it</strong> cold?</li>
                <li><strong>Are we</strong> ready?</li>
                <li><strong>Are they</strong> coming?</li>
            </ul>
        </div>
    </div>
</div>

<div class="alert alert-info border-0 p-3 rounded-3 my-3">
    <h6 class="fw-bold mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Respuestas Cortas (Short Answers):</h6>
    <p class="small mb-0">A la pregunta <em>''Are you Spanish?''</em> se responde afirmativamente: <strong>''Yes, I am''</strong> (¡nunca en forma contraída ''Yes, I''m''!). En negativo sí se contrae: <strong>''No, I''m not''</strong> o <strong>''No, he isn''t''</strong>.</p>
</div>', 'Domina los pronombres personales (I, you, he, she, it, we, they) y las conjugaciones completas del verbo To Be con contracciones y respuestas cortas.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (32, 32, 'Extracción, Transformación y Limpieza de Datos (ETL) Automatizada', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-database-fill-gear fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Power Query: El 80% del Éxito en Business Intelligence es la Limpieza</h5>
            <p class="mb-0 small">Ningún gráfico elegante de Power BI servirá si los datos subyacentes están mal estructurados. Power Query permite programar una tubería de transformación automática que limpia y estandariza los datos cada vez que presionas ''Actualizar''.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/xeXfc8Y_y7o" title="Curso de Microsoft Power BI desde cero - INTRODUCCION" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Ciclo E.T.L. (Extract, Transform, Load)</h4>
    <p>En el mundo del análisis de datos empresarial, los datos nunca vienen limpios. Vienen en archivos de texto desordenados, sistemas contables con formatos incompatibles o múltiples hojas de cálculo con columnas cruzadas. El proceso <strong>ETL</strong> resuelve este problema mediante tres fases continuas:</p>
    <ul>
        <li><strong>Extract (Extracción):</strong> Conectar Power BI a los repositorios de información (bases de datos SQL, carpetas de red con archivos Excel de ventas, APIs web, SharePoint o archivos CSV).</li>
        <li><strong>Transform (Transformación):</strong> Limpiar los datos sin alterar el archivo original. Se eliminan filas vacías, se corrigen tipos de datos, se rellenan valores nulos, se separan nombres y apellidos, y se transforman tablas cruzadas en listas normalizadas.</li>
        <li><strong>Load (Carga):</strong> Cargar el modelo purificado en la memoria interna de Power BI (motor VertiPaq) para permitir consultas instantáneas sobre millones de registros.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-table text-success me-2"></i>2. La Operación Clave: Anulación de Dinamización de Columnas (Unpivot)</h4>
    <p>Uno de los mayores dolores de cabeza para los analistas es recibir reportes de finanzas donde los meses están repartidos horizontalmente en 12 columnas distintas (Enero, Febrero, Marzo...). Para un ser humano esto es fácil de leer, pero para una base de datos relacional es un desastre que impide filtrar por fecha.</p>
    <p>En Power Query, la solución es la función <strong>Anular dinamización de columnas (Unpivot Columns)</strong>:</p>
    <ol>
        <li>Seleccionar las columnas fijas (ej: Código de Producto y Sucursal).</li>
        <li>Hacer clic derecho y elegir <em>''Anular dinamización de otras columnas''</em>.</li>
        <li>Power Query transformará instantáneamente las 12 columnas horizontales en dos columnas verticales ordenadas: <strong>Atributo (el Mes)</strong> y <strong>Valor (el Monto)</strong>. A partir de ese momento, podrás analizar tendencias temporales con facilidad.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-folder-symlink-fill text-primary me-2"></i>3. Consolidación de Carpetas Mensuales en 1 Clic</h4>
    <p>Si cada mes tu empresa genera un archivo Excel nuevo con las ventas del período (ej: <code>Ventas_Enero.xlsx</code>, <code>Ventas_Febrero.xlsx</code>), en lugar de copiar y pegar los datos a mano en una hoja gigante, en Power BI seleccionas <em>''Obtener datos ➔ Carpeta''</em>:</p>
    <ul>
        <li>Power Query lee todos los archivos contenidos en la carpeta y los apila verticalmente de forma automática.</li>
        <li>Cuando termine el mes de Marzo, simplemente guardas el archivo <code>Ventas_Marzo.xlsx</code> en esa carpeta y presionas el botón <strong>Actualizar</strong> en Power BI: el nuevo mes se incorporará al tablero ejecutivo en cuestión de segundos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>No definir los tipos de datos en el último paso:</strong> Si una columna de fechas o precios queda configurada con el tipo de dato ''Cualquiera'' (icono 123/ABC), Power BI no podrá sumar las cantidades ni ordenar los meses cronológicamente en los gráficos. Asegúrate de que cada columna tenga explícitamente su tipo (Número decimal, Número entero, Fecha o Texto).</li>
        <li><strong>Realizar transformaciones complejas en DAX en lugar de Power Query:</strong> Todo proceso de limpieza, fusión de columnas y eliminación de espacios debe realizarse en Power Query (en la fase de carga) para no ralentizar el rendimiento del reporte en vivo con fórmulas DAX innecesarias.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste que cada columna tenga su tipo de dato exacto (Fecha, Texto, Número Decimal)?</li>
            <li>¿Utilizaste ''Anular dinamización de columnas'' en reportes con meses repartidos horizontalmente?</li>
            <li>¿Asignaste nombres descriptivos a cada paso aplicado en el panel lateral de Power Query?</li>
        </ul>
    </div>
</div>', 'Domina el proceso ETL en Power Query: conectar múltiples fuentes (Excel, CSV, SQL), desanular columnas (Unpivot), corregir tipos de datos y automatizar la limpieza de archivos mensuales.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (33, 33, 'Tablas de Hechos vs Tablas de Dimensiones y Relaciones 1 a Varios', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-2-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">El Esquema en Estrella: La Arquitectura del Análisis Rápido</h5>
            <p class="mb-0 small">Tener una sola tabla ''sábana'' de 50 columnas con datos repetidos de clientes y productos degrada el rendimiento de Power BI. Un modelo relacional profesional separa los hechos de las dimensiones para lograr máxima velocidad.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/6A40lYojW84" title="Modelamiento de Datos en POWER BI. Modelo Estrella y Buenas Prácticas" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Tablas de Hechos (Fact Tables) vs Tablas de Dimensiones (Dim Tables)</h4>
    <p>El estándar internacional formulado por Ralph Kimball para Business Intelligence divide las tablas del modelo en dos categorías estrictas:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-primary mb-2"><i class="bi bi-receipt me-2"></i>Tabla de Hechos (Fact Table)</h5>
                <p class="small text-muted mb-2">Registra los <strong>eventos o transacciones cuantitativas</strong> del negocio que ocurren a lo largo del tiempo. Es angosta (pocas columnas) pero muy larga (cientos de miles o millones de filas).</p>
                <ul class="small mb-0">
                    <li>Ejemplo: <code>FactVentas</code>, <code>FactCobranzas</code>, <code>FactInventarioDiario</code>.</li>
                    <li>Contiene claves foráneas (ID_Cliente, ID_Producto, ID_Fecha) y métricas numéricas (Cantidad_Vendida, Precio_Total, Costo).</li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="fw-bold text-success mb-2"><i class="bi bi-card-checklist me-2"></i>Tablas de Dimensiones (Dim Tables)</h5>
                <p class="small text-muted mb-2">Contienen los <strong>atributos descriptivos cualitativos</strong> que responden a las preguntas: ¿Quién?, ¿Qué?, ¿Dónde? y ¿Cuándo? Son anchas (muchas columnas) pero cortas (pocos registros únicos).</p>
                <ul class="small mb-0">
                    <li>Ejemplo: <code>DimClientes</code>, <code>DimProductos</code>, <code>DimSucursales</code>, <code>DimCalendario</code>.</li>
                    <li>Cada fila es un registro único sin duplicados identificado por una Llave Primaria (Primary Key).</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-stars text-primary me-2"></i>2. La Tabla Calendario Obligatoria (DimDate)</h4>
    <p>Para realizar cálculos de inteligencia de tiempo en DAX (comparar ventas de este mes contra el mismo mes del año anterior, o calcular ventas acumuladas anuales YTD), es un requisito técnico indispensable contar con una <strong>Tabla Calendario continua</strong> sin saltos de días ni fines de semana vacíos.</p>
    <p>Se puede generar en Power BI con una sencilla fórmula DAX en la vista de modelado:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark">
        <code>Calendario = CALENDAR(DATE(2023; 1; 1); DATE(2026; 12; 31))</code>
    </div>
    <p class="small text-muted">Posteriormente se añaden columnas calculadas para <code>Año = YEAR(Calendario[Date])</code>, <code>Mes = FORMAT(Calendario[Date]; "MMMM")</code> y <code>NumeroMes = MONTH(Calendario[Date])</code> (asegurando ordenar la columna Mes por NumeroMes para que no se ordenen alfabéticamente: Abril, Agosto, Diciembre...).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-left-right text-primary me-2"></i>3. Configuración de Relaciones: Cardinalidad y Dirección del Filtro</h4>
    <p>En el editor de relaciones (Vista de Modelo):</p>
    <ul>
        <li>La relación dorada en Power BI es <strong>1 a Varios (1:*)</strong>: Un cliente en <code>DimClientes</code> realiza muchas compras en <code>FactVentas</code>.</li>
        <li><strong>Dirección de Filtro Cruzado Única (Single):</strong> El filtro siempre debe viajar desde la dimensión hacia los hechos (al seleccionar un cliente en el segmentador, la tabla de ventas se filtra automáticamente).</li>
        <li><strong>Evitar Relaciones Varios a Varios (*:*):</strong> Provocan resultados impredecibles, duplicación oculta de montos financieros y degradación severa de la velocidad de cálculo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Activar la dirección de filtro cruzado en ''Ambas'' (Both) por defecto:</strong> Provoca ambigüedades en el modelo, trayendo totales incorrectos y generando bucles de filtrado circulares que confunden al motor DAX. La dirección debe ser siempre ''Única'' a menos que exista una justificación analítica avanzada específica.</li>
        <li><strong>Dejar columnas descriptivas en la tabla de hechos:</strong> Colocar el nombre del cliente y su dirección en cada una de las 500.000 filas de ventas en lugar de dejar únicamente su ID_Cliente multiplica el tamaño del archivo por diez.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Estructuraste el modelo como un Esquema en Estrella con la tabla de hechos en el centro?</li>
            <li>¿Creaste y marcaste como ''Tabla de Fechas'' una tabla calendario dedicada sin huecos?</li>
            <li>¿Comprobaste que todas las relaciones sean 1 a Varios (1:*) con filtro en dirección única?</li>
        </ul>
    </div>
</div>', 'Diseña modelos de datos de estándar corporativo. Diferencia Tablas de Hechos (Fact Tables) de Tablas de Dimensiones (Dim Tables), configura la dirección del filtro cruzado y evita relaciones Muchos a Muchos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (7, 7, 'Extracción de Métricas de Negocio desde Bases de Datos Relacionales', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-database-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">SQL: La Habilidad Más Demandada en el Mercado Laboral Tecnológico</h5>
            <p class="mb-0 small">Todo sistema empresarial, tienda online o banco almacena sus datos en motores SQL. Dominar consultas directas permite extraer la verdad de los datos sin depender de que el departamento de sistemas genere un reporte exportado a Excel.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/xuASGBwNboU" title="SUBCONSULTAS SQL | CON PRÁCTICA | Bases de Datos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Orden de Ejecución Real de una Consulta SQL</h4>
    <p>Aunque una consulta SQL se escribe comenzando con la cláusula <code>SELECT</code>, el motor de la base de datos (PostgreSQL, SQL Server, MySQL) la procesa internamente en un orden lógico completamente diferente:</p>
    <ol>
        <li><code>FROM & JOIN</code>: El motor primero ubica las tablas y realiza las uniones entre ellas.</li>
        <li><code>WHERE</code>: Filtra las filas individuales que no cumplen la condición preliminar.</li>
        <li><code>GROUP BY</code>: Agrupa los registros restantes por categorías (ej: por Cliente o por Ciudad).</li>
        <li><code>HAVING</code>: Filtra los grupos ya agregados (ej: <code>HAVING SUM(Monto) > 5000</code>).</li>
        <li><code>SELECT</code>: Extrae y calcula las columnas solicitadas por el analista.</li>
        <li><code>ORDER BY</code>: Ordena el conjunto final de registros de forma ascendente (ASC) o descendente (DESC).</li>
        <li><code>LIMIT / TOP</code>: Restringe la cantidad final de filas que se muestran en pantalla.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-intersect text-success me-2"></i>2. Cruce de Tablas con JOINs (INNER, LEFT, RIGHT)</h4>
    <p>En bases de datos normalizadas, la información de una factura está separada en una tabla de Clientes y una tabla de Ventas. Para unirlas en un solo reporte analítico se utiliza la sentencia <code>JOIN</code> vinculando sus claves:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Tipo de JOIN</th>
                    <th>Comportamiento de Unión</th>
                    <th>Uso Práctico en la Empresa</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">INNER JOIN</td>
                    <td>Devuelve únicamente los registros que coinciden en ambas tablas simultáneamente.</td>
                    <td>Obtener facturas donde el cliente está registrado formalmente en la base de datos.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">LEFT JOIN</td>
                    <td>Devuelve <strong>todos</strong> los registros de la tabla izquierda, y los datos coincidentes de la derecha. Si no hay coincidencia, devuelve <code>NULL</code>.</td>
                    <td><strong>Auditoría de Inactividad:</strong> Encontrar qué clientes registrados NUNCA han realizado una compra (<code>WHERE Ventas.Id IS NULL</code>).</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-terminal-fill text-dark me-2"></i>3. Consulta de Agregación Real para Auditoría Financiera</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <pre class="font-monospace small mb-0 text-dark">
SELECT 
    c.nombre_cliente,
    c.pais,
    COUNT(v.id_factura) AS total_compras,
    ROUND(SUM(v.monto_usd)::numeric, 2) AS facturacion_total,
    ROUND(AVG(v.monto_usd)::numeric, 2) AS ticket_promedio
FROM Clientes c
INNER JOIN Ventas v ON c.id_cliente = v.id_cliente
WHERE v.fecha_emision >= ''2026-01-01''
GROUP BY c.nombre_cliente, c.pais
HAVING SUM(v.monto_usd) >= 10000
ORDER BY facturacion_total DESC
LIMIT 10;
        </pre>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Filtrar agregaciones en la cláusula WHERE:</strong> Escribir <code>WHERE SUM(Monto) > 1000</code> arrojará un error de sintaxis inmediato. Las funciones de agregación se deben filtrar obligatoriamente en la cláusula <code>HAVING</code> después del <code>GROUP BY</code>.</li>
        <li><strong>Olvidar incluir en el GROUP BY todas las columnas del SELECT:</strong> Si en el SELECT pides <code>c.nombre_cliente</code> y <code>c.pais</code>, ambas columnas deben aparecer obligatoriamente en la instrucción <code>GROUP BY c.nombre_cliente, c.pais</code>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respetaste la distinción lógica entre WHERE (filtra filas) y HAVING (filtra grupos calculados)?</li>
            <li>¿Utilizaste LEFT JOIN cuando necesitas detectar clientes que no tienen registros de compra asociados?</li>
            <li>¿Agregaste índices en las columnas de claves foráneas para acelerar consultas sobre millones de filas?</li>
        </ul>
    </div>
</div>', 'Domina el lenguaje SQL estándar: SELECT, WHERE, filtros booleanos, funciones de agregación (COUNT, SUM, AVG) con GROUP BY y cruce de tablas maestras mediante INNER, LEFT y RIGHT JOINs.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (71, 71, 'Manipulación de Tablas Masivas en DataFrames de Pandas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-filetype-py fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Pandas: El Motor que Supera las Barreras del Millón de Filas de Excel</h5>
            <p class="mb-0 small">Excel tiene un límite físico estricto de 1.048.576 filas por hoja y se congela al manipular fórmulas en archivos grandes. Con la biblioteca Pandas de Python puedes procesar 10 millones de filas en memoria en cuestión de segundos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/2KCQQHpi2Qk" title="CURSO de PYTHON con PANDAS Para Ciencia de Datos" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es un DataFrame en Pandas?</h4>
    <p>En Python, la biblioteca <strong>Pandas</strong> es la herramienta central de los científicos de datos. Su estructura principal es el <strong>DataFrame</strong>: una tabla bidimensional compuesta por filas y columnas etiquetadas, similar a una hoja de cálculo pero respaldada por la velocidad matemática de <strong>NumPy</strong> (escrito en lenguaje C para cálculo vectorial ultrarrápido).</p>
    <p>La convención estándar mundial para importar estas librerías en cualquier script o Jupyter Notebook es:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark">
        <code>import numpy as np<br />import pandas as pd</code>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-funnel text-primary me-2"></i>2. Carga, Exploración y Limpieza de Valores Nulos (NaN)</h4>
    <p>El flujo básico de trabajo en análisis de datos consta de cuatro pasos esenciales:</p>
    <ol>
        <li><code>df = pd.read_csv(''ventas_anuales.csv'')</code>: Carga el archivo en memoria.</li>
        <li><code>df.info()</code> y <code>df.describe()</code>: Inspecciona la cantidad de registros, los tipos de datos de cada columna y estadísticas básicas (media, desviación estándar, valores máximos y mínimos).</li>
        <li><strong>Tratamiento de Datos Faltantes:</strong>
            <ul>
                <li><code>df.dropna()</code>: Elimina las filas que contienen valores nulos (usar con precaución para no perder datos valiosos).</li>
                <li><code>df[''precio''].fillna(df[''precio''].median(), inplace=True)</code>: Imputa los valores faltantes rellenándolos con la mediana del grupo para no sesgar el análisis.</li>
            </ul>
        </li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-code-square text-success me-2"></i>3. Indexación y Agrupaciones Avanzadas (.loc y .groupby)</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <pre class="font-monospace small mb-0 text-dark">
# Filtrar ventas de la sucursal Norte con monto superior a $500
ventas_top = df.loc[(df[''sucursal''] == ''Norte'') & (df[''monto''] > 500)]

# Resumen ejecutivo agrupado por Vendedor
resumen = df.groupby(''vendedor'').agg({
    ''monto'': [''sum'', ''mean''],
    ''id_factura'': ''count''
}).reset_index()

# Exportar el reporte final limpio a Excel
resumen.to_excel(''reporte_gerencial_limpio.xlsx'', index=False)
        </pre>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir .loc con .iloc:</strong> <code>.loc</code> busca por <em>etiquetas o condiciones lógicas</em> (ej: <code>df.loc[df[''edad''] > 18]</code>), mientras que <code>.iloc</code> busca estrictamente por <em>posiciones de índice numéricas enteras</em> (ej: <code>df.iloc[0:5, 0:2]</code> para extraer las primeras 5 filas y 2 columnas).</li>
        <li><strong>Olvidar resetear el índice tras un groupby:</strong> Si no utilizas <code>.reset_index()</code>, la columna agrupada se convierte en el índice de la tabla, dificultando exportarla de forma limpia a Power BI o bases de datos SQL.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Inspeccionaste el tipo de datos de cada columna con df.dtypes antes de calcular sumatorias?</li>
            <li>¿Gestionaste los valores nulos con imputación estadística o eliminación controlada?</li>
            <li>¿Optimizaste las operaciones usando métodos vectorizados en lugar de bucles ''for'' lentos?</li>
        </ul>
    </div>
</div>', 'Domina el entorno Jupyter Notebooks. Crea vectores matriciales con NumPy y manipula DataFrames con Pandas: filtrado condicional (.loc, .iloc), tratamiento de valores nulos (.dropna, .fillna) y agregaciones agrupadas (.groupby).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (61, 61, 'Automatización Documental: De una Lista en Excel a Cientos de Cartas Personalizadas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-envelope-paper-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Combinación de Correspondencia: El Poder del Envío Masivo Personalizado</h5>
            <p class="mb-0 small">Copiar y pegar nombres, cédulas y salarios a mano en 200 contratos de trabajo toma tres días y está plagado de errores humanos. Con Mail Merge, Word fusiona una plantilla con una tabla de Excel en 30 segundos.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/D1UB0MzVH3M" title="Combinación de correspondencia en Word desde Excel paso a paso" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Arquitectura de la Combinación de Correspondencia</h4>
    <p>El sistema de <strong>Combinación de Correspondencia (Mail Merge)</strong> funciona vinculando dos componentes totalmente independientes:</p>
    <ul>
        <li><strong>1. El Documento Principal (Plantilla en Word):</strong> El texto maestro que contiene la estructura formal fija de la carta, contrato, memorándum o recibo de pago, intercalado con <em>Campos Combinados</em> especiales (ej: <code>«Nombre_Completo»</code>, <code>«Cedula»</code>, <code>«Monto_Adeudado»</code>).</li>
        <li><strong>2. El Origen de Datos (Lista en Excel):</strong> Una tabla limpia de Excel donde la primera fila contiene los encabezados exactos de cada columna y cada fila subsiguiente representa un destinatario o empleado individual.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-play-circle-fill text-success me-2"></i>2. Guía Paso a Paso del Procedimiento Oficial</h4>
    <ol>
        <li>Abrir la plantilla en Word y dirigirse a la pestaña superior <strong>Correspondencia</strong>.</li>
        <li>Hacer clic en <strong>Iniciar combinación de correspondencia</strong> y seleccionar <em>Cartas</em> (o <em>Documentos normales de Word</em>).</li>
        <li>Hacer clic en <strong>Seleccionar destinatarios ➔ Usar una lista existente...</strong> y buscar el archivo de Excel con los datos.</li>
        <li>Seleccionar la hoja correspondiente y marcar la casilla <em>''La primera fila de datos contiene encabezados de columna''</em>.</li>
        <li>Ubicar el cursor en los puntos estratégicos del texto y hacer clic en <strong>Insertar campo combinado</strong>, eligiendo el campo deseado (ej: <code>Estimado(a) «Nombre»:</code>).</li>
        <li>Hacer clic en <strong>Vista previa de resultados</strong> para navegar entre los registros y constatar que cada nombre se inserte perfectamente.</li>
        <li>Finalizar con <strong>Finalizar y combinar ➔ Editar documentos individuales...</strong> para generar un archivo con todas las cartas listas para imprimir o enviar.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico de Oficina: Notificación de Cobranza Personalizada</h4>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        Caracas, 24 de Octubre de 2026<br /><br />
        Señor(a): <strong>«Nombre_Cliente»</strong><br />
        Dirección: <strong>«Direccion_Fiscal»</strong><br />
        Número de Factura: <strong>«Numero_Factura»</strong><br /><br />
        Estimado(a) <strong>«Contacto_Principal»</strong>:<br />
        Por medio de la presente le notificamos que su cuenta registra un saldo pendiente por valor de <strong>«Monto_USD» USD</strong>, con fecha de vencimiento al <strong>«Fecha_Vencimiento»</strong>. Agradecemos canalizar la liquidación correspondiente a través de nuestros canales autorizados...
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tener el archivo de Excel abierto al momento de vincularlo en Word:</strong> Si mantienes la hoja de cálculo abierta en Excel, Windows bloqueará el archivo por concurrencia y Word arrojará un error de ''Archivo en uso o denegado''. Siempre guarda y cierra el archivo de Excel antes de conectarlo a Word.</li>
        <li><strong>Pérdida del formato de moneda y fechas en Word:</strong> Por defecto, Word a veces importa los números de Excel como decimales puros (ej: <code>1500.250000001</code>). Para obligar a Word a mostrar formato monetario con dos decimales, se debe presionar <code>Alt + F9</code> sobre el campo y agregar el modificador de formato: <code>{ MERGEFIELD Monto_USD \# "$#,##0.00" }</code>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Guardaste y cerraste el archivo de Excel antes de iniciar la combinación en Word?</li>
            <li>¿Utilizaste ''Vista previa de resultados'' para verificar el formato de al menos tres registros?</li>
            <li>¿Generaste el archivo combinado individual para auditar las cartas antes de enviarlas a imprimir?</li>
        </ul>
    </div>
</div>', 'Aprende el flujo oficial de Combinación de Correspondencia (Mail Merge). Conecta plantillas de Word a bases de datos de Excel para emitir contratos laborales, cartas de cobranza y certificados individuales en segundos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (143, 143, 'Guía de Auxiliares: Usos como Verbo Principal y como Operador Auxiliar', 'Reading', '<h4>1. El Verbo "To Have" (Tener / Haber)</h4>
<p>El verbo <em>To Have</em> indica posesión en presente y se conjuga con dos formas: <strong>have</strong> y <strong>has</strong> (para la 3ª persona del singular: He, She, It).</p>

<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Sujeto</th><th>Afirmativa Estándar</th><th>Con ''Have Got'' (UK)</th><th>Negativa Estándar</th></tr>
        </thead>
        <tbody>
            <tr><td>I / You / We / They</td><td><strong>have</strong> a car</td><td>have got a car</td><td>don''t have a car</td></tr>
            <tr><td>He / She / It</td><td><strong>has</strong> a passport</td><td>has got a passport</td><td>doesn''t have a passport</td></tr>
        </tbody>
    </table>
</div>

<h4>2. El Verbo "To Do" (Hacer y Operador Auxiliar)</h4>
<p>El verbo <em>To Do</em> tiene una doble naturaleza en inglés:</p>
<ol>
    <li><strong>Como Verbo Principal de Acción:</strong> Significa ''hacer'' (actividades, tareas intelectuales o rutinas):
        <ul>
            <li><em>I do my homework every evening.</em> (Hago mi tarea todas las tardes).</li>
            <li><em>She does exercise at the gym.</em> (Ella hace ejercicio en el gimnasio).</li>
        </ul>
    </li>
    <li><strong>Como Verbo Auxiliar de Preguntas y Negaciones:</strong> No tiene traducción literal en español; sirve como herramienta sintáctica para formular oraciones negativas e interrogativas en Present Simple:
        <ul>
            <li><strong>Pregunta:</strong> <em><strong>Do</strong> you speak English?</em> / <em><strong>Does</strong> he live in Madrid?</em></li>
            <li><strong>Negación:</strong> <em>They <strong>do not (don''t)</strong> work today.</em> / <em>She <strong>does not (doesn''t)</strong> like coffee.</em></li>
        </ul>
    </li>
</ol>

<div class="alert alert-warning border-0 p-3 rounded-3">
    <strong><i class="bi bi-exclamation-triangle-fill text-danger me-1"></i> Regla de Oro:</strong> Cuando usas el auxiliar <em>Does</em> o <em>Doesn''t</em>, el verbo principal <strong>vuelve a su forma base (infinitivo sin to)</strong>. Es incorrecto decir <em>''Does he works?''</em>; lo correcto es <em>''Does he work?''</em>.
</div>', 'Aprende la conjugación de Have/Has, la estructura Have Got, y el papel imprescindible de Do/Does como operador auxiliar de preguntas y negaciones.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (144, 144, 'Sintaxis Fundamental: Orden SVO, Adjetivos y Reglas de Determinantes', 'Reading', '<h4>1. Estructura Sintáctica Básica: Orden S-V-O</h4>
<p>A diferencia del español, donde el orden de las palabras es muy libre, en inglés el orden de las oraciones afirmativas es estricto y sistemático:</p>

<div class="card p-3 bg-light border-primary rounded-3 my-3">
    <div class="row text-center fw-bold text-dark">
        <div class="col-md-3"><span class="badge bg-primary px-3 py-2">SUJETO (S)</span><br><span class="small text-muted">Peter</span></div>
        <div class="col-md-3"><span class="badge bg-success px-3 py-2">VERBO (V)</span><br><span class="small text-muted">plays</span></div>
        <div class="col-md-3"><span class="badge bg-warning text-dark px-3 py-2">OBJETO (O)</span><br><span class="small text-muted">the guitar</span></div>
        <div class="col-md-3"><span class="badge bg-secondary px-3 py-2">COMPLEMENTO</span><br><span class="small text-muted">every day</span></div>
    </div>
</div>

<h4>2. La Posición Ineludible del Adjetivo</h4>
<p>En inglés, los adjetivos <strong>siempre se colocan ANTES del sustantivo</strong> al que califican, y <strong>nunca llevan plural</strong>:</p>
<ul>
    <li>Correcto: <em>A <strong>new car</strong></em> / <em>Two <strong>new cars</strong></em> (¡nunca <em>two news cars</em> ni <em>a car new</em>!).</li>
    <li>Correcto: <em>She has <strong>blue eyes</strong></em>.</li>
</ul>

<h4>3. Artículos Indeterminados (A / An) vs. Determinado (The)</h4>
<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Artículo</th><th>Regla de Aplicación Fonética</th><th>Ejemplos Correctos</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>A</strong></td>
                <td>Delante de palabras que comienzan con <strong>sonido consonántico</strong>.</td>
                <td><em>a book, a car, a house, a university</em> (la ''u'' suena /ju:/, sonido consonántico).</td>
            </tr>
            <tr>
                <td><strong>AN</strong></td>
                <td>Delante de palabras que comienzan con <strong>sonido vocálico</strong>.</td>
                <td><em>an apple, an elephant, an orange, an hour</em> (la ''h'' es muda).</td>
            </tr>
            <tr>
                <td><strong>THE</strong></td>
                <td>El, la, los, las (para sustantivos específicos y conocidos por el oyente).</td>
                <td><em>The sun, the teacher of English, the keys on the table.</em></td>
            </tr>
            <tr>
                <td><strong>Zero Article (&Oslash;)</strong></td>
                <td>NO se usa artículo cuando se habla de cosas o personas en sentido general.</td>
                <td><em><strong>Cats</strong> are independent animals</em> (Hablando de los gatos en general).</td>
            </tr>
        </tbody>
    </table>
</div>', 'Domina el orden inmutable Sujeto-Verbo-Objeto, la posición del adjetivo antes del nombre y el uso correcto de A, An, The y el Artículo Cero.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (62, 62, 'Métricas Condicionales y Alertas Visuales Dinámicas en la Oficina', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-calculator-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Análisis Condicional: Sumar con Criterio Empresarial</h5>
            <p class="mb-0 small">Saber sumar una columna entera es básico. Saber sumar únicamente las facturas de un vendedor específico que superen los $500 y que estén vencidas es lo que diferencia a un asistente de un analista calificado.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/2P_5nENJXyA" title="Función CONTAR.SI y SUMAR.SI en Excel con ejemplos reales" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Familia de Funciones .SI y .SI.CONJUNTO</h4>
    <p>Excel provee funciones estadísticas que evalúan criterios antes de realizar el cálculo:</p>
    <ul>
        <li><code>=CONTAR.SI(Rango; Criterio)</code>: Cuenta cuántas celdas cumplen una condición única. Ejemplo: <code>=CONTAR.SI(C2:C500; "Pendiente")</code> devuelve cuántas facturas están sin cobrar.</li>
        <li><code>=SUMAR.SI(Rango_Criterio; Criterio; [Rango_Suma])</code>: Suma las cantidades de una columna solo si otra columna cumple la condición. Ejemplo: <code>=SUMAR.SI(B2:B500; "Sucursal Centro"; E2:E500)</code>.</li>
        <li><code>=SUMAR.SI.CONJUNTO(Rango_Suma; Rango_Crit1; Crit1; Rango_Crit2; Crit2...)</code>: La versión avanzada definitiva que permite evaluar hasta 127 criterios simultáneos. <em>(¡Cuidado con la sintaxis: en SUMAR.SI.CONJUNTO el rango que se suma va obligatoriamente al principio, a diferencia de SUMAR.SI donde iba al final!).</em></li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-paint-bucket text-primary me-2"></i>2. Formato Condicional con Fórmulas Propias</h4>
    <p>El <strong>Formato Condicional</strong> cambia el color de relleno o fuente de una celda de forma automática cuando cambia su valor. Para resaltar en rojo suave todas las facturas vencidas respecto al día de hoy:</p>
    <ol>
        <li>Seleccionar la columna de fechas de vencimiento (ej: <code>F2:F200</code>).</li>
        <li>Ir a <em>Inicio ➔ Formato condicional ➔ Nueva regla...</em></li>
        <li>Seleccionar la opción: <strong>''Utilice una fórmula que determine las celdas para aplicar formato''</strong>.</li>
        <li>Escribir la fórmula: <code>=F2 < HOY()</code> (utilizando referencia relativa en F2 para que Excel evalúe cada fila).</li>
        <li>Hacer clic en <em>Formato</em>, elegir relleno rojo claro con texto rojo oscuro y aceptar. Todas las facturas con fecha anterior a hoy se pintarán de rojo automáticamente sin intervención manual.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Invertir el orden de los rangos en SUMAR.SI.CONJUNTO:</strong> Como mencionamos, en <code>SUMAR.SI</code> el rango a sumar es el último argumento, mientras que en <code>SUMAR.SI.CONJUNTO</code> es el primero. Invertirlos hace que Excel devuelva 0 o un error de sintaxis.</li>
        <li><strong>No usar comillas en operadores lógicos de comparación:</strong> Si deseas sumar valores mayores a 100, el criterio debe escribirse entre comillas dobles: <code>">100"</code>. Si escribes <code>>100</code> sin comillas, la fórmula fallará.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Recordaste que en SUMAR.SI.CONJUNTO el rango numérico a sumar va obligatoriamente al inicio?</li>
            <li>¿Escribiste entre comillas los operadores relacionales en criterios (ej: ">=500")?</li>
            <li>¿Utilizaste la función HOY() en tus reglas de formato condicional para que los vencimientos se actualicen solos cada día?</li>
        </ul>
    </div>
</div>', 'Domina el análisis cuantitativo por criterios: SUMAR.SI, SUMAR.SI.CONJUNTO, CONTAR.SI.CONJUNTO y PROMEDIO.SI. Configura reglas de Formato Condicional con fórmulas para semaforizar vencimientos automáticamente.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (22, 22, 'De Consultas Vagas a Instrucciones de Precisión Quirúrgica', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-stars fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La IA es tan Inteligente como la Calidad de tu Instrucción</h5>
            <p class="mb-0 small">Pedirle a Gemini o ChatGPT ''escribe un correo para un cliente'' produce un texto plano e inútil. El Prompt Engineering es la habilidad técnica de programar a la IA en lenguaje natural con directrices precisas y cuantificables.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/p2PqfRte46k" title="La Fórmula del Prompt Perfecto para ChatGPT (Guía Definitiva)" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Fundamentos de los Modelos de Lenguaje y Tokenización</h4>
    <p>Para utilizar herramientas como <strong>Google Gemini</strong> y <strong>OpenAI ChatGPT</strong> con eficacia corporativa, es indispensable derribar el mito de que ''la IA piensa o razona como un ser humano''. En realidad, los Grandes Modelos de Lenguaje (LLMs) son gigantescas redes neuronales probabilísticas entrenadas con billones de fragmentos de texto. Su función central consiste en predecir matemáticamente cuál es la siguiente unidad lingüística más coherente (denominada <em>token</em>, equivalente aproximado a 4 caracteres o tres cuartos de palabra en español) dado el contexto que el usuario le suministra.</p>
    <p>Cuando un profesional envía un mensaje sin contexto (''redacta un informe de ventas''), el modelo se ve obligado a explorar un espacio de probabilidades inmenso, entregando un resultado genérico, vago y carente de utilidad práctica. Por el contrario, cuando delimitamos la conversación aportando antecedentes específicos, el modelo restringe su espacio probabilístico a la terminología, tono y estructura requeridos por la organización.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-boxes text-primary me-2"></i>2. El Framework R.T.F.R. para Prompts de Alto Impacto</h4>
    <p>Para garantizar que cada instrucción genere una respuesta ejecutiva y aplicable sin necesidad de repreguntar múltiples veces, los consultores en productividad recomiendan estructurar el requerimiento bajo el estándar <strong>R.T.F.R.</strong>:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width: 15%;">Componente</th>
                    <th style="width: 25%;">Función Pedagógica</th>
                    <th>Ejemplo Aplicado a una Empresa Real</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">R - Rol (Role)</td>
                    <td>Define la perspectiva experta, el nivel de seniority y el vocabulario técnico que la IA adoptará.</td>
                    <td><code>Actúa como un Director Financiero (CFO) y Auditor Corporativo con 20 años de trayectoria en retail.</code></td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">T - Tarea (Task)</td>
                    <td>Describe el objetivo operativo exacto, sin ambigüedades, verbos difusos ni peticiones cruzadas.</td>
                    <td><code>Analiza este estado de resultados preliminar del mes y detecta los 3 centros de costo con mayor desviación desfavorable frente al presupuesto.</code></td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">F - Formato (Format)</td>
                    <td>Fija la disposición visual de la respuesta: tablas, listas con viñetas, esquemas de reporte o código.</td>
                    <td><code>Presenta los hallazgos en una tabla comparativa con columnas: Centro de Costo, Presupuesto, Real, Desviación % y Acción Correctiva Sugerida.</code></td>
                </tr>
                <tr>
                    <td class="fw-bold text-primary">R - Restricciones (Restrictions)</td>
                    <td>Establece fronteras estrictas para erradicar el relleno, limitar extensión y prohibir alucinaciones.</td>
                    <td><code>No utilices saludos de cortesía ni introducciones vacías. Limítate a los datos suministrados. Máximo 250 palabras de análisis cualitativo.</code></td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso de Estudio Empresarial: De la Instrucción Pobre al Prompt Profesional</h4>
    <div class="card border-0 bg-light p-3 rounded-3 mb-4">
        <h6 class="fw-bold text-dark mb-2">Escenario: Redacción de Reclamo Formal por Incumplimiento de Entrega</h6>
        <div class="row g-3">
            <div class="col-md-6">
                <div class="p-3 bg-white rounded border border-danger h-100">
                    <span class="badge bg-danger mb-2">Prompt Inadecuado (Resultado Mediocre)</span>
                    <p class="small text-muted mb-0 font-monospace">"Escribe una carta brava para un proveedor que no entregó la mercancía a tiempo y nos causó problemas."</p>
                    <p class="small text-secondary mt-2 mb-0"><em>Consecuencia:</em> La IA genera una carta genérica, cargada de agresividad infantil, sin fechas, sin referencias a cláusulas y sin fuerza jurídica mercantil.</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 bg-white rounded border border-success h-100">
                    <span class="badge bg-success mb-2">Prompt RTFR Profesional (Resultado Listo para Firma)</span>
                    <p class="small text-dark mb-0 font-monospace">"Actúa como Abogado Mercantil y Gerente de Compras. Redacta una notificación formal de intimación dirigida a ''Distribuciones Logísticas C.A.'' por retraso de 14 días en la entrega de la Orden de Compra N° OC-4029. Cita la Cláusula 8 de penalidad diaria (0.5%). Exige entrega en 48 horas bajo apercibimiento de rescisión contractual y cobro de fianza. Tono firme, institucional y estrictamente profesional. Formato carta formal con membrete y campos entre corchetes."</p>
                </div>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes y Cómo Evitarlos</h4>
    <ul>
        <li><strong>Instrucciones Negativas Ineficaces:</strong> Indicar ''no seas aburrido'' o ''no uses lenguaje complejo'' suele provocar confusión en los pesos de atención del modelo. Siempre es preferible usar pautas positivas directas: <em>''Utiliza oraciones breves, vocabulario accesible y tono comercial persuasivo''</em>.</li>
        <li><strong>Sobrecargar el Primer Turno con Información No Filtrada:</strong> Pegar un texto caótico de 20 páginas sin explicar primero qué se espera hacer con él genera respuestas superficiales. Primero define el marco analítico, y luego entrega los datos por bloques.</li>
        <li><strong>Falta de Parámetros de Extensión Cuantificables:</strong> Si pides ''un resumen'', el modelo puede redactar 3 párrafos o 5 páginas según su configuración. Solicita siempre: <em>''Máximo 150 palabras divididas en 3 viñetas concisas''</em>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Definiste claramente quién es el emisor ideal de la respuesta (Rol)?</li>
            <li>¿Indicaste el destinatario final del documento (Director, Cliente, Equipo Operativo)?</li>
            <li>¿Especificaste el formato de entrega (Tabla Markdown, Lista con viñetas, Código ejecutable)?</li>
            <li>¿Pusiste restricciones explícitas de longitud, tono y prohibición de supuestos no verificables?</li>
        </ul>
    </div>
</div>', 'Comprende cómo funcionan los Grandes Modelos de Lenguaje (LLMs), por qué ocurren las alucinaciones y cómo aplicar la estructura RTFR (Rol, Tarea, Formato, Restricciones) para obtener respuestas ejecutivas al primer intento.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (23, 23, 'Guía a la IA Paso a Paso con Ejemplos y Razonamiento Lógico', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-3-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Pensar Antes de Responder: Chain of Thought y Few-Shot</h5>
            <p class="mb-0 small">Cuando le pides a un modelo de IA que razone paso a paso (''Piensa paso a paso antes de dar el veredicto final''), la tasa de precisión matemática y lógica aumenta de un 60% a más del 92% en pruebas corporativas estandarizadas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/5wQw3T9tb3c" title="🎓CURSO PROMPT ENGINEERING  en Español - GRATIS - 🤖CLASE 06- ZERO SHOT, ONE-SHOT, FEW-SHOT PROMPTING" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Jerarquía del Aprendizaje en el Contexto: De Zero a Few-Shot</h4>
    <p>En el uso diario de modelos como Gemini, existen tres niveles de contextualización según la cantidad de referencias previas suministradas:</p>
    <ul>
        <li><strong>Zero-Shot (Cero Ejemplos):</strong> Se le solicita al modelo realizar una tarea directamente sin proveer ningún patrón previo. Es útil para consultas sencillas de cultura general o traducciones literales, pero altamente riesgoso para tareas corporativas donde la empresa tiene un manual de estilo propio.</li>
        <li><strong>One-Shot (Un Ejemplo):</strong> Se le entrega un único par modelo de <em>Entrada ➔ Salida esperada</em>. Con esto el modelo alinea el vocabulario básico y la longitud deseada.</li>
        <li><strong>Few-Shot (Múltiples Ejemplos de Referencia):</strong> Se introducen de 3 a 5 ejemplos perfectamente estructurados antes de plantear la tarea real. Esta técnica elimina la ambigüedad y permite a la IA replicar clasificaciones complejas (por ejemplo: categorizar correos de clientes como ''Urgente Financiero'', ''Duda Operativa'' o ''Reclamo Legal'') con más del 98% de fidelidad al criterio humano del departamento.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-cpu text-primary me-2"></i>2. La Técnica Chain-of-Thought (Cadena de Pensamiento)</h4>
    <p>Los LLMs no cuentan con una memoria de cálculo separada para números; calculan texto en base a probabilidades. Si le pides a una IA que calcule de golpe el inventario final con mermas y traslados múltiples, es probable que cometa un error aritmético. Sin embargo, al instruir al modelo a <strong>explicitar su razonamiento paso a paso</strong> antes de emitir la cifra definitiva, forzamos a la red a generar tokens de cálculo intermedio que retroalimentan el cálculo final.</p>

    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <h6 class="fw-bold text-dark mb-2"><i class="bi bi-terminal text-success me-2"></i>Estructura Práctica de un Prompt Chain-of-Thought (CoT) en Logística</h6>
        <p class="small text-muted mb-2 font-monospace">
            "Actúa como Supervisor de Almacén. Tenemos la siguiente situación operativa:<br />
            - Inventario inicial el lunes: 1.250 bultos.<br />
            - El martes despachamos 420 bultos a sucursales.<br />
            - El miércoles recibimos 600 bultos, pero tras la inspección de calidad se rechaza el 8% por rotura de embalaje.<br />
            - El jueves transferimos el 25% del stock remanente disponible a la bodega secundaria.<br /><br />
            <strong>Instrucción Metodológica:</strong> No entregues la respuesta directamente. Resuelve desglosando obligatoriamente los siguientes 4 pasos:<br />
            Paso 1: Saldo neto al cierre del martes.<br />
            Paso 2: Bultos recibidos aptos el miércoles (mostrando el cálculo del 8% de rechazo y redondeo al entero más cercano).<br />
            Paso 3: Cálculo del 25% transferido el jueves sobre el saldo acumulado real.<br />
            Paso 4: Saldo final exacto de bultos en la bodega principal al cierre de semana en una tabla resumen."
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-people-fill text-primary me-2"></i>3. Roles Multidisciplinarios y Comités de Expertos Virtuales</h4>
    <p>Para decisiones estratégicas (como evaluar el lanzamiento de un nuevo servicio o auditar un contrato), una técnica de vanguardia es simular un <em>Comité Virtual de Evaluación</em>. En lugar de pedir una sola opinión, solicitas que la IA analice el documento desde 3 ópticas simultáneas:</p>
    <ol>
        <li><strong>El Abogado Corporativo:</strong> Identifica riesgos legales, vacíos de responsabilidad civil y sanciones aplicables.</li>
        <li><strong>El Gerente de Operaciones:</strong> Evalúa la viabilidad técnica, tiempos de entrega y capacidad de personal.</li>
        <li><strong>El Director de Experiencia del Cliente (CX):</strong> Analiza el impacto en la satisfacción, facilidad de uso y percepción de marca.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos en el Uso de Técnicas Avanzadas</h4>
    <ul>
        <li><strong>Proveer Ejemplos Few-Shot Contradictorios:</strong> Si en el ejemplo 1 clasificas un reclamo como ''Nivel 1'' y en el ejemplo 2 clasificas una queja idéntica como ''Nivel 3'', el modelo se confundirá y generará clasificaciones erráticas.</li>
        <li><strong>Olvidar Desactivar el Razonamiento Extenso en Respuestas Finales:</strong> Para flujos automáticos donde solo requieres un dato (''Aprobado'' o ''Rechazado''), debes indicar al final: <em>''Tras concluir el razonamiento interno, tu última línea debe contener exclusivamente la palabra de decisión''</em>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Usaste la directriz ''Razona paso a paso'' en prompts con cálculos o lógica de decisión?</li>
            <li>¿Verificaste que tus ejemplos Few-Shot tengan un formato 100% homogéneo?</li>
            <li>¿Separaste claramente las secciones de ''Contexto'', ''Ejemplos'' y ''Tarea Nueva'' usando delimitadores como comillas triples ("") o encabezados Markdown?</li>
        </ul>
    </div>
</div>', 'Domina el aprendizaje por ejemplos (Few-Shot) para estandarizar el tono de marca y la técnica de Cadena de Pensamiento (Chain of Thought) para resolver problemas matemáticos, lógicos y financieros complejos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (14, 14, 'Los Tres Pilares Defensivos y el Factor Humano como Primera Barrera', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-shaded fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La Ciberseguridad no es un Asunto de Servidores, es un Comportamiento Humano</h5>
            <p class="mb-0 small">Más del 90% de las intrusiones corporativas exitosas en el mundo no ocurren por fallos matemáticos en los algoritmos de cifrado, sino porque un empleado distraído abrió un enlace malicioso o entregó su contraseña por teléfono.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/_MJt0ugOc_E" title="¿Qué es la triada CIA en ciberseguridad? | Curso CIBERSEGURIDAD desde 0 2025" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Triada C.I.A.: El Marco Universal de Protección</h4>
    <p>En seguridad de la información corporativa, todas las políticas, firewalls y procedimientos de auditoría se evalúan bajo tres pilares inquebrantables conocidos como la <strong>Triada C.I.A.</strong> (por sus siglas en inglés: <em>Confidentiality, Integrity, Availability</em>):</p>
    <ul>
        <li><strong>Confidencialidad:</strong> Garantizar que la información sea accesible exclusivamente para los individuos, procesos o sistemas debidamente autorizados. Ejemplo en la oficina: Las carpetas de nómina y sueldos no pueden ser visibles para el personal operativo, únicamente para Recursos Humanos y Gerencia General.</li>
        <li><strong>Integridad:</strong> Salvaguardar la exactitud, completitud y fidelidad de los datos a lo largo de todo su ciclo de vida, evitando alteraciones accidentales o modificaciones maliciosas no autorizadas. Ejemplo: Un archivo contable no puede permitir que nadie altere el monto de un cheque ya liquidado.</li>
        <li><strong>Disponibilidad:</strong> Asegurar que los usuarios autorizados tengan acceso ininterrumpido y oportuno a los sistemas, bases de datos y servicios cuando lo requieran para operar la empresa. Si el sistema de facturación cae durante el horario comercial, la disponibilidad ha sido vulnerada.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-envelope-exclamation-fill text-danger me-2"></i>2. Ingeniería Social y Phishing: La Anatomía del Engaño</h4>
    <p>La <strong>Ingeniería Social</strong> es el arte de manipular psicológicamente a las personas para que violen los protocolos de seguridad de forma voluntaria. El vector más extendido es el <strong>Phishing</strong> (pesca de credenciales). Existen variantes críticas que todo profesional debe reconocer:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Variante</th>
                    <th>Mecanismo de Ataque</th>
                    <th>Señales de Alerta Críticas</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">Phishing Masivo</td>
                    <td>Correos genéricos enviados a millones de usuarios simulando ser entidades bancarias, Netflix o servicios postales.</td>
                    <td>Saludos genéricos (''Estimado cliente''), remitentes con dominios sospechosos (ej: <code>soporte@banc0-venezuela-alert.com</code>) y enlaces falsos.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Spear Phishing</td>
                    <td>Ataque quirúrgico dirigido a una persona específica de la empresa (ej: el asistente de pagos), utilizando su nombre real, cargo y nombres de sus superiores recopilados en LinkedIn.</td>
                    <td>El atacante se hace pasar por el Gerente General y exige una transferencia de emergencia urgente a una cuenta no registrada en el ERP.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Smishing / Vishing</td>
                    <td>Engaño a través de mensajes de texto SMS o llamadas telefónicas directas simulando ser personal de soporte técnico bancario.</td>
                    <td>Exigen que se les dicte el código OTP de 6 dígitos que acaba de llegar al teléfono celular bajo pretexto de ''bloquear un cargo fraudulento''.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico de Oficina: Protocolo de Verificación ante Correo Sospechoso</h4>
    <div class="card border-0 bg-light p-3 rounded-3 mb-4">
        <h6 class="fw-bold text-dark mb-2">Situación Real: Recibes un correo titulado: ''Urgente: Factura vencida y suspensión de servicio - Cuentas por Cobrar''</h6>
        <p class="small text-secondary mb-2">El correo contiene un archivo adjunto llamado <code>Factura_Vencida_402.pdf.exe</code> o un enlace que lleva a una página idéntica al portal de inicio de sesión de Microsoft Office 365.</p>
        <p class="small text-dark mb-0 font-monospace">
            <strong>Paso 1: Inspeccionar el remitente real:</strong> No te fíes del nombre visible. Haz clic en la dirección completa para verificar el dominio posterior a la arroba (<code>@dominio.com</code>). Si dice <code>facturacion@empresa-aliada.net.co.xyz</code>, es un fraude.<br />
            <strong>Paso 2: Inspeccionar el enlace sin hacer clic (Hovering):</strong> Pasa el cursor del ratón sobre el botón sin presionar. En la esquina inferior del navegador aparecerá la URL real a la que dirige. Si no coincide con el dominio oficial de la empresa, es phishing.<br />
            <strong>Paso 3: Verificación por canal secundario fuera de banda:</strong> Llama por teléfono o consulta por chat interno a la persona que supuestamente envió la factura antes de abrir cualquier archivo adjunto.<br />
            <strong>Paso 4: Notificación al departamento de TI:</strong> Reenvía el correo como archivo adjunto al equipo de seguridad informática para que bloqueen el remitente en el firewall del servidor.
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Creer en el candado del navegador a ciegas:</strong> El candado verde (HTTPS / SSL) solo significa que la conexión entre tu computador y el sitio está cifrada; NO garantiza que el dueño de la web sea honesto. Los atacantes también instalan certificados SSL gratuitos en sus páginas falsas.</li>
        <li><strong>Descargar archivos comprimidos con contraseñas provistas en el mismo correo:</strong> Los atacantes envían archivos <code>.zip</code> o <code>.rar</code> protegidos con clave para evitar que el antivirus del servidor de correo inspeccione el malware antes de que llegue a tu bandeja.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste el dominio exacto del remitente antes de responder o hacer clic?</li>
            <li>¿Comprobaste la extensión real de los archivos adjuntos (asegurando que no terminen en .exe, .scr, .vbs o .bat)?</li>
            <li>¿Desconfiaste de cualquier comunicación que te obligue a actuar ''con urgencia extrema antes de 1 hora''?</li>
        </ul>
    </div>
</div>', 'Domina los conceptos de Confidencialidad, Integridad y Disponibilidad. Aprende a detectar técnicas de Spear Phishing, analizar cabeceras de correo fraudulentas y neutralizar la ingeniería social en la oficina.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (245, 245, 'Despliegue Estandarizado de Imágenes y Solución de Pantallas Azules (BSOD)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-windows fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Instalación Limpia: La Solución Definitiva a Fallas Crónicas de Software</h5>
            <p class="mb-0 small">Un sistema operativo mal instalado con controladores genéricos o esquemas de partición obsoletos reduce el rendimiento del hardware a la mitad y genera inestabilidad continua en las operaciones diarias de la oficina.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/9vA2cI7I-6Q" title="✅ Cómo FORMATEAR tu PC e INSTALAR Windows 11 desde USB | 2026" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Arquitectura Moderna de Arranque: UEFI vs Legacy BIOS y GPT vs MBR</h4>
    <p>Para instalar sistemas operativos modernos como Windows 11 o Windows 10 en empresas actuales, es fundamental entender el salto tecnológico entre los estándares antiguos y modernos:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Parámetro</th>
                    <th>Estándar Antiguo (Legacy / MBR)</th>
                    <th>Estándar Corporativo Moderno (UEFI / GPT)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold">Firmware de la Placa</td>
                    <td>BIOS tradicional (pantalla azul o gris sin soporte para ratón).</td>
                    <td><strong>UEFI (Unified Extensible Firmware Interface):</strong> Interfaz gráfica moderna, arranque seguro (Secure Boot) y soporte de red nativo.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Tabla de Particiones</td>
                    <td>MBR (Master Boot Record): Límite máximo de 2 Terabytes por disco y un máximo de 4 particiones primarias.</td>
                    <td><strong>GPT (GUID Partition Table):</strong> Soporte para discos de hasta 18 Exabytes, particiones prácticamente ilimitadas y copias redundantes de la tabla de arranque para autorrecuperación.</td>
                </tr>
                <tr>
                    <td class="fw-bold">Seguridad de Arranque</td>
                    <td>Vulnerable a rootkits y virus que infectan el sector de arranque maestro antes de que cargue el antivirus.</td>
                    <td><strong>Secure Boot:</strong> Valida digitalmente la firma de cada controlador y cargador de arranque antes de ejecutarlo.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-usb-drive-fill text-primary me-2"></i>2. Preparación Profesional del Medio de Instalación (USB Booteable)</h4>
    <p>Para crear una memoria USB de instalación limpia estándar, la herramienta más confiable y extendida es <strong>Rufus</strong>:</p>
    <ol>
        <li>Descargar la imagen ISO oficial más reciente directamente desde el portal oficial de Microsoft.</li>
        <li>En Rufus, seleccionar la unidad USB (mínimo 8 GB a 16 GB).</li>
        <li>Seleccionar el esquema de partición: <strong>GPT</strong> y el sistema de destino: <strong>UEFI (no CSM)</strong>.</li>
        <li>Iniciar el proceso y esperar a que verifique la integridad del archivo ISO.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-bug-fill text-danger me-2"></i>3. Diagnóstico de Pantallas Azules (BSOD - Blue Screen of Death)</h4>
    <p>Una pantalla azul de Windows no ocurre ''por mala suerte''; es una detención de seguridad controlada del kernel cuando detecta que continuar ejecutándose corrompería la memoria del sistema. Cada BSOD genera un archivo de registro llamado <em>Minidump</em> (ubicado en <code>C:\Windows\Minidump</code>). Mediante herramientas gratuitas como <strong>BlueScreenView</strong> o el depurador oficial <em>WinDbg</em> de Microsoft, el técnico puede identificar el archivo exacto causante del fallo:</p>
    <ul>
        <li><code>DRIVER_IRQL_NOT_LESS_OR_EQUAL</code>: Controlador corrupto o incompatible (suele apuntar a controladores de tarjeta gráfica o tarjeta de red Wi-Fi).</li>
        <li><code>MEMORY_MANAGEMENT</code>: Casi siempre causado por un módulo de memoria RAM defectuoso o zócalo sucio. Se descarta ejecutando la herramienta de diagnóstico de memoria de Windows o <em>MemTest86</em>.</li>
        <li><code>INACCESSIBLE_BOOT_DEVICE</code>: Fallo en el controlador del disco de almacenamiento (modo AHCI/RAID mal configurado en BIOS) o corrupción en el registro de arranque.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Instalar controladores desde sitios web no oficiales o paquetes ''todo en uno'':</strong> Muchos programas de actualización automática de drivers inyectan adware, versiones beta inestables o controladores genéricos que provocan pantallas azules. Siempre descarga los controladores desde el portal oficial de soporte del fabricante del equipo (Dell, HP, Lenovo, ASUS).</li>
        <li><strong>Formatear sin consultar la carpeta de descargas y documentos locales del usuario:</strong> Aunque los usuarios afirman que todo está en la nube, con frecuencia guardan claves bancarias o archivos contables críticos en el escritorio local o en carpetas temporales.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respaldaste la información del usuario y confirmaste que los marcadores de su navegador estén sincronizados?</li>
            <li>¿Configuraste la BIOS/UEFI en modo GPT/UEFI y activaste el módulo TPM 2.0 y Secure Boot?</li>
            <li>¿Verificaste el Administrador de Dispositivos (devmgmt.msc) para comprobar que no quede ningún signo de interrogación amarillo sin controlador instalado?</li>
        </ul>
    </div>
</div>', 'Domina la preparación de medios de arranque con Rufus, configuración de BIOS/UEFI, particionado GPT vs MBR, instalación de controladores oficiales y análisis de archivos Minidump ante errores BSOD.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (136, 136, 'Inmunidad ante Pérdidas de Información y Continuidad Operativa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cloud-arrow-up-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">No Existe Respaldo si Nunca se ha Probado su Restauración</h5>
            <p class="mb-0 small">Hacer copias de seguridad que nadie ha verificado es una ilusión peligrosa. El verdadero valor de una estrategia de respaldo se mide en la velocidad y certeza con la que la empresa puede volver a facturar tras un desastre.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/Fi1wPlUnh4k" title="4 claves para asegurar la continuidad de tú negocio con la estrategia DRP en AWS" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Regla Universal de Respaldo 3-2-1</h4>
    <p>La regla <strong>3-2-1</strong> es el estándar dorado recomendado por agencias internacionales de ciberseguridad para garantizar que ninguna catástrofe (incendio, inundación, fallo de hardware o ataque de ransomware) pueda destruir el patrimonio de datos de la organización:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="p-3 bg-white rounded border border-primary h-100">
                <h5 class="fw-bold text-primary mb-1">3 Copias de los Datos</h5>
                <p class="small text-muted mb-0">Mantener el archivo de trabajo principal y al menos dos copias de seguridad actualizadas de toda la base de datos y documentos críticos.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-white rounded border border-success h-100">
                <h5 class="fw-bold text-success mb-1">2 Medios Diferentes</h5>
                <p class="small text-muted mb-0">Almacenar las copias en al menos dos tipos de soportes tecnológicos distintos (por ejemplo: un servidor NAS local y cintas o almacenamiento en la nube S3), para evitar que un fallo masivo de tecnología afecte a ambos.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3 bg-white rounded border border-danger h-100">
                <h5 class="fw-bold text-danger mb-1">1 Copia Fuera de Sitio</h5>
                <p class="small text-muted mb-0">Al menos una copia debe residir en una ubicación geográfica físicamente alejada o en la nube con política de <em>inmutabilidad (WORM: Write Once, Read Many)</em> que impida su borrado por 30 días.</p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-stopwatch-fill text-primary me-2"></i>2. Métricas Clave de Continuidad: RTO y RPO</h4>
    <p>En el diseño de un <strong>Plan de Recuperación ante Desastres (DRP - Disaster Recovery Plan)</strong>, la gerencia de la empresa y el equipo técnico deben acordar dos parámetros vitales:</p>
    <ul>
        <li><strong>RPO (Recovery Point Objective - Objetivo de Punto de Recuperación):</strong> La cantidad máxima de tiempo de datos que la empresa está dispuesta a perder en el peor escenario. Si el RPO es de 2 horas, significa que se deben realizar respaldos cada 2 horas; si el sistema cae, solo se perderán como máximo las últimas 2 horas de transacciones.</li>
        <li><strong>RTO (Recovery Time Objective - Objetivo de Tiempo de Recuperación):</strong> El tiempo máximo tolerable que los sistemas pueden permanecer caídos antes de que la empresa sufra daños económicos irreversibles. Si el RTO es de 4 horas, el equipo de TI debe tener los servidores operativos antes de que venza ese plazo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-clipboard2-pulse-fill text-primary me-2"></i>3. Simulacros Periódicos de Restauración (Disaster Drills)</h4>
    <p>El error más grave de los departamentos administrativos es dar por sentado que los respaldos automáticos funcionan porque una luz verde titila en la consola. Una vez por trimestre es obligatorio ejecutar una <strong>prueba de restauración en frío</strong>:</p>
    <ol>
        <li>Seleccionar una máquina virtual o servidor de pruebas totalmente aislado.</li>
        <li>Descargar la copia de respaldo de la semana anterior.</li>
        <li>Restaurar la base de datos completa y levantar el software administrativo ERP.</li>
        <li>Comprobar que un usuario pueda iniciar sesión, consultar el saldo de un cliente y emitir un reporte de inventario sin errores de corrupción.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Respaldos con credenciales compartidas con el dominio principal:</strong> Si el usuario administrador del dominio es el mismo que tiene permiso para borrar los respaldos en la nube, el ransomware usará esas credenciales para borrar los respaldos antes de cifrar el servidor.</li>
        <li><strong>No incluir en el respaldo los archivos de configuración y licencias:</strong> Restaurar la base de datos no sirve de nada si no se tienen respaldados los certificados digitales de facturación electrónica y las llaves de configuración del sistema.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Se ejecutan copias automáticas diarias y se guardan fuera de la oficina principal?</li>
            <li>¿Se ha realizado al menos una prueba exitosa de restauración de datos en los últimos 90 días?</li>
            <li>¿Está documentado el procedimiento paso a paso de recuperación ante desastres en un manual accesible fuera de línea?</li>
        </ul>
    </div>
</div>', 'Implementa la regla universal de respaldo 3-2-1 con copias desconectadas e inmutables. Comprende los conceptos de RTO (Objetivo de Tiempo de Recuperación) y RPO (Objetivo de Punto de Recuperación).', 45, 1, true);
INSERT INTO public."Lessons" VALUES (89, 89, '¿Servidores Propios o la Nube? Evaluación Económica y Operativa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cloud-check-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">La Nube es un Modelo Financiero y Operativo, no solo un Lugar de Almacenamiento</h5>
            <p class="mb-0 small">Migrar a la nube no se trata de apagar un servidor local para encenderlo en internet, sino de transformar gastos fijos monumentales de infraestructura física en costos operativos flexibles que crecen o disminuyen según el ritmo de las ventas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/VR8aXePkQ5M" title="📌CLOUD COMPUTING ¿Qué es IaaS, PaaS y Saas? | Modelos de Servicio Cloud" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Los Tres Modelos Fundamentales de Servicio Cloud</h4>
    <p>Para tomar decisiones acertadas de contratación tecnológica, los gerentes deben dominar la pirámide de modelos en la nube:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Modelo</th>
                    <th>¿Qué Gestiona el Proveedor Cloud?</th>
                    <th>¿Qué Gestiona tu Empresa?</th>
                    <th>Ejemplos Cotidianos en la Oficina</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">SaaS (Software as a Service)</td>
                    <td>Todo: Hardware, redes, sistema operativo, base de datos y la aplicación completa.</td>
                    <td>Únicamente los datos que ingresas y los permisos de tus usuarios.</td>
                    <td>Microsoft 365, Google Workspace, Salesforce, Shopify, Zoom.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">PaaS (Platform as a Service)</td>
                    <td>Infraestructura de hardware, sistema operativo, parches de seguridad y servidores web.</td>
                    <td>El código de tus aplicaciones propias y los datos de las bases de datos.</td>
                    <td>AWS Elastic Beanstalk, Google App Engine, Heroku, Azure App Services.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">IaaS (Infrastructure as a Service)</td>
                    <td>Hardware físico, centros de datos globales, energía eléctrica y virtualización base.</td>
                    <td>Todo lo demás: Instalación del sistema operativo, cortafuegos, bases de datos y programas.</td>
                    <td>Amazon EC2, Google Compute Engine, Microsoft Azure Virtual Machines.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-cash-coin text-success me-2"></i>2. Evaluación Financiera: CAPEX vs OPEX y Cálculo del TCO</h4>
    <p>Comprar un servidor físico propio (On-Premise) requiere un gasto de capital inicial masivo (<strong>CAPEX - Capital Expenditures</strong>): adquirir el servidor físico, baterías UPS, sistema de aire acondicionado para la sala de servidores, cableado y licencias perpetuas costosas. Tras 5 años, ese hardware se vuelve obsoleto y debe recomprarse.</p>
    <p>Por el contrario, la computación en la nube opera bajo un modelo de gastos operativos (<strong>OPEX - Operational Expenditures</strong>): pagas mensualmente solo por los recursos que efectivamente consumes. Si la empresa crece, amplías la memoria con un clic; si las ventas bajan, reduces los servidores y disminuyes el gasto de inmediato.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico: Comparación de TCO a 3 Años</h4>
    <div class="card border-0 bg-light p-3 rounded-3 mb-4">
        <h6 class="fw-bold text-dark mb-2">Escenario: Servidor de Base de Datos para Sistema Administrativo</h6>
        <div class="row g-3">
            <div class="col-md-6">
                <div class="p-3 bg-white rounded border h-100">
                    <span class="badge bg-secondary mb-2">Opción Servidor Físico Propio (On-Premise)</span>
                    <ul class="small mb-0 text-muted">
                        <li>Compra de Servidor Dell PowerEdge: $4.500 USD</li>
                        <li>Licencia Windows Server + CALs: $1.800 USD</li>
                        <li>Aire acondicionado dedicado y energía 24/7: $1.200 USD/año</li>
                        <li>Soporte técnico y mantenimiento físico: $1.500 USD/año</li>
                        <li><strong>TCO Total a 3 años: ~$14.400 USD</strong></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 bg-white rounded border border-success h-100">
                    <span class="badge bg-success mb-2">Opción Instancia Cloud (AWS / Azure)</span>
                    <ul class="small mb-0 text-dark">
                        <li>Máquina virtual escalable optimizada: $140 USD/mes</li>
                        <li>Respaldos automáticos georedundantes: $25 USD/mes</li>
                        <li>Cero costo de energía eléctrica local ni aire acondicionado.</li>
                        <li>Actualizaciones de hardware transparentes sin compras nuevas.</li>
                        <li><strong>TCO Total a 3 años: ~$5.940 USD (Ahorro del 58%)</strong></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar servidores cloud sobredimensionados encendidos sin control de costos:</strong> Si contratas máquinas virtuales gigantescas y no configuras apagados automáticos fuera de horario de oficina, las facturas mensuales de AWS o Azure pueden multiplicarse sorpresivamente.</li>
        <li><strong>No considerar la calidad de la conexión local a internet:</strong> Si migras todo tu sistema de facturación a la nube pero tu oficina tiene un único enlace de internet inestable y sin respaldo móvil (4G/5G de contingencia), cuando se corte el internet tu empresa no podrá operar.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Calculaste el costo total de propiedad (TCO) incluyendo energía, licencias y soporte antes de decidir?</li>
            <li>¿Configuraste alertas presupuestarias en la consola de la nube para evitar sorpresas en la facturación?</li>
            <li>¿Dispone la empresa de una conexión a internet secundaria de respaldo para asegurar la comunicación con la nube?</li>
        </ul>
    </div>
</div>', 'Comprende los modelos de servicio en la nube (Software as a Service, Platform as a Service e Infrastructure as a Service). Aprende a calcular el Costo Total de Propiedad (TCO) comparando CAPEX frente a OPEX.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (232, 232, 'Creación de Fichas de Producto Vendedoras y Colecciones Automatizadas', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-tag-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">La Ficha de Producto es tu Vendedor Virtual 24/7</h5>
            <p class="mb-0 small">En una tienda física el cliente puede tocar la tela o probarse el zapato. En internet, la decisión de compra depende 100% de la claridad visual de las fotos, la precisión de las tallas y la descripción persuasiva orientada a resolver dudas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/RHoDJhFzAyA" title="Cómo crear variantes de productos | Tallas, colores, precios y stock" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Anatomía de una Ficha de Producto de Alta Conversión</h4>
    <p>Para que un producto se venda con fluidez sin generar una avalancha de dudas por WhatsApp, la ficha debe estructurarse con rigor profesional:</p>
    <ul>
        <li><strong>Título Claro y Descriptivo:</strong> Marca + Tipo de Producto + Característica Principal (ej: <em>''Zapato Deportivo Ergonómico Transpirable para Correr - Modelo Sprint 2026''</em>).</li>
        <li><strong>Fotografía Profesional con Fondo Neutro y en Uso:</strong> Al menos 4 a 6 fotos de alta resolución con fondo blanco o gris claro, mostrando diferentes ángulos, primer plano de costuras/materiales y al menos una foto de la prenda puesta en una persona real.</li>
        <li><strong>Descripción Orientada a Beneficios (no solo características técnicas):</strong> En lugar de decir ''fabricado en poliéster 100%'', explica: <em>''Tejido ligero de secado rápido que disipa el calor corporal manteniéndote fresco durante todo el entrenamiento''</em>.</li>
        <li><strong>Tabla de Medidas Exactas:</strong> En calzado o ropa, incluir una guía de tallas en centímetros para erradicar las devoluciones por error de medida.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-layers-fill text-primary me-2"></i>2. Configuración de Variantes Complejas y Control de Stock por SKU</h4>
    <p>Si vendes una camiseta en 3 colores (Blanco, Negro, Azul) y 4 tallas (S, M, L, XL), tienes una matriz de <strong>12 variantes individuales</strong>. En Shopify:</p>
    <ol>
        <li>En la sección ''Variantes'', agregar la opción <em>Color</em> y luego la opción <em>Talla</em>.</li>
        <li>Shopify generará la matriz de 12 combinaciones. A cada variante debes asignarle su propio <strong>SKU único</strong> (ej: <code>CAM-BLA-M</code>) y su propio saldo de inventario independiente.</li>
        <li><strong>Vincular fotos a variantes:</strong> Asigna la foto de la camiseta azul a la variante ''Azul''. Cuando el cliente haga clic en el botón ''Azul'', la imagen principal de la tienda cambiará automáticamente al color seleccionado.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-folder-check text-success me-2"></i>3. Colecciones Manuales vs Colecciones Automatizadas con Etiquetas</h4>
    <p>Organizar los productos por categorías (ej: ''Hombres'', ''Novedades'', ''Ofertas de Verano'') se puede hacer de dos formas:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Tipo de Colección</th>
                    <th>Mecanismo</th>
                    <th>Ventaja Operativa</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Manual</td>
                    <td>El operador selecciona producto por producto y los agrega a la categoría a mano.</td>
                    <td>Útil para selecciones editoriales pequeñas o productos destacados temporales.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">Automatizada (Recomendada)</td>
                    <td>Se define una regla condicional basada en <strong>Etiquetas (Tags)</strong> o precio (ej: <em>''Etiqueta es igual a Calzado_Dama''</em>).</td>
                    <td><strong>Cero Mantenimiento:</strong> Cada vez que des de alta un zapato nuevo con la etiqueta <code>Calzado_Dama</code>, se publicará automáticamente en la categoría de la web sin necesidad de editar la colección.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Marcar la casilla ''Continuar vendiendo cuando se agote el stock'' sin control:</strong> Si dejas esta casilla marcada y no tienes stock garantizado de reposición inmediata, los clientes comprarán productos que no tienes en el depósito, provocando reclamos y cancelaciones obligadas.</li>
        <li><strong>Subir fotos pesadas de más de 5 MB cada una:</strong> Ralentiza la carga de la tienda en teléfonos móviles; cada segundo extra de carga reduce las ventas en un 20%. Utiliza formatos modernos como <code>WebP</code> o comprime las imágenes antes de subirlas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Asignaste SKUs únicos e independientes a cada combinación de talla y color?</li>
            <li>¿Vinculaste las imágenes específicas a cada variante de color?</li>
            <li>¿Organizaste tus categorías mediante Colecciones Automatizadas usando etiquetas consistentes?</li>
        </ul>
    </div>
</div>', 'Domina la gestión del catálogo: redacción persuasiva de fichas, fotografía de producto, configuración de variantes complejas (tallas, colores), SKU/códigos de barra y colecciones automáticas por etiquetas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (234, 234, 'Procesamiento de Órdenes, Embalaje, Despacho y Automatizaciones', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-cart-x-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Carritos Abandonados: Recuperar Dinero que ya Estaba en la Mesa</h5>
            <p class="mb-0 small">En el comercio electrónico mundial, el 70% de los usuarios agregan productos al carrito y se van sin pagar. Con una secuencia automatizada de correos y mensajes de recuperación, es posible rescatar entre un 15% y un 25% de esas ventas perdidas.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/MWMR1EBeVB4" title="Recuperación de Carritos Abandonados : Recupera Ventas en tu Tienda Online" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. El Ciclo de Vida de un Pedido en el Almacén de E-Commerce</h4>
    <p>Desde que el cliente presiona ''Pagar'' hasta que el paquete llega a sus manos, el pedido atraviesa cuatro estados operativos:</p>
    <ol>
        <li><strong>No Preparado (Unfulfilled):</strong> El pago está confirmado y el pedido entra a la cola de trabajo del almacén.</li>
        <li><strong>Picking y Packing:</strong> El operario toma la hoja de empaque (Packing Slip) impresa desde Shopify, recoge los artículos de las estanterías y los embala en cajas seguras con cinta de seguridad.</li>
        <li><strong>Preparado (Fulfilled):</strong> Se entrega el bulto a la empresa de transporte (MRW, DHL, Tealca) y se ingresa el <strong>Número de Rastreo (Tracking Number)</strong> en Shopify. Al presionar ''Marcar como preparado'', Shopify le envía automáticamente un correo y SMS al cliente con el enlace de seguimiento en vivo.</li>
        <li><strong>Entregado (Delivered):</strong> La transportadora confirma la entrega física y concluye el ciclo logístico.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-repeat text-primary me-2"></i>2. La Secuencia de Oro de Recuperación de Carritos Abandonados</h4>
    <p>Shopify cuenta con un motor nativo de automatización de correos para carritos abandonados (ubicado en <em>Marketing ➔ Automatizaciones ➔ Pago abandonado</em>). La mejor práctica internacional es configurar una secuencia de dos pasos:</p>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-primary mb-2">Mensaje 1: A las 2 Horas del Abandono</span>
                <p class="small text-muted mb-0"><strong>Enfoque de Asistencia y Servicio:</strong> <em>''¿Tuviste algún problema con tu pago? Notamos que dejaste tu pedido sin finalizar. Guardamos tu carrito para que puedas completarlo con un clic.''</em> (Muchos clientes abandonan simplemente porque el banco les pidió una clave de confirmación que no tenían a mano).</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <span class="badge bg-success mb-2">Mensaje 2: A las 24 Horas del Abandono</span>
                <p class="small text-muted mb-0"><strong>Incentivo Económico y Urgencia:</strong> <em>''Tu carrito está a punto de liberarse. Completa tu compra en las próximas 4 horas y disfruta de un 10% de descuento exclusivo usando el cupón: REGRESO10.''</em></p>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-star-fill text-warning me-2"></i>3. Fidelización y Retención: Convertir Compradores de 1 Sola Vez en Clientes Recurrentes</h4>
    <p>Adquirir un cliente nuevo mediante publicidad en redes sociales es hasta 7 veces más costoso que retener a un cliente que ya confía en tu marca. Estrategias de retención obligatorias:</p>
    <ul>
        <li><strong>Experiencia de Desempaque (Unboxing Experience):</strong> Incluir dentro del paquete una tarjeta de agradecimiento personalizada con un código de descuento para su próxima compra.</li>
        <li><strong>Email Postventa de Satisfacción:</strong> Enviar un correo automático a los 7 días de entregado el paquete consultando: <em>''¿Cómo te quedó tu producto? Califícanos con 5 estrellas y déjanos tu opinión''</em>.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tardar más de 24 horas en enviar el número de rastreo:</strong> La ansiedad de compra en internet es alta. Si no le envías el comprobante de despacho con su guía de seguimiento rápidamente, el cliente comenzará a escribir quejas por redes sociales creyendo que fue estafado.</li>
        <li><strong>Enviar correos de carrito abandonado a clientes que ya pagaron por otro medio:</strong> Si un cliente pagó manualmente por transferencia bancaria y no marcas el pedido como pagado en Shopify, el sistema le enviará un correo diciéndole que su carrito fue abandonado, generando confusión y molestia.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Ingresas siempre el número de rastreo y seleccionas la empresa de transporte al preparar cada orden?</li>
            <li>¿Tienes activada la secuencia automática de recuperación de pagos abandonados?</li>
            <li>¿Incluyes tarjetas de fidelización con incentivo de recompra en el embalaje físico del paquete?</li>
        </ul>
    </div>
</div>', 'Domina la operativa diaria de la tienda: preparación de pedidos, impresión de albaranes, emisión de códigos de seguimiento, automatización de recuperación de carritos y fidelización de clientes recurrentes.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (146, 146, 'Acciones en Progreso: Estructura Be + -ing, Reglas del Gerundio y Verbos Estativos', 'Reading', '<h4>1. Formación del Present Continuous</h4>
<p>El <strong>Present Continuous</strong> se utiliza para describir acciones que están ocurriendo <strong>exactamente en el momento en que se habla</strong> o situaciones temporales actuales:</p>

<div class="card p-3 border-success bg-light rounded-3 my-3">
    <h6 class="fw-bold text-success mb-2">Fórmula Matemática de Estructura:</h6>
    <p class="fs-5 mb-1"><strong>SUJETO + VERBO TO BE (am / is / are) + VERBO-ING</strong></p>
    <ul class="small mb-0 mt-2">
        <li><strong>Afirmativa:</strong> <em>I am studying English right now.</em> / <em>They are working in the garden.</em></li>
        <li><strong>Negativa:</strong> <em>She is not (isn''t) listening to music.</em></li>
        <li><strong>Interrogativa:</strong> <em>Are you watching television? &mdash; Yes, I am / No, I''m not.</em></li>
    </ul>
</div>

<h4>2. Reglas de Ortografía para Añadir -ing</h4>
<ul>
    <li><strong>Regla general:</strong> <em>read &rarr; reading</em>, <em>talk &rarr; talking</em>.</li>
    <li><strong>Terminados en -e muda:</strong> Se elimina la ''e'' &rarr; <em>write &rarr; writing</em>, <em>make &rarr; making</em>.</li>
    <li><strong>Monosílabos con Consonante + Vocal + Consonante (CVC):</strong> Se duplica la consonante final &rarr; <em>run &rarr; running</em>, <em>swim &rarr; swimming</em>, <em>sit &rarr; sitting</em>.</li>
</ul>

<h4>3. La Gran Diferencia: Present Simple vs. Present Continuous</h4>
<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Tiempo Verbal</th><th>Cuándo Usarlo</th><th>Palabras Clave Típicas</th><th>Ejemplo Demostrativo</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Present Simple</strong></td>
                <td>Hábitos, rutinas, hechos generales.</td>
                <td><em>every day, on Mondays, always, never</em></td>
                <td><em>I usually <strong>walk</strong> to work.</em> (Hábito cotidiano).</td>
            </tr>
            <tr>
                <td><strong>Present Continuous</strong></td>
                <td>Acción sucediendo ahora mismo o temporalmente.</td>
                <td><em>now, right now, at the moment, today</em></td>
                <td><em>Today it is raining, so I <strong>am taking</strong> a taxi.</em> (Acción en progreso hoy).</td>
            </tr>
        </tbody>
    </table>
</div>', 'Domina el Present Continuous para acciones que ocurren en el momento de hablar y aprende a diferenciarlo claramente del Present Simple habitual.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (147, 147, 'Guía del Pasado: Terminación -ed, Fonética (/t/, /d/, /id/), Verbos Irregulares y Auxiliar Did', 'Reading', '<h4>1. Verbos Regulares en Past Simple (-ed)</h4>
<p>Los verbos regulares forman el pasado simple añadiendo la terminación <code>-ed</code> a su forma base:</p>
<ul>
    <li><em>play &rarr; played</em>, <em>clean &rarr; cleaned</em>, <em>watch &rarr; watched</em>.</li>
    <li>Terminados en ''-e'': solo añaden ''-d'' &rarr; <em>live &rarr; lived</em>, <em>dance &rarr; danced</em>.</li>
    <li>Terminados en consonante + ''-y'': cambian a ''-ied'' &rarr; <em>study &rarr; studied</em>.</li>
    <li>Consonante-Vocal-Consonante monosílabo: doblan la consonante &rarr; <em>stop &rarr; stopped</em>.</li>
</ul>

<h4>2. Pronunciación Fonética de la Terminación -ed</h4>
<div class="row g-3 my-3">
    <div class="col-md-4">
        <div class="card p-3 border-primary h-100">
            <h6 class="fw-bold text-primary">Sonido /id/ (Extra Sílaba)</h6>
            <p class="small text-muted mb-0">Únicamente cuando el verbo termina en sonido <strong>/t/</strong> o <strong>/d/</strong>:<br><em>wanted, needed, invited, decided</em>.</p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 border-success h-100">
            <h6 class="fw-bold text-success">Sonido /t/ (Sordo)</h6>
            <p class="small text-muted mb-0">Tras consonantes sordas (/p/, /k/, /s/, /sh/, /ch/, /f/):<br><em>worked (/t/), watched (/t/), stopped (/t/), laughed (/t/)</em>.</p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 border-warning h-100">
            <h6 class="fw-bold text-warning">Sonido /d/ (Sonoro)</h6>
            <p class="small text-muted mb-0">Tras vocales y consonantes sonoras (/b/, /g/, /v/, /l/, /m/, /n/, /r/):<br><em>played (/d/), cleaned (/d/), lived (/d/)</em>.</p>
        </div>
    </div>
</div>

<h4>3. Verbos Irregulares Principales de Nivel A1</h4>
<p>Los verbos irregulares no siguen la regla de ''-ed'' y deben memorizarse. Los 10 más habituales:</p>
<div class="table-responsive my-3">
    <table class="table table-bordered table-striped align-middle">
        <thead class="table-dark">
            <tr><th>Infinitivo</th><th>Past Simple</th><th>Traducción</th><th>Ejemplo en Frase</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>be</strong></td><td>was / were</td><td>ser / estar</td><td><em>I was at home yesterday. / They were happy.</em></td></tr>
            <tr><td><strong>have</strong></td><td>had</td><td>tener</td><td><em>We had breakfast at 8:00 AM.</em></td></tr>
            <tr><td><strong>do</strong></td><td>did</td><td>hacer</td><td><em>He did a great job.</em></td></tr>
            <tr><td><strong>go</strong></td><td>went</td><td>ir</td><td><em>She went to London last summer.</em></td></tr>
            <tr><td><strong>see</strong></td><td>saw</td><td>ver</td><td><em>I saw Peter at the supermarket.</em></td></tr>
            <tr><td><strong>buy</strong></td><td>bought</td><td>comprar</td><td><em>They bought a new house.</em></td></tr>
            <tr><td><strong>come</strong></td><td>came</td><td>venir</td><td><em>He came to the party.</em></td></tr>
            <tr><td><strong>make</strong></td><td>made</td><td>fabricar / hacer</td><td><em>She made a delicious cake.</em></td></tr>
        </tbody>
    </table>
</div>

<h4>4. Negaciones y Preguntas en Pasado: Auxiliar DID</h4>
<p>Tanto para verbos regulares como irregulares, se emplea el auxiliar <strong>DID</strong> en preguntas y <strong>DIDN''T</strong> en negaciones, volviendo el verbo a su forma infinitivo base:</p>
<ul>
    <li>Afirmativa: <em>She <strong>went</strong> to the store.</em></li>
    <li>Negativa: <em>She <strong>didn''t go</strong> to the store.</em> (¡No ''didn''t went''!).</li>
    <li>Pregunta: <em><strong>Did</strong> you <strong>see</strong> the email? &mdash; Yes, I did / No, I didn''t.</em></li>
</ul>', 'Aprende a narrar sucesos concluidos en el pasado, la pronunciación correcta de -ed, los 20 verbos irregulares más comunes y el uso de Did/Didn''t.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (148, 148, 'Expresión del Futuro: Decisiones Espontáneas, Promesas, Planes e Intenciones', 'Reading', '<h4>1. Future Simple con el Auxiliar "Will"</h4>
<p>El modal <strong>Will</strong> (negación <strong>Won''t</strong>) se utiliza con la forma base del verbo para todos los pronombres (<em>I will, you will, he will...</em>):</p>
<ul>
    <li><strong>Decisiones Espontáneas:</strong> Tomadas en el instante exacto de hablar: <em>''The phone is ringing. I will (I''ll) answer it.''</em></li>
    <li><strong>Promesas y Ofrecimientos:</strong> <em>''I will always help you, I promise.''</em></li>
    <li><strong>Predicciones Subjetivas u Opiniones:</strong> <em>''I think technology will change education.''</em></li>
</ul>

<h4>2. Estructura de Futuro con "Be Going To"</h4>
<p>Se construye con el verbo To Be + <strong>going to</strong> + verbo base:</p>
<ul>
    <li><strong>Planes e Intenciones Premeditadas:</strong> Decisiones ya tomadas antes del momento de hablar: <em>''I am going to study English at university next year.''</em></li>
    <li><strong>Predicciones con Evidencia Visible Inmediata:</strong> Basadas en hechos que estás viendo ahora mismo: <em>''Look at those dark clouds! It is going to rain.''</em></li>
</ul>

<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Estructura</th><th>Propósito Principal</th><th>Ejemplo Práctico</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>WILL</strong></td>
                <td>Decisión espontánea / Promesa.</td>
                <td><em>''I''m cold. I will close the window.''</em></td>
            </tr>
            <tr>
                <td><strong>BE GOING TO</strong></td>
                <td>Plan premeditado / Evidencia clara.</td>
                <td><em>''We are going to visit our grandparents this weekend.''</em></td>
            </tr>
        </tbody>
    </table>
</div>', 'Aprende a expresar el futuro en inglés distinguiendo con claridad cuándo usar Will (decisiones espontáneas) y cuándo Be Going To (planes premeditados).', 25, 1, true);
INSERT INTO public."Lessons" VALUES (149, 149, 'Guía de Determinantes: Plurales Irregulares, This/That/These/Those y Pronombres Objeto', 'Reading', '<h4>1. Sustantivos: Plurales Regulares e Irregulares</h4>
<p>La mayoría de los sustantivos forman el plural añadiendo <code>-s</code> o <code>-es</code> (<em>book &rarr; books, bus &rarr; buses</em>). Sin embargo, en nivel A1 debes dominar los <strong>plurales irregulares</strong> más habituales:</p>
<ul>
    <li><em>child &rarr; children</em> (niño / niños)</li>
    <li><em>person &rarr; people</em> (persona / personas o gente)</li>
    <li><em>man &rarr; men</em> (hombre / hombres)</li>
    <li><em>woman &rarr; women</em> (mujer / mujeres)</li>
    <li><em>tooth &rarr; teeth</em> (diente / dientes)</li>
    <li><em>foot &rarr; feet</em> (pie / pies)</li>
</ul>

<h4>2. Adjetivos y Pronombres Demostrativos</h4>
<div class="table-responsive my-3">
    <table class="table table-bordered text-center align-middle">
        <thead class="table-dark">
            <tr><th>Distancia</th><th>Singular</th><th>Plural</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Cerca (Aquí)</strong></td>
                <td><strong>This</strong> (Este / Esta)<br><span class="small text-muted">This book here</span></td>
                <td><strong>These</strong> (Estos / Estas)<br><span class="small text-muted">These books here</span></td>
            </tr>
            <tr>
                <td><strong>Lejos (Allí)</strong></td>
                <td><strong>That</strong> (Ese / Aquel)<br><span class="small text-muted">That car over there</span></td>
                <td><strong>Those</strong> (Esos / Aquellos)<br><span class="small text-muted">Those cars over there</span></td>
            </tr>
        </tbody>
    </table>
</div>

<h4>3. Posesivos: Adjetivos vs. Pronombres</h4>
<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Sujeto</th><th>Adjetivo Posesivo (Acompaña nombre)</th><th>Pronombre Posesivo (Reemplaza nombre)</th></tr>
        </thead>
        <tbody>
            <tr><td>I</td><td>This is <strong>my</strong> car.</td><td>This car is <strong>mine</strong>.</td></tr>
            <tr><td>You</td><td>This is <strong>your</strong> passport.</td><td>This passport is <strong>yours</strong>.</td></tr>
            <tr><td>He</td><td>This is <strong>his</strong> phone.</td><td>This phone is <strong>his</strong>.</td></tr>
            <tr><td>She</td><td>This is <strong>her</strong> book.</td><td>This book is <strong>hers</strong>.</td></tr>
            <tr><td>We</td><td>This is <strong>our</strong> house.</td><td>This house is <strong>ours</strong>.</td></tr>
            <tr><td>They</td><td>This is <strong>their</strong> classroom.</td><td>This classroom is <strong>theirs</strong>.</td></tr>
        </tbody>
    </table>
</div>

<h4>4. Pronombres Personales Objeto (Object Pronouns)</h4>
<p>Se utilizan cuando la persona recibe la acción del verbo o va precedida de una preposición: <strong>me, you, him, her, it, us, them</strong>.</p>
<ul>
    <li><em>She called <strong>me</strong> yesterday.</em> (Ella me llamó ayer).</li>
    <li><em>Listen to <strong>him</strong>!</em> (¡Escúchalo a él!).</li>
    <li><em>We invited <strong>them</strong> to dinner.</em> (Los invitamos a ellos a cenar).</li>
</ul>', 'Domina los plurales irregulares en inglés, los adjetivos demostrativos de cercanía/lejanía, adjetivos vs. pronombres posesivos y los pronombres objeto.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (150, 150, 'Guía de Preposiciones: Reglas Nemotécnicas de In, On, At y Medios de Transporte', 'Reading', '<h4>1. Preposiciones de Tiempo: La Pirámide AT - ON - IN</h4>
<p>Para no equivocarte jamás con el tiempo, visualiza una pirámide de lo más específico a lo más general:</p>

<div class="row g-3 my-3">
    <div class="col-md-4">
        <div class="card p-3 border-danger h-100">
            <h6 class="fw-bold text-danger">AT (Punto Muy Específico)</h6>
            <p class="small text-muted mb-1">Horas exactas y momentos puntuales:</p>
            <ul class="small mb-0">
                <li><em>at 5:00 PM</em></li>
                <li><em>at noon / at midnight</em></li>
                <li><em>at night</em></li>
                <li><em>at the weekend</em> (UK)</li>
            </ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 border-warning h-100">
            <h6 class="fw-bold text-warning">ON (Días y Fechas)</h6>
            <p class="small text-muted mb-1">Días concretos del calendario:</p>
            <ul class="small mb-0">
                <li><em>on Monday, on Fridays</em></li>
                <li><em>on May 12th</em> (Fecha con día)</li>
                <li><em>on my birthday</em></li>
                <li><em>on Christmas Day</em></li>
            </ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 border-primary h-100">
            <h6 class="fw-bold text-primary">IN (Periodos Amplios)</h6>
            <p class="small text-muted mb-1">Meses, años, siglos y estaciones:</p>
            <ul class="small mb-0">
                <li><em>in July</em> (Solo el mes)</li>
                <li><em>in 2026</em> (Años)</li>
                <li><em>in summer</em> (Estaciones)</li>
                <li><em>in the morning / afternoon</em></li>
            </ul>
        </div>
    </div>
</div>

<h4>2. Preposiciones de Lugar y Espacio</h4>
<ul>
    <li><strong>AT:</strong> Ubicación como punto de referencia institucional o social: <em>at home, at work, at school, at the bus stop</em>.</li>
    <li><strong>IN:</strong> Dentro de un espacio cerrado, ciudad o país: <em>in the kitchen, in Madrid, in Venezuela, in a box</em>.</li>
    <li><strong>ON:</strong> En contacto directo sobre una superficie o línea: <em>on the table, on the wall, on the second floor</em>.</li>
    <li><strong>UNDER:</strong> Debajo de algo: <em>The cat is under the chair</em>.</li>
    <li><strong>BETWEEN:</strong> En medio de dos elementos: <em>The bank is between the pharmacy and the bakery</em>.</li>
</ul>

<h4>3. Preposiciones con Medios de Transporte</h4>
<div class="alert alert-success border-0 p-3 rounded-3">
    <p class="mb-1"><strong>Regla General:</strong> Se utiliza <strong>BY</strong> para indicar el medio de transporte: <em>by car, by train, by bus, by plane, by boat</em>.</p>
    <p class="mb-0"><strong>Excepción Fundamental:</strong> Si te desplazas caminando se dice <strong>ON foot</strong> (nunca <em>by foot</em>).</p>
</div>', 'Aprende el uso infalible de AT, ON e IN para fechas, horas y ubicaciones espaciales, preposiciones de posición (under, above, between) y transporte con By vs. On.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (125, 125, 'La Estructura de las Sesiones One-on-One y el Modelo GROW', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-chat-quote-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Las Reuniones 1 a 1 Son la Herramienta Más Rentable del Liderazgo</h5>
            <p class="mb-0 small">Invertir 30 minutos quincenales en escuchar a cada colaborador a solas previene renuncias imprevistas, destapa bloqueos invisibles y alinea expectativas sin la presión del grupo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/DKPb5U13xhA" title="El poder de las reuniones one to one | Liderazgo | César Piqueras" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-calendar-event text-primary me-2"></i>1. ¿Cómo se Estructura una Reunión One-on-One Exitosa?</h4>
    <p>Una sesión 1 a 1 (1:1) NO es una revisión del estado de las tareas del día; para eso están los tableros Kanban y las reuniones de seguimiento. Una 1:1 es el espacio del colaborador para hablar de desarrollo profesional, bienestar y relaciones internas:</p>
    <ul>
        <li><strong>Frecuencia y Sagrada Prioridad:</strong> Debe realizarse cada 1 o 2 semanas con una duración fija de 30 a 45 minutos. Cancelarla o posponerla constantemente envía el mensaje tácito de que el colaborador no es importante para el líder.</li>
        <li><strong>Distribución del Tiempo (Regla 10-10-10):</strong>
            <ul>
                <li><em>Primeros 10 minutos:</em> Tema del colaborador (sus inquietudes personales, proyectos, desafíos que enfrenta).</li>
                <li><em>Siguientes 10 minutos:</em> Tema del líder (alineación de prioridades, coaching y retroalimentación).</li>
                <li><em>Últimos 10 minutos:</em> Futuro y crecimiento profesional (planes de carrera, capacitaciones y compromisos mutuos de cara a la próxima reunión).</li>
            </ul>
        </li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-graph-up-arrow text-primary me-2"></i>2. El Modelo de Coaching GROW (Sir John Whitmore)</h4>
    <p>En lugar de darle la respuesta hecha al colaborador, el líder-coach hace preguntas poderosas para que el colaborador descubra la solución por sí mismo:</p>
    <ol>
        <li><strong>G - Goal (Meta):</strong> <em>''¿Qué resultado específico deseas alcanzar con este proyecto en las próximas 3 semanas?''</em></li>
        <li><strong>R - Reality (Realidad Actual):</strong> <em>''¿Cuál es la situación hoy? ¿Qué pasos has intentado y qué obstáculos has encontrado?''</em></li>
        <li><strong>O - Options (Opciones Viables):</strong> <em>''Si tuvieras recursos ilimitados, ¿qué harías? ¿Qué otras alternativas no hemos considerado todavía?''</em></li>
        <li><strong>W - Will / Way Forward (Compromiso de Acción):</strong> <em>''De todas estas opciones, ¿cuál ejecutarás primero? ¿Cuándo lo harás y cómo puedo apoyarte?''</em></li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Monopolizar la reunión 1 a 1 hablando solo el jefe:</strong> Si el líder habla más del 30% del tiempo durante la sesión, la reunión ha fracasado en su propósito de escucha activa.</li>
        <li><strong>No tomar notas de los compromisos asumidos:</strong> Llegar a la siguiente 1:1 sin acordarse de lo que se habló dos semanas atrás destruye la confianza y la continuidad.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Mantienes un espacio fijo e inamovible de reunión 1:1 con tus colaboradores directos?</li>
            <li>¿Utilizas preguntas reflexivas del modelo GROW antes de imponer tu criterio propio?</li>
            <li>¿Dedicas al menos un tercio de la conversación al plan de desarrollo y crecimiento personal?</li>
        </ul>
    </div>
</div>', 'Domina las reuniones individuales periódicas de 30 minutos que retienen al talento clave y utiliza el modelo GROW para desbloquear el potencial de tus colaboradores.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (247, 247, 'Organigramas, Jerarquías y Funciones de Cada Área de la Empresa', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-3-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">La Empresa como un Sistema Vivo: Nada Funciona Aislado</h5>
            <p class="mb-0 small">El error más recurrente de los colaboradores recién contratados es pensar que su puesto es una isla. Comprender cómo las decisiones de compras afectan a almacén, y cómo ventas impacta en finanzas, es la clave para ascender a puestos de supervisión.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/NpsflJIWNIg" title="La estructura organizacional - Growp" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es la Estructura Organizacional y el Organigrama?</h4>
    <p>La <strong>Estructura Organizacional</strong> es el marco formal que define cómo se dividen, agrupan y coordinan las tareas laborales en una organización. Se plasma visualmente en un <strong>Organigrama</strong>, el cual refleja:</p>
    <ul>
        <li><strong>Líneas de Autoridad y Dependencia Jerárquica:</strong> Quién rinde cuentas a quién (evitando que un empleado reciba órdenes contradictorias de dos jefes distintos, respetando el principio de <em>Unidad de Mando</em> de Henri Fayol).</li>
        <li><strong>Tramos de Control (Span of Control):</strong> La cantidad de colaboradores directos que supervisa cada gerente o jefe de área.</li>
        <li><strong>Departamentalización:</strong> División por funciones (Finanzas, Ventas, Operaciones, RRHH), por productos o por áreas geográficas.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-building text-primary me-2"></i>2. Las 5 Áreas Funcionales Clave de una Empresa</h4>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Departamento</th>
                    <th>Misión Central</th>
                    <th>Interacción Vital con Otras Áreas</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">Administración y Finanzas</td>
                    <td>Custodiar la liquidez, pagar impuestos, gestionar la contabilidad y planificar presupuestos.</td>
                    <td>Autoriza los pagos a proveedores gestionados por Compras y cobra las facturas emitidas por Ventas.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">Comercial y Ventas</td>
                    <td>Generar ingresos, captar clientes, cerrar acuerdos y atender canales de distribución.</td>
                    <td>Depende de Almacén para prometer plazos de entrega realistas a los clientes.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Operaciones y Logística</td>
                    <td>Fabricar los productos o almacenar, embalar y despachar la mercancía vendida.</td>
                    <td>Informa a Compras cuándo los stocks mínimos están en peligro de agotarse.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Compras y Abastecimiento</td>
                    <td>Negociar con proveedores las mejores condiciones de precio, calidad y plazo de entrega.</td>
                    <td>Suministra insumos a Operaciones respetando los presupuestos de Finanzas.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-secondary">Talento Humano (RRHH)</td>
                    <td>Reclutar, seleccionar, capacitar y cuidar el clima laboral y el cumplimiento legal del personal.</td>
                    <td>Apoya a todos los departamentos en la resolución de conflictos y pago puntual de nómina.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-arrow-left-right text-primary me-2"></i>3. La Erradicación de los Silos de Información</h4>
    <p>Cuando un departamento se niega a compartir información con los demás o culpa a otra área ante los errores, se producen <strong>silos organizacionales</strong>:</p>
    <ul>
        <li>Si Ventas lanza una promoción masiva con 30% de descuento sin avisar a Almacén, la tienda se quedará sin mercancía en dos horas, enfadando a los clientes.</li>
        <li>La gestión moderna utiliza reuniones interdepartamentales semanales de alineación y plataformas compartidas (ERP) donde todos los líderes ven el mismo tablero de datos en tiempo real.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Falta de Manual de Organización y Funciones (MOF):</strong> Si no existen descripciones escritas y firmadas de las responsabilidades de cada puesto, ante un error grave nadie asume la culpa (''a mí no me dijeron que me tocaba hacer eso'').</li>
        <li><strong>Saltarse los canales regulares de jerarquía:</strong> Acudir directamente al Presidente de la compañía para quejarse de un tema operativo diario sin hablar primero con tu supervisor inmediato socava la autoridad de los mandos medios y genera fricciones internas.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Conoces el organigrama oficial y tienes claro quién es tu supervisor directo?</li>
            <li>¿Cuentas con una descripción formal escrita de tus funciones y metas del puesto?</li>
            <li>¿Comunicas oportunamente los cambios de tu área a los departamentos interconectados?</li>
        </ul>
    </div>
</div>', 'Comprende la arquitectura empresarial: tipos de organigramas (lineal, funcional, matricial), roles de dirección vs mandos medios y el flujo de comunicación interdepartamental sin silos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (107, 107, 'Guiones de Venta, Manejo de ''¿Cuánto Cuesta?'' y Técnicas de Urgencia Ética', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-chat-heart-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Comercio Conversacional: La Venta Ocurre en el Diálogo, no en el Monólogo</h5>
            <p class="mb-0 small">Enviar un PDF gigante de 20 páginas sin saludar o responder con un precio seco sin contexto espanta a los compradores. El comercio conversacional guía al cliente a través de preguntas inteligentes hasta el momento natural del pago.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/v_QIJirOrmA" title="Más allá de un chatbot - Comercio Conversacional" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Cómo Responder al Clásico: ''¿Precio?''</h4>
    <p>El error más común de los vendedores digitales es soltar el precio sin más: <em>''$45''</em>. El cliente lee el número, no percibe el valor, y desaparece dejando la conversación en visto. El método profesional de respuesta en 3 pasos es:</p>
    <ol>
        <li><strong>Saludar por su nombre y validar la elección:</strong> <em>''¡Hola Juan! Excelente opción, ese modelo es uno de nuestros favoritos por su alta durabilidad...''</em></li>
        <li><strong>Aportar valor inmediato y entregar el precio claro:</strong> <em>''Incluye el kit de accesorios completo y garantía de 6 meses por un valor de $45 USD (o su equivalente en bolívares a tasa oficial).''</em></li>
        <li><strong>Cerrar SIEMPRE con una pregunta abierta de control:</strong> <em>''¿Lo necesitas para envío a domicilio en tu ciudad o prefieres retirarlo personalmente en nuestra tienda hoy mismo?''</em></li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-mic-fill text-danger me-2"></i>2. El Uso Estratégico de las Notas de Voz</h4>
    <p>El texto escrito puede sonar frío o impersonal. Una nota de voz transmite calidez, seguridad y profesionalismo, pero debe usarse bajo reglas estrictas:</p>
    <ul>
        <li><strong>Duración Máxima de 30 a 45 segundos:</strong> Nadie en internet tiene tiempo para escuchar un podcast de 3 minutos de un vendedor desconocido.</li>
        <li><strong>Nunca enviar un audio como primer mensaje:</strong> El primer contacto siempre debe ser en texto. Solo envía un audio cuando ya exista un intercambio previo o para explicar un detalle técnico complejo.</li>
        <li><strong>Modular la voz:</strong> Tono entusiasta, claro y seguro, sin ruidos molestos de fondo de televisión o tránsito vehicular.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-check2-all text-success me-2"></i>3. La Técnica del Cierre de Doble Alternativa</h4>
    <p>Nunca le preguntes a un cliente: <em>''¿Va a comprar?''</em> (le estás dando la oportunidad fácil de decir ''No''). En su lugar, utiliza el <strong>Cierre de Doble Alternativa</strong>, donde ambas opciones llevan al cierre de la venta:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small">
        - <em>''¿Prefieres que te lo despachemos en color Negro o en color Azul marino?''</em><br />
        - <em>''¿Deseas cancelar mediante Pago Móvil o prefieres transferencia bancaria en divisas?''</em><br />
        - <em>''¿Te queda mejor recibir el paquete en la mañana o en la tarde?''</em>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Enviar el temido ''¿Sigue interesado?'':</strong> Escribir a los dos días ''¿Hola, sigue interesado?'' es una frase pasivo-agresiva que genera rechazo. En su lugar, reactiva el chat aportando valor nuevo: <em>''¡Hola María! Justo me acordé de tu consulta y nos acaban de llegar dos unidades adicionales con flete bonificado, ¿deseas que te reserve una?''</em>.</li>
        <li><strong>Respuestas frías con mala ortografía y abreviaturas callejeras:</strong> Escribir ''q'', ''xq'' o ignorar mayúsculas resta seriedad a la empresa. Escribe siempre con ortografía y puntuación impecable.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Terminas cada mensaje de cotización con una pregunta orientada a la acción?</li>
            <li>¿Mantienes tus audios explicativos en menos de 45 segundos con excelente modulación?</li>
            <li>¿Utilizas cierres de doble alternativa para facilitar la toma de decisión del cliente?</li>
        </ul>
    </div>
</div>', 'Domina el arte de vender por chat: responde al temido ''precio por favor'' sin ahuyentar al cliente, utiliza notas de voz estratégicas de menos de 45 segundos y aplica cierres de alternativa doble.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (151, 151, 'Modales y Preguntas de Confirmación: Habilidad, Obligación, Consejos y Cortesía', 'Reading', '<h4>1. Reglas Universales de los Verbos Modales</h4>
<p>Los verbos modales poseen 3 características que simplifican su uso en inglés:</p>
<ol>
    <li><strong>Inmutables:</strong> No añaden <code>-s</code> en 3ª persona (*He can*, nunca *He cans*).</li>
    <li><strong>Seguidos de Infinitivo sin ''to'':</strong> *I must go*, *She can swim* (no *can to swim*).</li>
    <li><strong>Negación e Interrogación Directa:</strong> No necesitan *do/does*; niegan directamente (*cannot / can''t, should not / shouldn''t*) e invierten el orden en preguntas (*Can you speak Spanish?*).</li>
</ol>

<div class="table-responsive my-3">
    <table class="table table-bordered align-middle">
        <thead class="table-dark">
            <tr><th>Modal</th><th>Significado / Función</th><th>Ejemplo en Contexto</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class="text-primary">CAN / CAN''T</strong></td>
                <td>Habilidad física o mental; permiso informal.</td>
                <td><em>I can drive a car. / You can''t park here.</em></td>
            </tr>
            <tr>
                <td><strong class="text-danger">MUST / MUSTN''T</strong></td>
                <td>Obligación fuerte o deber legal; prohibición estricta.</td>
                <td><em>You must wear a seatbelt. / You mustn''t enter this area.</em></td>
            </tr>
            <tr>
                <td><strong class="text-warning">SHOULD / SHOULDN''T</strong></td>
                <td>Consejo, recomendación u opinión moral.</td>
                <td><em>You have a headache; you should rest.</em></td>
            </tr>
            <tr>
                <td><strong class="text-info">MAY / MIGHT</strong></td>
                <td>Posibilidad o permiso formal respetuoso.</td>
                <td><em>May I ask a question? / It might rain later.</em></td>
            </tr>
            <tr>
                <td><strong class="text-success">WOULD</strong></td>
                <td>Cortesía refinada y ofrecimientos.</td>
                <td><em>Would you like some coffee? &mdash; Yes, I would.</em></td>
            </tr>
        </tbody>
    </table>
</div>

<h4>2. Introducción a las "Question Tags" (Coletillas Interrogativas)</h4>
<p>Son pequeñas preguntas al final de la oración para confirmar información (equivalentes a <em>''¿verdad?''</em> o <em>''¿no?''</em>):</p>
<ul>
    <li>Frase afirmativa &rarr; Tag negativa: <em>You are a student, <strong>aren''t you?</strong></em></li>
    <li>Frase negativa &rarr; Tag afirmativa: <em>He isn''t Spanish, <strong>is he?</strong></em></li>
    <li>Con Present Simple: <em>You work in an office, <strong>don''t you?</strong></em></li>
</ul>', 'Conoce las reglas de los verbos modales auxiliares (Can, Must, Should, May, Would), cómo formular peticiones formales y el uso de Question Tags.', 25, 1, true);
INSERT INTO public."Lessons" VALUES (227, 227, 'Navegación en el Sistema, Socios de Negocios y Artículos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-database-fill-check fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">SAP Business One: El ERP Líder en las Empresas Medianas y Grandes</h5>
            <p class="mb-0 small">Aprender SAP B1 te abre las puertas a los mejores puestos administrativos y contables del mercado laboral. En SAP, la precisión de los datos maestros es la base que garantiza que las ventas, compras e inventarios fluyan sin descuadres.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/xSrstKkVhE0" title="Curso rápido de Navegación para SAP Business One" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Interfaz y Filosofía Operativa de SAP B1</h4>
    <p>A diferencia de programas contables básicos aislados, <strong>SAP Business One</strong> es un sistema ERP totalmente integrado. Cuando un usuario realiza una acción en un documento de ventas o compras, el sistema actualiza automáticamente el inventario en los almacenes correspondientes y genera el asiento contable en el libro mayor en tiempo real.</p>
    <p>Para navegar con agilidad en el sistema, todo operador debe dominar tres elementos clave:</p>
    <ul>
        <li><strong>La Flecha Amarilla de Enlace (Golden Arrow):</strong> Al lado de cualquier código de cliente, proveedor, artículo o número de documento contable, aparece una pequeña flecha naranja/amarilla. Al hacer clic sobre ella, SAP abre instantáneamente la ficha maestra o el documento original sin necesidad de salir al menú principal.</li>
        <li><strong>Modo Buscar vs Modo Crear:</strong> En SAP, las ventanas tienen dos modos. Al presionar <code>Ctrl + F</code> (o hacer clic en los prismáticos), la ventana se pone en modo <em>Buscar</em> (campos en amarillo suave) para filtrar registros existentes. Al presionar <code>Ctrl + A</code>, la ventana pasa a modo <em>Crear / Añadir</em> (campos en blanco) para ingresar una transacción nueva.</li>
        <li><strong>El Mapa de Relaciones:</strong> Al hacer clic derecho sobre cualquier documento comercial y seleccionar <em>''Mapa de relaciones''</em>, SAP despliega un diagrama interactivo con todo el árbol documental conectado (Cotización ➔ Orden ➔ Entrega ➔ Factura ➔ Pago recibido).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-person-vcard-fill text-primary me-2"></i>2. Datos Maestros de Socios de Negocios (Business Partners - BP)</h4>
    <p>En SAP B1 no existen tablas separadas de ''clientes'' y ''proveedores''; todos se gestionan bajo el concepto unificado de <strong>Socio de Negocios</strong> (módulo <em>Socios de Negocios ➔ Datos Maestros de Socio de Negocios</em>). Existen tres tipos:</p>
    <ol>
        <li><strong>Cliente:</strong> Empresas o personas a las que les vendemos productos o servicios.</li>
        <li><strong>Proveedor:</strong> Quienes nos suministran materias primas, mercancía para reventa o servicios operativos.</li>
        <li><strong>Lead (Prospecto):</strong> Potenciales clientes en etapa de cotización previa antes de formalizar ventas reales.</li>
    </ol>
    <p class="small text-muted">Campos críticos obligatorios: Código de SN (ej: <code>CLI-J-3049281</code>), RIF o Cédula fiscal, Grupo de Clientes, Moneda de transacción (Moneda local o multidivisa en USD), Lista de Precios asignada y Condiciones de Pago (ej: Contado o Crédito 30 días con límite crediticio).</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-box-seam-fill text-success me-2"></i>3. Datos Maestros de Artículos y las Tres Casillas Sagradas</h4>
    <p>Al dar de alta un producto o servicio en el módulo de Inventario, existen tres casillas de verificación en la esquina superior derecha que determinan su comportamiento en todo el sistema:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Casilla</th>
                    <th>¿Qué habilita en SAP B1?</th>
                    <th>Ejemplo de Aplicación Real</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-primary">Artículo de Inventario</td>
                    <td>Controla stock físico en almacenes, valorización de inventario y genera movimientos en recuentos.</td>
                    <td>Productos físicos tangibles para venta o materia prima en almacén.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">Artículo de Venta</td>
                    <td>Permite que el SKU pueda seleccionarse en cotizaciones, órdenes de venta y facturas a clientes.</td>
                    <td>Todo producto que la empresa comercializa.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Artículo de Compra</td>
                    <td>Permite que el SKU pueda incluirse en órdenes de compra y facturas de proveedores.</td>
                    <td>Mercancía de reposición o suministros de oficina.</td>
                </tr>
            </tbody>
        </table>
    </div>
    <p class="small text-muted"><em>Caso especial:</em> Un servicio intangible (como un flete de transporte o una hora de consultoría) se marca como ''Artículo de Venta'' y ''Artículo de Compra'', pero <strong>NO</strong> como ''Artículo de Inventario'', porque los servicios no se almacenan en bodegas físicas.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear artículos duplicados con descripciones ligeramente diferentes:</strong> Genera descuadres contables y saldos falsos en almacén. Antes de crear un artículo, siempre busca por el código de barras o código de parte del fabricante en modo Buscar (Ctrl + F).</li>
        <li><strong>Asignar una lista de precios incorrecta al Socio de Negocios:</strong> Provoca que el sistema cargue precios de mayorista a clientes minoristas o viceversa durante la facturación rápida en mostrador.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Verificaste el RIF o identificación fiscal antes de crear un nuevo Socio de Negocios?</li>
            <li>¿Marcaste correctamente las tres casillas maestras según la naturaleza del artículo?</li>
            <li>¿Comprobaste la Lista de Precios y las Condiciones de Pago asignadas al cliente?</li>
        </ul>
    </div>
</div>', 'Conoce la arquitectura cliente-servidor de SAP B1, el menú de módulos, la barra de herramientas, la creación de Socios de Negocios (Clientes y Proveedores) y la configuración de Artículos con sus tres casillas maestras.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (127, 127, 'La Curva del Cambio de Kübler-Ross y Comunicación Transparente en Incertidumbre', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-shield-slash-fill fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">En la Calma Cualquiera Puede Ser Capitán; en la Tempestad se Mide al Líder</h5>
            <p class="mb-0 small">En momentos de crisis o fusiones corporativas, el vacío de información es llenado de inmediato por el pánico, el rumor y la parálisis. Aprende a liderar con templanza, transparencia y claridad estratégica.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/3KBFyFD-TfI" title="Liderazgo Ágil en Tiempos de Crisis y Cambio" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-activity text-primary me-2"></i>1. La Curva Emocional del Cambio en las Organizaciones</h4>
    <p>Adaptada del modelo de la Dra. Elisabeth Kübler-Ross, todo cambio estructural o crisis despierta fases emocionales predecibles en los colaboradores:</p>
    <ul>
        <li><strong>Fase 1: Negación y Shock:</strong> <em>''Esto es solo una moda pasajera, no van a cambiar el sistema realmente''</em>. El líder debe comunicar la realidad objetiva con empatía pero con firmeza incontrovertible.</li>
        <li><strong>Fase 2: Resistencia y Enojo:</strong> <em>''¡Esto es injusto, el método anterior funcionaba mucho mejor!''</em>. El líder no debe combatir la frustración con autoritarismo; debe escuchar las preocupaciones legítimas y validar las emociones del equipo.</li>
        <li><strong>Fase 3: Exploración y Ensayo:</strong> El equipo comienza a probar las nuevas herramientas y a ver los primeros beneficios prácticos. Es el momento clave para brindar capacitaciones intensivas y reconocer los pequeños avances.</li>
        <li><strong>Fase 4: Compromiso e Integración:</strong> El nuevo proceso se convierte en la forma habitual y natural de trabajar, consolidando una cultura más resiliente.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-megaphone-fill text-primary me-2"></i>2. Protocolos de Comunicación en Tiempos de Crisis</h4>
    <p>Para frenar la desinformación interna durante situaciones de incertidumbre severa:</p>
    <ol>
        <li><strong>Sobrecumunicar con Frecuencia Fija:</strong> Si los líderes no informan a diario, los rumores de pasillo multiplicarán la ansiedad. Es mejor dar actualizaciones breves de 10 minutos cada mañana aunque no haya novedades definitivas que guardar silencio absoluto durante semanas.</li>
        <li><strong>Honestidad Radical (La Paradoja de Stockdale):</strong> Mantener la fe inquebrantable en que saldrán adelante como equipo, pero confrontando al mismo tiempo con crudeza los hechos más brutales de la realidad presente. Nunca prometer cosas que no se pueden garantizar.</li>
        <li><strong>Enfoque en lo Controlable:</strong> Ante una crisis macroeconómica o devaluación imprevista, reorientar el foco del equipo hacia lo que sí está en sus manos: <em>''No podemos controlar la inflación del país, pero sí podemos controlar la velocidad de atención al cliente y cuidar cada inventario para evitar mermas''</em>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Encerrarse en la oficina gerencial a puerta cerrada:</strong> Desaparecer de la vista del personal durante una crisis genera la impresión de abandono o quiebra inminente.</li>
        <li><strong>Transmitir pánico y desesperación descontrolada:</strong> Si el líder entra gritando o mostrándose desbordado por el estrés, desmoraliza por completo a sus seguidores.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Mantienes presencia física o virtual visible y cercana durante momentos de turbulencia?</li>
            <li>¿Comunicas con regularidad y transparencia para erradicar rumores malintencionados?</li>
            <li>¿Enfocas la energía de tus colaboradores en las variables que sí pueden controlar?</li>
        </ul>
    </div>
</div>', 'Aprende a guiar a tu equipo en momentos de reestructuración, crisis económicas y cambios tecnológicos imprevistos, gestionando el miedo y la resistencia al cambio.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (240, 240, 'Diseño Modular, Participación en Anaquel (Share of Shelf) y Facings', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-grid-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">El Planograma: El Plano Arquitectónico de las Ventas en Retail</h5>
            <p class="mb-0 small">En las grandes cadenas de supermercados, el orden de los productos no se decide al gusto del reponedor. Cada centímetro de estantería está matemáticamente diseñado en un diagrama técnico llamado planograma para maximizar la rentabilidad por metro cuadrado.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/5dBEjzExOu0" title="Visual Merchandising - TUTORIAL COMO EXPORTAR UN PLANOGRAMA" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es un Planograma y Cómo se Interpreta?</h4>
    <p>Un <strong>Planograma (POG)</strong> es una representación gráfica bidimensional detallada que especifica la ubicación exacta, el número de estantes, la altura de cada bandeja y la cantidad de caras visibles que debe tener cada SKU en la góndola.</p>
    <p>Para ejecutarlo en piso, el mercaderista debe interpretar su simbología técnica:</p>
    <ul>
        <li><strong>Módulo / Tramo:</strong> Sección vertical estándar de góndola (generalmente de 0.90 m o 1.20 m de ancho). Un planograma puede abarcar 3 o 4 tramos continuos.</li>
        <li><strong>Bandeja / Nivel:</strong> Cada una de las baldas horizontales numeradas de arriba hacia abajo (Nivel 1 es el superior, Nivel 5 es la base).</li>
        <li><strong>Facing (Frente Visual):</strong> La cantidad de unidades de un mismo producto que se colocan en primera fila mirando directamente al consumidor. Si un champú tiene 3 facings, significa que se ven 3 botellas una al lado de la otra de frente, con sus respectivos bultos apilados detrás en profundidad.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-pie-chart-fill text-primary me-2"></i>2. El Principio del Share of Shelf (Participación en Anaquel)</h4>
    <p>La regla de oro del Trade Marketing establece que <strong>la participación de una marca en el anaquel debe ser proporcional a su participación de mercado real (Share of Market)</strong>:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center">
        <code>Si tu marca tiene el 30% de las ventas de la categoría ➔ Debe ocupar al menos el 30% del espacio físico en centímetros de la góndola.</code>
    </div>
    <p class="small text-muted">Si tu marca vende el 40% del mercado pero solo tiene el 15% del anaquel, se producirán constantes <em>Quiebres de Stock (Out of Stock)</em>, obligando al consumidor a comprar la marca competidora por falta de producto visible.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-columns text-success me-2"></i>3. Estrategias de Bloque: Bloqueo Horizontal vs Bloqueo Vertical</h4>
    <p>Al acomodar los productos según el planograma, se aplican dos técnicas de agrupación:</p>
    <ul>
        <li><strong>Bloqueo Vertical (Recomendado):</strong> Agrupar toda la familia de la marca verticalmente atravesando todos los niveles (desde los ojos hasta el suelo). Esto permite que el comprador, al caminar por el pasillo, vea la marca completa de un solo vistazo sin tener que desplazarse horizontalmente.</li>
        <li><strong>Bloqueo Horizontal:</strong> Colocar toda la línea en una sola bandeja larga. Es menos visible y suele provocar que los productos ubicados en los extremos pasen desapercibidos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>''Tapar huecos'' con productos equivocados cuando hay quiebre de stock:</strong> Si se agotó el jugo de naranja, rellenar ese espacio con jugo de manzana altera el planograma y confunde el sistema de reposición automática de la tienda, haciendo que el sistema crea que hay stock de naranja cuando en realidad está quebrado.</li>
        <li><strong>Colocar productos con las etiquetas hacia atrás o ladeadas:</strong> Todos los productos deben colocarse estrictamente con el logotipo frontal visible, alineados milimétricamente al borde frontal de la bandeja (técnica de <em>Fronting o Frenteo</em>).</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Respetaste la cantidad exacta de facings asignados en el planograma técnico oficial?</li>
            <li>¿Realizaste el ''frenteo'' alineando todos los productos al borde de la balda con el logo de frente?</li>
            <li>¿Comprobaste que los productos no estén ocultos detrás de postes estructurales de la tienda?</li>
        </ul>
    </div>
</div>', 'Domina la lectura técnica de planogramas: cálculo de frentes visuales (facings), participación de espacio según cuota de mercado (Share of Shelf) y respeto a la distribución por bloques de marca.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (239, 239, 'La Batalla por el Anaquel: De la Zona Caliente a la Zona Fría', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-display fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Lo que no se ve, no se vende: La Ciencia del Anaquel</h5>
            <p class="mb-0 small">El 70% de las decisiones de compra de bienes de consumo masivo se toman en el pasillo del supermercado en menos de 5 segundos. La posición que ocupa tu producto en la estantería determina si el cliente lo echa al carrito o si lo ignora por completo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/FfDLSM_bHiw" title="Trade Marketing - Qué es y Claves para Triunfar" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Qué es el Trade Marketing y Qué Rol Cumple el Mercaderista?</h4>
    <p>Mientras que el marketing tradicional busca seducir al consumidor a través de anuncios de televisión o redes sociales, el <strong>Trade Marketing</strong> se enfoca en seducir al <em>comprador (Shopper)</em> en el punto de venta físico y en lograr la colaboración estratégica con el canal distribuidor (supermercados, cadenas de farmacias, mayoristas).</p>
    <p>El <strong>Mercaderista</strong> es el embajador de la marca en el terreno. Su misión no es solo reponer cajas vacías; es asegurar que los productos de la empresa tengan la mayor visibilidad, estén limpios, exhiban el precio correcto y ocupen el espacio pactado en los contratos comerciales.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-bar-chart-steps text-primary me-2"></i>2. Los Cuatro Niveles Verticales de la Góndola</h4>
    <p>La altura en la que se coloca un producto en la estantería tiene un impacto directo comprobado en su velocidad de rotación:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Nivel de Góndola</th>
                    <th>Altura Promedio</th>
                    <th>Eficacia Comercial</th>
                    <th>Tipo de Producto Ideal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-danger">Nivel de los Ojos (Eye Level)</td>
                    <td>1.40 m - 1.70 m</td>
                    <td><strong>Zona Caliente Máxima:</strong> Concentra más del 50% de las ventas espontáneas.</td>
                    <td>Productos estrella de alta rentabilidad, marcas premium y lanzamientos de temporada.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-success">Nivel de las Manos (Touch Level)</td>
                    <td>0.80 m - 1.40 m</td>
                    <td><strong>Zona Caliente Secundaria:</strong> Muy alta accesibilidad y compra por impulso sin esfuerzo físico.</td>
                    <td>Productos de alta rotación y consumo frecuente que complementan la compra.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Nivel de la Cintura</td>
                    <td>0.50 m - 0.80 m</td>
                    <td><strong>Zona Neutra:</strong> Requiere inclinarse levemente para tomar el producto.</td>
                    <td>Marcas secundarias o empaques medianos.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-secondary">Nivel del Suelo (Floor Level)</td>
                    <td>0.00 m - 0.50 m</td>
                    <td><strong>Zona Fría:</strong> Requiere agacharse por completo; baja visibilidad.</td>
                    <td>Productos de primera necesidad y gran volumen (sacos de arroz de 10 kg, botellones de detergente o productos pesados que el cliente busca obligatoriamente).</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-star-fill text-warning me-2"></i>3. Puntos de Exhibición Adicionales (Puntos Calientes de la Tienda)</h4>
    <p>Además de la góndola regular de pasillo, los mercaderistas profesionales negocian espacios privilegiados:</p>
    <ul>
        <li><strong>Cabeceras de Góndola (Endcaps):</strong> Los extremos frontales de los pasillos principales por donde circula el 100% de los clientes. Multiplican las ventas hasta en un 300% durante promociones.</li>
        <li><strong>Islas y Racks Promocionales:</strong> Muebles independientes colocados en los pasillos centrales anchos para capturar la atención en eventos de temporada (Navidad, Regreso a Clases).</li>
        <li><strong>Check-out / Zona de Cajas (Línea de Espera):</strong> La meca de la compra por impulso (chicles, baterías, chocolates, bebidas frías), donde los clientes esperan en fila con dinero en mano listos para gastar el sencillo.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar productos sin fleje de precio:</strong> Un producto en el estante sin etiqueta de precio es un producto que no se vende; el 60% de los compradores no se arriesga a llevar un artículo si desconoce cuánto cuesta por temor a pasar vergüenza en caja.</li>
        <li><strong>Permitir que la competencia ''canibalice'' el espacio pactado:</strong> Si la empresa pagó por 4 frentes (facings) de exhibición y el mercaderista de la marca rival corre tus productos para meter los suyos, estás perdiendo ventas que tu empresa financió.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Ubicaste los productos de mayor margen en el nivel de los ojos y de las manos?</li>
            <li>¿Verificaste que cada producto tenga su fleje de precio visible y actualizado?</li>
            <li>¿Defendiste los frentes de anaquel pactados en el contrato comercial con la tienda?</li>
        </ul>
    </div>
</div>', 'Comprende el comportamiento del comprador (Shopper) frente a la góndola: los 4 niveles de exhibición (ojos, manos, cintura, suelo), cabeceras de góndola e islas promocionales.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (241, 241, 'Gestión de Caducidades: Primero que Vence, Primero que Sale', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-hourglass-bottom fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Vencimientos Cero: La Regla de Oro en Alimentos y Medicinas</h5>
            <p class="mb-0 small">Dejar un producto vencido en la góndola no es solo una pérdida económica por merma; es un delito contra la salud pública que acarrea multas sanitarias devastadoras, cierres de tiendas y demandas para la empresa.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/nneseq7x5CY" title="Método FIFO (Primera Entrada, Primera Salida). Valoración de inventarios" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Diferencia Fundamental entre FIFO y FEFO</h4>
    <p>En el control de inventarios de consumo masivo, existen dos metodologías de rotación:</p>
    <ul>
        <li><strong>FIFO / PEPS (First In, First Out - Primero en Entrar, Primero en Salir):</strong> Basado en la fecha de llegada al almacén. El lote que entró primero al depósito es el que primero se despacha. Es útil para artículos que no se vencen (como ferretería, repuestos o cuadernos).</li>
        <li><strong>FEFO / PVPS (First Expired, First Out - Primero en Vencer, Primero en Salir):</strong> Basado en la <strong>Fecha de Caducidad Real impresa en el empaque</strong>. Aunque un lote haya llegado ayer, si vence antes que el lote recibido la semana pasada, ese producto DEBE colocarse en primera fila para venderse primero. Es la regla obligatoria en alimentos, lácteos, carnes, bebidas, medicamentos y cosméticos.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shuffle text-primary me-2"></i>2. El Procedimiento Físico de Rotación en la Góndola</h4>
    <p>El error de los mercaderistas perezosos es colocar la mercancía nueva que viene de la bodega directamente encima o delante de los productos que ya estaban en el estante. Esto condena a los productos del fondo a envejecer y pudrirse en la sombra.</p>
    <p>El procedimiento profesional inquebrantable consta de 4 pasos:</p>
    <ol>
        <li><strong>Bajar o correr hacia adelante:</strong> Retirar temporalmente los productos que ya están en la góndola.</li>
        <li><strong>Limpiar la bandeja:</strong> Pasar un paño con desinfectante para retirar polvo o manchas.</li>
        <li><strong>Ingresar la mercancía nueva al fondo:</strong> Colocar los productos con fecha de vencimiento más lejana en la parte trasera de la estantería.</li>
        <li><strong>Colocar la mercancía anterior al frente:</strong> Ubicar los productos con fecha más próxima al vencimiento en primera fila, listos para que el cliente los tome primero.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-stoplights-fill text-warning me-2"></i>3. Matriz de Semaforización de Caducidades</h4>
    <p>Para no ser sorprendidos por productos vencidos, los mercaderistas auditan sus góndolas clasificando los artículos con una plantilla semáforo:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Estado Semáforo</th>
                    <th>Tiempo Restante de Vida Útil</th>
                    <th>Acción Operativa Obligatoria</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold text-success">Verde (Normal)</td>
                    <td>Más de 90 días de vigencia.</td>
                    <td>Rotación estándar FEFO sin alertas.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-warning text-dark">Amarillo (Alerta Preventiva)</td>
                    <td>Entre 30 y 60 días para vencer.</td>
                    <td>Priorizar facings delanteros y evaluar con el supervisor la colocación de un sticker promocional o descuento comercial.</td>
                </tr>
                <tr>
                    <td class="fw-bold text-danger">Rojo (Crítico / Retiro)</td>
                    <td>Menos de 15 días (o según política de la cadena).</td>
                    <td><strong>Retiro inmediato de la góndola:</strong> Trasladar a bodega para devolución a proveedor o destrucción formal con acta de merma antes de la fecha límite.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Fecha de Elaboración con Fecha de Caducidad:</strong> Muchos productos importados muestran dos fechas en formato anglosajón (<code>MM/DD/AAAA</code> en lugar de <code>DD/MM/AAAA</code>). Interpretar mal el mes puede llevar a desechar productos buenos o exhibir productos vencidos.</li>
        <li><strong>No revisar productos con empaque abollado o hinchado:</strong> Latas con golpes en las costuras o envases tetra-brik hinchados pueden contener bacterias peligrosas (como Clostridium botulinum). Deben retirarse de la venta inmediatamente aunque su fecha de caducidad esté vigente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aplicaste la rotación FEFO poniendo siempre los productos próximos a vencer en primera fila?</li>
            <li>¿Revisaste el formato de fecha (día/mes/año) de cada lote que ingresó de la bodega?</li>
            <li>¿Retiraste de inmediato cualquier producto con empaque deteriorado o abollado?</li>
        </ul>
    </div>
</div>', 'Elimina pérdidas por vencimiento en alimentos, farmacia y cosméticos. Domina la metodología FEFO (First Expired, First Out), el protocolo de semaforización de caducidades y el retiro oportuno de mermas.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (16, 16, 'Los 4 Principios de la Negociación por Principios de Harvard', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-handshake-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Negociar No es Vencer; es Construir un Acuerdo Sostenible y Rentable</h5>
            <p class="mb-0 small">En una negociación destructiva de regateo, una parte gana a costa de aplastar a la otra, generando resentimiento y acuerdos incumplidos. Conoce el método científico de Harvard para agrandar el pastel antes de repartirlo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/3IzqALUN0Do" title="Curso 011 - Los 4 principios de la técnica Harvard de Negociación" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-award text-primary me-2"></i>1. Los 4 Pilares del Proyecto de Negociación de Harvard</h4>
    <p>Desarrollados en la Escuela de Leyes de Harvard por Roger Fisher y William Ury, revolucionaron la diplomacia internacional y los negocios corporativos:</p>
    <ul>
        <li><strong>1. Separar a las Personas del Problema:</strong> Ser suave con las personas pero extraordinariamente firme con el problema técnico o financiero. No atacar el honor ni el orgullo de la contraparte; construir una relación de confianza mutua mientras se resuelven las discrepancias objetivas de fondo.</li>
        <li><strong>2. Concentrarse en Intereses, No en Posiciones:</strong> La posición es lo que la persona dice explícitamente que quiere (<em>''No pagaré más de $500 por este servicio''</em>); el interés es la motivación oculta, el miedo o la necesidad real detrás de esa exigencia (<em>''Tengo un presupuesto trimestral cerrado y temo que el proyecto se atrase''</em>). Resolver el interés desbloquea la negociación.</li>
        <li><strong>3. Inventar Opciones de Mutuo Beneficio (Agrandar el Pastel):</strong> Antes de decidir, generar una lluvia de ideas creativa con múltiples variables (plazos de entrega, garantías extendidas, volúmenes futuros, formas de pago) donde ambas partes ganen.</li>
        <li><strong>4. Insistir en Criterios Objetivos e Independientes:</strong> No basar el acuerdo en el capricho o la terquedad de una de las partes, sino en estándares imparciales del mercado (precios de referencia de la industria, tasas de inflación del BCV, costos de reposición o dictámenes periciales).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-pie-chart text-primary me-2"></i>2. La Parábola Clásica de la Naranja</h4>
    <p>Dos hermanas discuten agriamente por la única naranja que queda en la cocina. Ambas exigen la naranja entera (posiciones rígidas). Si un negociador inexperto interviene, cortará la naranja por la mitad (solución de regateo donde ambas pierden el 50%). Al preguntar a cada una para qué la necesita (intereses reales):</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small">Una hermana quería el jugo para beberlo; la otra hermana quería únicamente la cáscara para hornear un pastel de naranja. Al entender los intereses subyacentes, una hermana se quedó con el 100% del jugo y la otra con el 100% de la cáscara: ambas obtuvieron un resultado óptimo perfecto (Ganar-Ganar).</p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Atrincherarse en una posición por ego personal:</strong> Negarse a firmar un acuerdo financieramente beneficioso simplemente por no ''dar el brazo a torcer'' ante la otra persona.</li>
        <li><strong>Considerar la negociación como un juego de suma cero:</strong> Pensar erróneamente que cada dólar que el otro gana es un dólar que tú pierdes, impidiendo la creación de valor sinérgico.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Distingues con claridad los intereses de fondo detrás de las posiciones rígidas que te plantean?</li>
            <li>¿Sustentas tus ofertas comerciales en criterios objetivos y verificables de mercado?</li>
            <li>¿Propones opciones creativas que beneficien a ambas partes antes de cerrar la negociación?</li>
        </ul>
    </div>
</div>', 'Supera la negociación posicional destructiva (regateo duro o blando) y aprende los 4 principios de Roger Fisher y William Ury para crear valor mutuo.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (163, 163, 'El Modelo de Cal Newport: El Superpoder del Siglo XXI en la Economía del Conocimiento', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-lightning-charge-fill fs-2 text-success"></i>
        <div>
            <h5 class="fw-bold mb-1">El Trabajo Profundo es Escaso, Valioso y Altamente Recompensado</h5>
            <p class="mb-0 small">El profesor Cal Newport demostró que los profesionales que dominan el Deep Work producen en 4 horas lo que un trabajador disperso no logra en dos semanas completas. Aprende a construir tu fortaleza de concentración.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/CZURxyoeEXg" title="Mejorá tu productividad 🤯 | Deep Work (Céntrate) de Cal Newport" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-layers-fill text-primary me-2"></i>1. Trabajo Profundo (Deep Work) vs Trabajo Superficial (Shallow Work)</h4>
    <p>En el libro ''Deep Work'', Cal Newport clasifica las actividades laborales en dos universos radicalmente distintos:</p>
    <ul>
        <li><strong>Trabajo Profundo (Deep Work):</strong> Actividades profesionales realizadas en un estado de concentración desprovisto de distracciones que empujan tus capacidades cognitivas al límite. Estas actividades crean valor nuevo y único, mejoran tus habilidades técnicas y son prácticamente imposibles de replicar por inteligencia artificial o mano de obra barata (ej: escribir código complejo, diseñar un modelo financiero en Excel, redactar una propuesta estratégica o aprender un nuevo software empresarial).</li>
        <li><strong>Trabajo Superficial (Shallow Work):</strong> Tareas de tipo logístico o administrativo que no requieren gran esfuerzo intelectual y que a menudo se realizan mientras se está distraído (responder correos rutinarios, asistir a reuniones informativas, archivar facturas o actualizar estados en Slack). Son tareas necesarias para que la oficina funcione, pero no generan una ventaja competitiva duradera ni ascensos de carrera.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-lock text-primary me-2"></i>2. Las 4 Filosofías de Programación del Trabajo Profundo</h4>
    <p>Para integrar bloques de Deep Work en tu realidad profesional cotidiana:</p>
    <ol>
        <li><strong>Filosofía Monástica:</strong> Eliminar de raíz todo trabajo superficial y aislarse del mundo durante semanas (viable solo para autores, investigadores o científicos de élite).</li>
        <li><strong>Filosofía Bimodal:</strong> Dividir el tiempo en dos partes claras: por ejemplo, dedicar lunes y martes a reuniones y trámites administrativos, y miércoles, jueves y viernes exclusivamente a desarrollo técnico a puerta cerrada.</li>
        <li><strong>Filosofía Rítmica (La Más Recomendada para Oficinas):</strong> Fijar un horario inamovible todos los días laborales (ej: de 8:00 am a 10:30 am antes de que la oficina empiece a bullir) dedicado únicamente a tu entregable más difícil, con teléfono apagado y sin correos.</li>
        <li><strong>Filosofía Periodística:</strong> Entrar en modo Deep Work de inmediato en cualquier hueco libre imprevisto del día (requiere un entrenamiento mental muy avanzado).</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El ''Síndrome de la Hiperconectividad'':</strong> Creer que un buen profesional es aquel que responde mensajes de Teams o Slack en menos de 30 segundos a cualquier hora del día y la noche. Esta cultura destruye la capacidad cognitiva de concentración profunda del personal.</li>
        <li><strong>El Residuo de Atención (Attention Residue):</strong> La investigadora Sophie Leroy demostró que al cambiar de una tarea A a una tarea B, una parte sustancial de tu energía cognitiva se queda ''pegada'' en la tarea anterior, provocando lentitud y torpeza mental durante los siguientes 20 minutos.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Resguardas al menos 2 horas diarias de trabajo profundo rítmico libre de interrupciones?</li>
            <li>¿Distingues con claridad qué porcentaje de tu jornada dedicas a tareas superficiales vs profundas?</li>
            <li>¿Cierras aplicaciones de mensajería instantánea durante tus bloques de análisis técnico exigente?</li>
        </ul>
    </div>
</div>', 'Descubre por qué la habilidad de concentrarse profundamente sin distracciones en tareas cognitivamente exigentes es la ventaja profesional más escasa y valiosa del mercado.', 50, 1, true);
INSERT INTO public."Lessons" VALUES (19, 19, 'La Secuencia de Oro ante Emergencias Laborales y la Cadena de Supervivencia', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-hospital-fill fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">En una Emergencia, el Orden de los Factores Sí Altera la Vida</h5>
            <p class="mb-0 small">El impulso de correr a ayudar sin evaluar los peligros del entorno causa decenas de muertes cada año de socorristas improvisados. Aprende la regla universal de oro: Proteger, Avisar y Socorrer (PAS).</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/sN7QnnwoMBs" title="Conducta PAS: tres palabras que salvan vidas" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-shield-shaded text-primary me-2"></i>1. La Conducta PAS: El Protocolo Universal</h4>
    <p>Ante cualquier accidente en la oficina, fábrica o almacén, los tres pasos deben ejecutarse en este orden cronológico estricto sin saltarse ninguno:</p>
    <ul>
        <li><strong>1. P - PROTEGER (Seguridad de la Escena):</strong> Antes de tocar al accidentado, evalúa si el peligro sigue activo. ¿Hay cables de alta tensión caídos? ¿Hay fuga de gas inflamable? ¿Riesgo de derrumbe de estanterías? ¿Líquidos resbalosos o tráfico vehicular? Si el entorno no es 100% seguro, <em>NO INGRESES</em>. No te conviertas en una segunda víctima que los bomberos deban rescatar.</li>
        <li><strong>2. A - AVISAR (Llamado a los Servicios Médicos y Brigada Interna):</strong> Llama de inmediato al número de emergencia correspondiente (ej: 911 / Bomberos / Paramédicos). Proporciona información estructurada con precisión: <strong>1. Dónde ocurrió:</strong> Dirección exacta, piso y puntos de referencia. <strong>2. Qué ocurrió:</strong> Caída de altura, electrocución, paro cardíaco. <strong>3. Cuántas víctimas hay:</strong> Número aproximado y estado aparente (consciente o inconsciente). <em>(¡Regla de oro: Sé siempre el último en colgar el teléfono por si la operadora necesita más datos!)</em>.</li>
        <li><strong>3. S - SOCORRER (Atención Inicial Basada en Conocimiento):</strong> Aplica maniobras de soporte vital dentro de tus capacidades certificadas. Actúa con serenidad, habla a la víctima con voz tranquilizadora y evita movimientos bruscos si se sospecha lesión en la columna vertebral.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-heart-pulse-fill text-primary me-2"></i>2. Evaluación Primaria del Paciente: La Nemotecnia CAB</h4>
    <p>Siguiendo las guías actualizadas de la Asociación Americana del Corazón (AHA):</p>
    <ol>
        <li><strong>C - Circulation (Circulación y Pulso):</strong> Verificar si hay signos de circulación o hemorragias masivas exanguinantes que deban cohibirse de inmediato con presión directa.</li>
        <li><strong>A - Airway (Apertura de la Vía Aérea):</strong> Maniobra frente-mentón (elevar la barbilla con dos dedos mientras se empuja suavemente la frente hacia atrás para evitar que la base de la lengua obstruya la garganta). En caso de trauma o caída, usar tracción mandibular sin flexionar el cuello.</li>
        <li><strong>B - Breathing (Buena Ventilación):</strong> Ver, oír y sentir la respiración durante un máximo de 10 segundos. Si la persona no respira o solo jadea agónicamente (Gasping), se encuentra en paro cardiorrespiratorio y requiere RCP de inmediato.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mover a una víctima de accidente de tránsito o caída de altura:</strong> Mover a una persona con posible fractura de vértebras cervicales sin un collarín rígido puede seccionar la médula espinal y provocar parálisis permanente o la muerte instantánea. Solo debe moverse si hay peligro inminente de explosión o incendio.</li>
        <li><strong>Dar agua o comida a una persona inconsciente o herida grave:</strong> Puede causar broncoaspiración (el líquido va a los pulmones asfixiando al paciente) o complicar una cirugía de emergencia inminente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aseguras el entorno y evalúas riesgos antes de aproximarte a una víctima accidentada?</li>
            <li>¿Comunicas con claridad la ubicación exacta y el estado de la víctima al llamar a emergencias?</li>
            <li>¿Evitas dar líquidos, comida o medicamentos a personas inconscientes o traumatizadas?</li>
        </ul>
    </div>
</div>', 'Domina el orden inalterable PAS para intervenir en accidentes sin convertirte en una víctima adicional: evaluación de la escena, llamado eficaz a emergencias y triage básico.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (20, 20, 'Compresiones Torácicas de Alta Calidad y el Desfibrilador Externo Automático', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-heartbreak-fill fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Cada Minuto sin RCP Reduce la Supervivencia en un 10%</h5>
            <p class="mb-0 small">El paro cardiorrespiratorio repentino es la principal causa de muerte súbita en el entorno laboral. Tus manos son la bomba mecánica que mantendrá oxigenado el cerebro de tu compañero hasta que llegue la ambulancia.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/lG--e0vGX3w" title="Cómo hacer RCP en adultos(2022) | Doctor Negrete" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-activity text-primary me-2"></i>1. ¿Cómo Reconocer un Paro Cardíaco Repentino?</h4>
    <p>No pierdas minutos valiosos buscando pulso con dudas si no eres médico. La AHA establece un criterio de detección inmediata en 3 pasos:</p>
    <ul>
        <li><strong>Inconsciencia Total:</strong> Sacude suavemente a la víctima por los hombros y pregúntale en voz alta: <em>''¿Señor, señor, se encuentra bien?''</em>. Si no responde ni se mueve:</li>
        <li><strong>Ausencia de Respiración Normal:</strong> Observa el pecho durante 5 a 10 segundos. Si no se eleva, o si solo emite jadeos intermitentes y ruidosos (respiración agónica / boqueo), la víctima está en paro cardíaco.</li>
        <li><strong>Acción Fulminante:</strong> Señala a una persona específica de los presentes: <em>''Tú, con camisa azul, llama al 911 y trae el Desfibrilador (DEA) de la recepción ya''</em>. E inicia de inmediato las compresiones.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-lightning-fill text-primary me-2"></i>2. La Técnica de Compresiones Torácicas de Alta Calidad</h4>
    <p>Para bombear sangre oxigenada eficazmente hacia el cerebro:</p>
    <ol>
        <li><strong>Posición del Paciente y Socorrista:</strong> Paciente acostado boca arriba sobre una superficie firme y plana (el suelo, nunca en un colchón blando). El rescatista se arrodilla a un costado a la altura del pecho.</li>
        <li><strong>Colocación de las Manos:</strong> Apoya el talón de una mano en el centro del pecho de la víctima (mitad inferior del esternón). Entrelaza los dedos de la otra mano por encima, manteniendo los dedos levantados sin presionar las costillas.</li>
        <li><strong>Brazos Rectos y Fuerza del Torso:</strong> Bloquea los codos en posición totalmente recta. Tus hombros deben estar verticalmente alineados justo encima del pecho de la víctima. Empuja usando el peso de tu tronco y cadera, no con la fuerza de los brazos.</li>
        <li><strong>Profundidad y Frecuencia:</strong> Comprime con una profundidad de al menos 5 cm (sin exceder 6 cm en adultos) a un ritmo constante de <strong>100 a 120 compresiones por minuto</strong> (el ritmo de la famosa canción <em>''Stayin'' Alive''</em> de los Bee Gees).</li>
        <li><strong>Permitir la Expansión Torácica Completa:</strong> Deja que el tórax regrese completamente a su posición original entre compresión y compresión. Si te quedas apoyado sobre el pecho, el corazón no puede llenarse de sangre para el siguiente bombeo.</li>
        <li><strong>Minimizar Interrupciones:</strong> Cada interrupción en las compresiones hace que la presión de perfusión cerebral caiga a cero en 3 segundos. Si no estás entrenado o no dispones de mascarilla de barrera, haz <strong>RCP Solo con las Manos (Hands-Only CPR)</strong> de forma continua sin detenerte para dar ventilaciones boca a boca.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-cpu-fill text-primary me-2"></i>3. El Desfibrilador Externo Automático (DEA)</h4>
    <p>El DEA es un dispositivo inteligente diseñado para que cualquier ciudadano sin conocimientos médicos pueda utilizarlo con total seguridad:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <p class="mb-0 text-muted small"><strong>Operación del DEA en 3 Pasos:</strong> <strong>1. Encender el equipo:</strong> Al presionar el botón de encendido, el DEA comenzará a dar instrucciones por voz en español. <strong>2. Pegar los parches electrodos:</strong> Uno en la parte superior derecha del pecho (debajo de la clavícula) y otro en el costado izquierdo (debajo de la axila), sobre la piel seca y descubierta. <strong>3. Seguir la voz del equipo:</strong> El DEA analizará el ritmo cardíaco. Si dice <em>''Se recomienda descarga, nadie toque al paciente''</em>, grita enérgicamente: <em>''¡Atrás todos!''</em>, verifica visualmente que nadie esté en contacto con la víctima y presiona el botón de descarga iluminado. Continúa de inmediato con las compresiones torácicas.</p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Doblar los codos al comprimir:</strong> Hace que el rescatista se agote muscularmente en menos de 90 segundos y las compresiones sean superficiales e inútiles.</li>
        <li><strong>Miedo a usar el DEA pensando que se puede electrocutar por error a alguien:</strong> El software del DEA es infalible: analiza el trazado eléctrico y nunca emitirá una descarga si el paciente no tiene una arritmia mortal desfibrilable (Fibrilación Ventricular o Taquicardia Ventricular sin pulso).</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Mantienes los brazos rectos comprimiendo el tórax a un ritmo de 100-120 latidos por minuto?</li>
            <li>¿Permites que el pecho se expanda por completo entre cada compresión torácica?</li>
            <li>¿Sabes en qué pared o pasillo de tu empresa se encuentra ubicado el botiquín y el DEA?</li>
        </ul>
    </div>
</div>', 'Aprende la técnica de RCP moderna de la AHA: frecuencia de 100-120 lpm, profundidad de 5 cm, descompresión completa y funcionamiento paso a paso del desfibrilador (DEA).', 50, 1, true);
INSERT INTO public."Lessons" VALUES (255, 255, 'La Regla de los 7 Segundos y la Comunicación No Verbal Cara a Cara', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-person-badge-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">Nunca Hay una Segunda Oportunidad para una Primera Impresión</h5>
            <p class="mb-0 small">El 93% del impacto comunicativo presencial proviene del tono de voz y el lenguaje corporal. Aprende a proyectar autoridad serena, amabilidad genuina y profesionalismo absoluto desde el primer instante.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/yFIZDfSU6Wo" title="COMUNICACIÓN NO VERBAL: Definición, tipos y funciones 😎🤗" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-stopwatch text-primary me-2"></i>1. La Neurociencia de la Primera Impresión</h4>
    <p>Cuando un cliente ingresa a un establecimiento comercial o se acerca a un mostrador de atención, su sistema límbico evalúa al representante en los primeros 7 segundos bajo dos parámetros evolutivos fundamentales descubiertos por la Dra. Amy Cuddy de Harvard:</p>
    <ul>
        <li><strong>Calidez (Warmth):</strong> <em>¿Esta persona tiene intenciones amigables hacia mí? ¿Puedo confiar en ella?</em> Se transmite a través de la sonrisa genuina (sonrisa Duchenne), la mirada directa a los ojos y una expresión facial relajada y receptiva.</li>
        <li><strong>Competencia (Competence):</strong> <em>¿Esta persona tiene la capacidad técnica para resolver mi necesidad?</em> Se proyecta mediante una postura erguida pero no rígida, movimientos seguros y una presencia personal pulcra e impecable.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-person-walking text-primary me-2"></i>2. Desglose del Lenguaje Corporal Profesional</h4>
    <p>El cuerpo habla antes de que pronunciemos la primera palabra de saludo:</p>
    <ol>
        <li><strong>Contacto Visual Equilibrado:</strong> Mantener la mirada entre el 60% y 70% del tiempo de interacción en el triángulo facial (ojos y puente nasal). Mirar al suelo transmite timidez o culpa; mirar fijamente sin parpadear resulta intimidatorio; mirar constantemente la pantalla de la computadora o el teléfono móvil comunica indiferencia total.</li>
        <li><strong>Postura Abierta (Brazos y Manos Visibles):</strong> Cruzar los brazos a la altura del pecho o esconder las manos en los bolsillos crea una barrera física inconsciente que el cliente interpreta como hostilidad o desinterés. Mantener los brazos a los lados con gestos explicativos de palmas abiertas genera apertura y honestidad.</li>
        <li><strong>La Zona Proxémica Adecuada:</strong> Respetar la distancia personal (aproximadamente entre 1 y 1.2 metros en mostradores). Invadir el espacio físico del cliente genera incomodidad y tensión innecesaria.</li>
        <li><strong>La Sonrisa Profesional:</strong> Saludar con una leve inclinación de cabeza y una sonrisa sincera relaja automáticamente al visitante más ansioso.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-chat-quote text-primary me-2"></i>3. El Saludo Protocolar Inmediato</h4>
    <p>Todo visitante debe ser reconocido verbalmente en menos de 10 segundos, incluso si estás atendiendo a otra persona o hablando por teléfono:</p>
    <div class="card bg-light border-start border-primary border-4 p-3 mb-3">
        <p class="mb-1 fw-bold">Fórmula de Saludo de Excelencia:</p>
        <p class="mb-0 text-muted"><em>''¡Muy buenos días, bienvenido a [Nombre de Empresa]! Mi nombre es [Tu Nombre], en un momento estoy con usted con el mayor gusto.''</em> (Si estás ocupado, una mirada, una sonrisa y un gesto de cortesía bastan para evitar que la persona se sienta ignorada).</p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El ''Síndrome del Mostrador Invisible'':</strong> Estar conversando de temas personales con un compañero o riendo entre risillas mientras el cliente espera de pie frente al mostrador. Destruye instantáneamente la reputación corporativa.</li>
        <li><strong>Uso del teléfono móvil personal en el área de servicio:</strong> Estar chateando o revisando redes sociales detrás del mostrador comunica desidia absoluta y falta de respeto al usuario.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Saludas al cliente con contacto visual directo y una sonrisa dentro de los primeros 10 segundos?</li>
            <li>¿Mantienes una postura erguida y abierta sin cruzar los brazos en el mostrador?</li>
            <li>¿Guardas tu teléfono celular personal fuera de la vista de los usuarios durante tu turno de atención?</li>
        </ul>
    </div>
</div>', 'Descubre cómo el cerebro del cliente evalúa tu calidez y competencia en cuestión de segundos mediante la postura, la mirada, la distancia interpersonal y la sonrisa profesional.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (264, 264, 'La Complementariedad de Talentos y las Fases de Desarrollo del Equipo', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-people-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Nadie es Perfecto, Pero un Equipo Sí Puede Serlo</h5>
            <p class="mb-0 small">Un grupo de personas trabajando en el mismo lugar no es un equipo. Conoce los roles de Belbin y cómo combinar perfiles analíticos, creativos y ejecutores para lograr sinergia multiplicadora.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/XeCtsvIg5Eo" title="Trabajo en equipo: roles de BELBIN" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-puzzle text-primary me-2"></i>1. Los 9 Roles de Equipo según Meredith Belbin</h4>
    <p>El Dr. Belbin de la Universidad de Cambridge demostró que los equipos exitosos no están formados por personas idénticas, sino por una mezcla equilibrada de tres categorías de roles complementarios:</p>
    <ul>
        <li><strong>Roles de Acción:</strong>
            <ul>
                <li><em>Impulsor (Shaper):</em> Dinámico y retador, empuja al equipo a superar obstáculos y cumplir plazos.</li>
                <li><em>Implementador (Implementer):</em> Práctico y disciplinado, convierte las ideas abstractas en tareas operativas concretas.</li>
                <li><em>Finalizador (Completer Finisher):</em> Meticuloso y detallista, busca errores, pule la calidad y asegura que nada quede a medias.</li>
            </ul>
        </li>
        <li><strong>Roles Mentales y Creativos:</strong>
            <ul>
                <li><em>Cerebro (Plant):</em> Altamente creativo e innovador, resuelve problemas complejos con soluciones fuera de la caja.</li>
                <li><em>Monitor Evaluador:</em> Analítico, frío y objetivo, sopesa pros y contras antes de tomar decisiones arriesgadas.</li>
                <li><em>Especialista:</em> Aporta conocimientos técnicos profundos y específicos indispensables para el proyecto.</li>
            </ul>
        </li>
        <li><strong>Roles Sociales e Interpersonales:</strong>
            <ul>
                <li><em>Coordinador:</em> Clarifica metas, promueve la toma de decisiones y delega eficazmente.</li>
                <li><em>Investigador de Recursos:</em> Extrovertido y sociable, busca contactos, financiamiento y oportunidades externas.</li>
                <li><em>Cohesionador (Teamworker):</em> Diplomático y empático, calma tensiones y fomenta el buen clima de trabajo.</li>
            </ul>
        </li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-diagram-2 text-primary me-2"></i>2. Las 4 Fases de Evolución del Equipo (Modelo Tuckman)</h4>
    <p>Todo equipo de trabajo atraviesa obligatoriamente por cuatro etapas antes de alcanzar la madurez operativa:</p>
    <ol>
        <li><strong>Formación (Forming):</strong> Cortesía inicial, incertidumbre sobre roles y búsqueda de aprobación del líder.</li>
        <li><strong>Conflicto (Storming):</strong> Chocan las personalidades, surgen disputas por el liderazgo y diferencias en el ritmo de trabajo. Es una fase natural y necesaria; superarla fortalece al grupo.</li>
        <li><strong>Normalización (Norming):</strong> Se acuerdan reglas claras, se aceptan las diferencias y se consolida la confianza mutua.</li>
        <li><strong>Desempeño (Performing):</strong> Sinergia total, alta productividad, autonomía y enfoque unificado en resultados excepcionales.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Armar equipos homogéneos (El sesgo del espejo):</strong> Contratar personas que piensen exactamente igual al líder genera puntos ciegos gigantescos y falta de espíritu crítico.</li>
        <li><strong>Tolerar el parasitismo social (Efecto Ringelmann):</strong> Permitir que algunos miembros no aporten nada escudándose en el esfuerzo de los demás colaboradores.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Conoces tu rol natural de Belbin y cómo complementa las debilidades del resto del equipo?</li>
            <li>¿Comprendes que la fase de conflicto es natural y debe resolverse con acuerdos formales?</li>
            <li>¿Asumes la responsabilidad individual de tus tareas asignadas sin depender del empuje ajeno?</li>
        </ul>
    </div>
</div>', 'Aprende cómo estructurar equipos de alto rendimiento utilizando los 9 roles de Belbin y comprende el modelo de Tuckman (Forming, Storming, Norming, Performing).', 50, 1, true);
INSERT INTO public."Lessons" VALUES (179, 179, 'Desobstrucción de la Vía Aérea en Adultos Conscientes, Inconscientes y Auto-Heimlich', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-lungs-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Obstrucción de Vía Aérea Mata por Asfixia en Menos de 4 Minutos</h5>
            <p class="mb-0 small">Durante el almuerzo en la cafetería o un evento corporativo, un trozo de comida puede bloquear la tráquea por completo. Conoce el signo universal de atragantamiento y la aplicación precisa de la Maniobra de Heimlich.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/vBvMbXjCA14" title="Enfermeras explican cómo realizar la maniobra de Heimlich en caso de atragantamiento" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-exclamation-octagon text-primary me-2"></i>1. Diagnóstico: Obstrucción Parcial vs Obstrucción Total</h4>
    <p>Antes de aplicar cualquier fuerza física, es vital identificar el grado de bloqueo:</p>
    <ul>
        <li><strong>Obstrucción Parcial (Leve):</strong> La persona tose con fuerza, puede emitir sonidos o hablar entrecortadamente. <strong>Acción:</strong> <em>NO golpees la espalda y NO hagas Heimlich</em>. Anima a la persona a seguir tosiendo con fuerza (<em>''Siga tosiendo, expúlselo''</em>). La tos refleja humana es el mecanismo más potente del cuerpo para expulsar objetos. Dar golpes en la espalda en una obstrucción parcial puede mover el objeto y causar un bloqueo total.</li>
        <li><strong>Obstrucción Total (Severa):</strong> La persona se lleva desesperadamente ambas manos al cuello (el <strong>Signo Universal de Asfixia</strong>), no puede hablar, no puede toser, no emite ningún sonido y sus labios comienzan a ponerse morados o azulados (cianosis). <strong>Acción:</strong> Aplicar de inmediato la Maniobra de Heimlich.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-hand-thumbs-up text-primary me-2"></i>2. Paso a Paso de la Maniobra de Heimlich en Adultos Conscientes</h4>
    <p>El objetivo es empujar el diafragma hacia arriba para comprimir el aire residual de los pulmones creando una tos artificial que expulse el objeto como un proyectil:</p>
    <ol>
        <li><strong>Posición de Seguridad:</strong> Colócate de pie detrás de la víctima. Pasa una de tus piernas entre las piernas del paciente para tener una base de apoyo firme en caso de que la persona pierda el conocimiento y caiga desmayada.</li>
        <li><strong>Ubicación de las Manos:</strong> Cierra una mano en puño con el pulgar hacia adentro. Coloca el lado del pulgar de tu puño en el abdomen de la víctima, justo por encima del ombligo y bien por debajo del apéndice xifoides (la punta inferior del esternón). Sujeta firmemente tu puño con tu otra mano.</li>
        <li><strong>El Movimiento en ''J'':</strong> Realiza compresiones rápidas, secas y firmes hacia adentro y hacia arriba (en forma de letra ''J''). Repite las compresiones con fuerza hasta que el objeto sea expulsado o la víctima quede inconsciente.</li>
        <li><strong>¿Qué hacer si la víctima queda inconsciente?:</strong> Acuéstala con cuidado en el suelo boca arriba, llama a emergencias e inicia de inmediato ciclos de RCP (compresiones torácicas). Cada vez que abras la vía aérea para ventilar, mira dentro de la boca: solo si el objeto está visible y al alcance de tus dedos, extráelo con un barrido de dedo; nunca metas el dedo a ciegas.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-person-fill text-primary me-2"></i>3. Auto-Heimlich (Si Estás Solo y Nadie Puede Ayudarte)</h4>
    <p>Si te atragantas estando solo en una oficina o en casa: coloca tu propio puño sobre tu ombligo sujetado con la otra mano y apóyate con fuerza sobre el borde superior de una silla de espaldar rígido, una baranda o el borde de una mesa resistente, empujando tu abdomen hacia adentro y hacia arriba repetidamente.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Colocar el puño sobre las costillas o el esternón:</strong> Comprimir sobre el hueso en lugar del abdomen blando subdiafragmático fractura costillas y no genera la presión de aire pulmonar necesaria para expulsar el cuerpo extraño.</li>
        <li><strong>Meter los dedos en la boca de la persona a ciegas:</strong> Intentar ''pescar'' el objeto con el dedo sin verlo empuja el trozo de comida más adentro en la laringe, empeorando el bloqueo.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Reconoces el signo universal de asfixia (manos al cuello sin poder emitir sonidos)?</li>
            <li>¿Posicionas tu puño dos dedos por encima del ombligo con empuje firme hacia adentro y arriba?</li>
            <li>¿Conoces la técnica de Auto-Heimlich utilizando el respaldo de una silla sólida?</li>
        </ul>
    </div>
</div>', 'Reconoce el signo universal de asfixia (manos al cuello) y aprende a realizar compresiones abdominales subdiafragmáticas para expulsar cuerpos extraños rápidamente.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (51, 51, 'Elaboración de Informes, Cartas y Memorándums Corporativos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-file-earmark-word-fill fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">El Estándar de Redacción en Empresas Modernas</h5>
            <p class="mb-0 small">Un documento mal formateado resta credibilidad institucional. Aprender a dominar sangrías, estilos de párrafo y numeración jerárquica ahorra horas de trabajo y previene el desorden documental en cualquier oficina.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/XeqAyA6juCg" title="Word desde CERO: Cómo DAR FORMATO PROFESIONAL con ESTILOS y TABLA Automática" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Jerarquía Estructural de un Documento de Negocios</h4>
    <p>El error más recurrente de los usuarios novatos en Microsoft Word es aplicar negritas, cambiar el tamaño de letra manualmente a 14pt o 16pt y dar múltiples ''Enter'' para separar párrafos o forzar saltos de página. En un entorno laboral formal, este método artesanal provoca que al modificar una línea en la página 2, todo el informe de 30 páginas se desconfigure por completo.</p>
    <p>El estándar profesional exige el uso riguroso del panel de <strong>Estilos de Word</strong>:</p>
    <ul>
        <li><strong>Título 1 (Heading 1):</strong> Reservado exclusivamente para los capítulos o secciones principales del documento (ej: 1. INTRODUCCIÓN, 2. DIAGNÓSTICO FINANCIERO).</li>
        <li><strong>Título 2 (Heading 2):</strong> Para subtítulos de segundo nivel (ej: 2.1 Análisis de Costos Fijos, 2.2 Proyección de Ingresos).</li>
        <li><strong>Normal (Body Text):</strong> Para todo el texto corrido. Tipografía estándar corporativa (Aptos, Calibri o Arial de 11pt a 12pt, interlineado 1.15 a 1.5, con espaciado posterior de 6pt a 8pt entre párrafos para erradicar la necesidad de dar dobles saltos de línea con la tecla Enter).</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-gear-fill text-primary me-2"></i>2. Generación Automatizada de Tablas de Contenido (Índices)</h4>
    <p>Cuando un informe se estructura utilizando la jerarquía oficial de Estilos (Título 1, Título 2, Título 3), crear el índice general de la obra toma exactamente dos clics:</p>
    <ol>
        <li>Posicionar el cursor en la página donde se requiere el índice (después de la portada y la carta de presentación).</li>
        <li>Ir a la pestaña superior <strong>Referencias</strong> de la cinta de opciones.</li>
        <li>Hacer clic en <strong>Tabla de contenido</strong> y seleccionar el estilo automático preferido.</li>
        <li><strong>Actualización Dinámica:</strong> Si en el futuro agregas texto o cambian los números de página, basta con hacer clic derecho sobre la tabla y seleccionar <em>''Actualizar campos ➔ Actualizar toda la tabla''</em> para que Word sincronice títulos y páginas al milisegundo sin digitar números a mano.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico de Oficina: Memorándum Corporativo Estandarizado</h4>
    <div class="card border-0 bg-light p-3 rounded-3 mb-4">
        <h6 class="fw-bold text-dark mb-2">Estructura Obligatoria de Correspondencia Interna</h6>
        <div class="font-monospace small bg-white p-3 rounded border">
            <strong>MEMORÁNDUM INTERNO N° 2026-ADM-042</strong><br />
            <strong>PARA:</strong> Todo el Personal de Operaciones y Ventas<br />
            <strong>DE:</strong> Gerencia de Administración y Recursos Humanos<br />
            <strong>FECHA:</strong> 24 de Octubre de 2026<br />
            <strong>ASUNTO:</strong> Implementación del Nuevo Protocolo de Rendición de Gastos de Viaje<br />
            <hr class="my-2" />
            Se informa a todos los colaboradores que a partir del primer día hábil del próximo mes entrará en vigencia el sistema digital de rendición de viáticos...
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Presionar Enter repetidamente para pasar a la siguiente página:</strong> Provoca que cualquier edición previa mueva los títulos a mitad de página. La regla profesional es presionar siempre el atajo de teclado <code>Ctrl + Enter</code> para insertar un <em>Salto de Página</em> limpio.</li>
        <li><strong>Encabezados idénticos en la portada:</strong> Para evitar que el número de página o el logotipo aparezca en la primera hoja, se debe marcar la casilla <em>''Primera página diferente''</em> en la pestaña de Diseño de Encabezado y Pie de página.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Utilizaste los estilos Título 1 y Título 2 en lugar de cambiar el tamaño de letra manualmente?</li>
            <li>¿Insertaste saltos de página con Ctrl + Enter en lugar de múltiples líneas vacías?</li>
            <li>¿Verificaste la ortografía y gramática completa presionando la tecla F7 antes de exportar a PDF?</li>
        </ul>
    </div>
</div>', 'Aprende a maquetar documentos bajo normas corporativas, usar la cinta de opciones, aplicar estilos de título para generar tablas de contenido automáticas y configurar encabezados/pies de página diferenciados.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (180, 180, 'Control del Sangrado con Presión Directa, Torniquetes y Manejo de Lesiones Comunes', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-bandaid-fill fs-2 text-danger"></i>
        <div>
            <h5 class="fw-bold mb-1">Una Hemorragia Arterial Masiva Puede Causar la Muerte en Menos de 3 Minutos</h5>
            <p class="mb-0 small">Cortes con herramientas industriales, vidrios rotos o caídas en escaleras son accidentes frecuentes en el entorno laboral. Conoce los protocolos científicos para detener sangrados, tratar quemaduras y equipar el botiquín reglamentario.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/yfTdaIkT5YI" title="Hemorragias, Fracturas y Quemaduras" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-droplet-half text-danger me-2"></i>1. Control Científico de Hemorragias (Campaña ''Stop the Bleed'')</h4>
    <p>El sangrado incontrolado es la principal causa prevenible de muerte en traumas laborales:</p>
    <ul>
        <li><strong>Presión Directa Continua:</strong> Coloca un apósito estéril, gasa limpia o paño grueso directamente sobre la herida sangrante y aplica una presión firme y constante con ambas manos utilizando el peso de tu cuerpo durante al menos 5 a 10 minutos sin levantar el apósito para mirar. Si la sangre traspasa el apósito, <em>NO LO RETIRES</em> (destruirías el coágulo que se está formando); coloca más gasas por encima y refuerza la presión.</li>
        <li><strong>Vendaje Compresivo:</strong> Una vez contenido el flujo principal, fijar las gasas con una venda elástica enrollada con firmeza alrededor de la extremidad.</li>
        <li><strong>Torniquetes Comerciales (CAT / SOFTT):</strong> Ante heridas por amputación o desgarros arteriales en brazos o piernas donde la sangre brota a borbotones pulsátiles y la presión directa no es suficiente, aplicar un torniquete táctico entre 5 y 7 cm por encima de la herida (nunca sobre una articulación). Ajustar hasta que el sangrado se detenga por completo y anotar la hora exacta de colocación con marcador en la frente del paciente.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-fire text-primary me-2"></i>2. Protocolo de Atención ante Quemaduras Térmicas y Químicas</h4>
    <p>Las quemaduras se clasifican por su profundidad y requieren enfriamiento inmediato:</p>
    <ol>
        <li><strong>La Regla del Agua Fría:</strong> Enfriar la zona quemada bajo un chorro continuo de agua corriente limpia a temperatura ambiente (no helada) durante al menos 10 a 20 minutos ininterrumpidos. Esto detiene la progresión del calor a través de las capas dérmicas profundas y alivia el dolor.</li>
        <li><strong>Protección Estéril:</strong> Cubrir con una gasa estéril humedecida o film plástico transparente sin apretar para evitar infecciones.</li>
        <li><strong>Quemaduras Químicas (Ácidos o Solventes):</strong> Lavar con agua abundante por más de 20 minutos y retirar la ropa contaminada con guantes protectores.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-medical text-primary me-2"></i>3. Dotación Reglamentaria del Botiquín de Primeros Auxilios de Oficina</h4>
    <p>Un botiquín laboral debe estar señalizado, ser de fácil acceso y contener insumos de soporte básico:</p>
    <div class="card bg-light border-0 p-3 rounded-3 mb-3">
        <ul class="mb-0 small">
            <li>Guantes descartables de nitrilo o látex (indispensables para bioseguridad ante fluidos biológicos).</li>
            <li>Gasas estériles, apósitos absorbentes y vendas elásticas de diversos anchos.</li>
            <li>Solución fisiológica salina al 0.9% (para lavado ocular y limpieza de heridas).</li>
            <li>Cinta adhesiva microporosa (tipo Micropore) y tijera de trauma punta roma.</li>
            <li>Mascarilla de barrera facial para RCP.</li>
            <li><em>(¡Importante: Los botiquines de primeros auxilios NO deben contener medicamentos ingeribles como antibióticos o sedantes por normativas de salud ocupacional!)</em>.</li>
        </ul>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Aplicar hielo directo, pasta dental o manteca sobre quemaduras:</strong> El hielo produce vasoconstricción severa y quemadura térmica por congelación agregada; las pastas y pomadas caseras infectan la herida abierta y deben ser raspadas dolorosamente en el hospital.</li>
        <li><strong>Reventar las ampollas (Flictenas):</strong> La ampolla es un vendaje biológico estéril que produce el propio cuerpo para proteger la piel nueva. Reventarla expone los tejidos a infecciones bacterianas graves.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Usas guantes protectores antes de tocar sangre o fluidos biológicos de un accidentado?</li>
            <li>¿Enfrías las quemaduras con agua corriente limpia durante al menos 10 a 15 minutos?</li>
            <li>¿Verificas mensualmente que el botiquín de tu área de trabajo esté completo y sin insumos vencidos?</li>
        </ul>
    </div>
</div>', 'Domina el protocolo Stop the Bleed para contener hemorragias graves, el tratamiento del agua fría en quemaduras y la dotación reglamentaria del botiquín empresarial.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (266, 266, 'La Neurociencia del Enfoque, la Regla de los 2 Minutos y Hábitos Atómicos', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-alarm-fill fs-2 text-warning"></i>
        <div>
            <h5 class="fw-bold mb-1">La Procrastinación No es Pereza; es Mala Regulación Emocional</h5>
            <p class="mb-0 small">No procrastinas porque no tengas tiempo; procrastinas para evitar el malestar emocional (miedo al fracaso, aburrimiento o perfeccionismo paralizante) que te produce iniciar una tarea difícil. Aprende a hackear tu cerebro para rendir al máximo.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/wExgu4I0jQA" title="Así Funciona la Mente de un PROCRASTINADOR (y Cómo Resolverlo)" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-lightning-charge text-primary me-2"></i>1. La Batalla Cerebral: Sistema Límbico vs Corteza Prefrontal</h4>
    <p>En el cerebro humano compiten dos estructuras biológicas con prioridades radicalmente opuestas:</p>
    <ul>
        <li><strong>El Sistema Límbico (El ''Mono de la Gratificación Inmediata''):</strong> Primitivo, veloz e instintivo. Busca placer a corto plazo, dopamina rápida (redes sociales, videos cortos) y huir de cualquier esfuerzo que genere incomodidad.</li>
        <li><strong>La Corteza Prefrontal (El ''Adulto Racional''):</strong> Evolutivamente moderna, reflexiva y analítica. Planifica a largo plazo, visualiza las consecuencias futuras de no trabajar y busca la autorrealización profesional.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-check-circle text-primary me-2"></i>2. Estrategias Basadas en Evidencia para Vencer la Procrastinación</h4>
    <p>Para desactivar la resistencia mental al inicio de una tarea pesada:</p>
    <ol>
        <li><strong>La Regla de los 2 Minutos (David Allen & James Clear):</strong> Reduce la tarea a una versión minúscula que tome menos de 120 segundos. Si tienes que redactar un informe de 40 páginas, tu único objetivo inicial es: <em>''Abrir el archivo de Word y escribir el título''</em>. Una vez que el cerebro supera la inercia del arranque, la fricción mental desaparece y el estado de flujo (Flow) se activa por sí solo.</li>
        <li><strong>Aumentar la Fricción de las Distracciones:</strong> Cada clic o segundo extra que te tome acceder a una distracción reduce en un 80% la probabilidad de caer en ella. Pon el teléfono móvil en otra habitación o utiliza bloqueadores de sitios web durante tus bloques de trabajo importante.</li>
        <li><strong>Apilamiento de Hábitos (Habit Stacking):</strong> Anclar una rutina productiva nueva a un hábito automático que ya realizas todos los días: <em>''Después de servirme mi primera taza de café de la mañana, revisaré y priorizaré mis tres tareas críticas del día antes de abrir el correo''</em>.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La ilusión del Multitasking (Multitarea):</strong> Intentar hacer tres cosas a la vez reduce el coeficiente intelectual funcional en 10 puntos y triplica la tasa de errores. El cerebro no procesa en paralelo; cambia de foco velozmente con un costo cognitivo altísimo.</li>
        <li><strong>El Perfeccionismo Paralizante:</strong> No entregar proyectos a tiempo alegando que ''todavía no están perfectos''. En el mundo laboral moderno: <em>''Mejor hecho que perfecto''</em>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Aplicas la regla de los dos minutos para vencer la inercia de iniciar tareas pesadas?</li>
            <li>¿Eliminas notificaciones y guardas el teléfono durante tus bloques de trabajo importante?</li>
            <li>¿Trabajas en una sola tarea a la vez evitando la trampa del multitasking?</li>
        </ul>
    </div>
</div>', 'Descubre por qué tu cerebro pospone tareas difíciles y cómo reprogramar tus hábitos con la regla de los dos minutos, la fricción ambiental y el apilamiento de hábitos.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (53, 53, 'Automatización de Cálculos: De la Suma Simple a las Referencias Absolutas ($)', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-currency-dollar fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">El Secreto de Excel: Fijar Celdas con el Signo de Dólar ($)</h5>
            <p class="mb-0 small">El 90% de los errores al arrastrar fórmulas hacia abajo o hacia la derecha ocurren por no entender cuándo fijar una celda fija (como una tasa de cambio o un porcentaje de comisión) con la tecla F4.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/9eTxxrRVF2Q" title="Funciones de Excel Básicas: SUMA, PROMEDIO, CONTAR" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. Las 5 Funciones Núcleo de la Oficina</h4>
    <p>En lugar de sumar celda por celda (<code>=A1+A2+A3+A4...</code>), Excel provee funciones preprogramadas que procesan rangos enteros en milisegundos indicando la celda inicial y la final separadas por dos puntos (<code>:</code>):</p>
    <ul>
        <li><code>=SUMA(C2:C100)</code>: Suma todas las cantidades numéricas del rango indicado, ignorando celdas con texto o en blanco.</li>
        <li><code>=PROMEDIO(D2:D100)</code>: Calcula la media aritmética (suma de valores dividida entre la cantidad de celdas con número).</li>
        <li><code>=CONTAR(A2:A100)</code>: Cuenta cuántas celdas contienen valores puramente numéricos.</li>
        <li><code>=CONTARA(A2:A100)</code>: Cuenta celdas no vacías (útil para saber cuántos empleados o clientes hay en la lista, contenga texto o números).</li>
        <li><code>=MAX(E2:E100)</code> y <code>=MIN(E2:E100)</code>: Devuelven la venta más alta y el costo más bajo del período respectivamente.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-pin-angle-fill text-danger me-2"></i>2. Referencias Relativas vs Referencias Absolutas ($ con F4)</h4>
    <p>Cuando escribes <code>=B2 * C2</code> y arrastras la celda hacia abajo, Excel inteligentemente adapta la fórmula a <code>=B3 * C3</code>, luego <code>=B4 * C4</code>. Esto se llama <strong>Referencia Relativa</strong>.</p>
    <p>Pero imagínate que en la celda <code>$F$1</code> tienes la tasa de cambio oficial del BCV o el porcentaje de IVA (16%), y quieres multiplicar las ventas de cada fila por esa celda fija. Si arrastras la fórmula normal, en la siguiente fila Excel buscará en F2, luego en F3 (celdas vacías), multiplicando por cero y arrojando ceros en toda la columna.</p>
    <p>Para evitarlo, debes presionar la tecla <strong>F4</strong> sobre la celda para convertirla en <strong>Referencia Absoluta</strong> (aparecerán los signos de dólar: <code>$F$1</code>):</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <p class="small mb-0 font-monospace text-dark">
            <strong>Fórmula Correcta:</strong> <code>=D2 * $F$1</code><br />
            Al arrastrar hacia abajo, se convierte en:<br />
            Fila 3: <code>=D3 * $F$1</code><br />
            Fila 4: <code>=D4 * $F$1</code><br />
            <em>(D2 se mueve libremente por ser relativa, pero $F$1 queda firmemente anclada como referencia absoluta).</em>
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-briefcase-fill text-primary me-2"></i>3. Caso Práctico: Cálculo de Comisiones con Meta Mínima</h4>
    <p>Si deseas calcular comisiones únicamente a los asesores que superaron la meta mínima de ventas, se combina una referencia absoluta con una lógica de porcentaje:</p>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Asesor</th>
                    <th>Venta Real (B)</th>
                    <th>Meta Fija ($E$1 = $5.000)</th>
                    <th>Tasa Comisión ($E$2 = 5%)</th>
                    <th>Fórmula en Columna C</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Carlos R.</td>
                    <td>$6.200</td>
                    <td>$5.000</td>
                    <td>5%</td>
                    <td><code>=B2 * $E$2</code> ➔ $310 USD</td>
                </tr>
                <tr>
                    <td>María L.</td>
                    <td>$4.800</td>
                    <td>$5.000</td>
                    <td>5%</td>
                    <td><code>=B3 * $E$2</code> ➔ $240 USD</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir los signos de dólar ($) a mano y equivocarse de posición:</strong> Recuerda siempre presionar la tecla <code>F4</code> (o <code>Fn + F4</code> en algunas laptops portátiles) con el cursor ubicado sobre la celda para alternar automáticamente entre <code>$A$1</code> (fija fila y columna), <code>A$1</code> (fija solo fila) y <code>$A1</code> (fija solo columna).</li>
        <li><strong>Incluir la celda del total dentro del propio rango de la suma:</strong> Si en la celda A10 escribes <code>=SUMA(A1:A10)</code>, provocarás un error de <em>Referencia Circular</em>, donde la fórmula intenta sumarse a sí misma infinitamente bloqueando el cálculo. La fórmula correcta es <code>=SUMA(A1:A9)</code>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Utilizaste referencias absolutas ($) para fijar celdas de impuestos, comisiones o tasas de cambio?</li>
            <li>¿Verificaste que no existan referencias circulares en la barra de estado inferior de Excel?</li>
            <li>¿Revisaste que los rangos de SUMA no incluyan filas de encabezado de texto?</li>
        </ul>
    </div>
</div>', 'Domina las funciones núcleo de oficina: SUMA, PROMEDIO, CONTAR, MAX y MIN. Comprende la diferencia vital entre referencias relativas (A1) y referencias absolutas fijadas ($A$1) con F4.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (5, 5, 'Búsquedas Dinámicas hacia la Izquierda y Extracción Multicolumna', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-search fs-2 text-primary"></i>
        <div>
            <h5 class="fw-bold mb-1">BUSCARX: La Función que Revolucionó el Análisis de Datos en Excel</h5>
            <p class="mb-0 small">Durante décadas, BUSCARV fue la función reina, pero su incapacidad para buscar hacia la izquierda y su vulnerabilidad al insertar columnas en la base de datos la convirtieron en una fuente constante de errores. BUSCARX resuelve todas esas fallas con una sintaxis moderna y flexible.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/tx9kugxoQRk" title="Excel - Uso de función BUSCARX / XLOOKUP" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. ¿Por qué BUSCARV se Quedó Obsoleta?</h4>
    <p>La tradicional función <code>BUSCARV</code> exigía contar manualmente el número de columna (ej: <code>=BUSCARV(A2; D:Z; 7; FALSO)</code>). Esto presentaba tres debilidades críticas en entornos corporativos:</p>
    <ul>
        <li><strong>Incapacidad de buscar hacia la izquierda:</strong> El dato a buscar debía estar obligatoriamente en la primera columna del rango. Si tenías el número de cédula en la columna C y querías extraer el nombre ubicado en la columna A, BUSCARV era completamente inútil.</li>
        <li><strong>Fragilidad ante inserción de columnas:</strong> Si un compañero insertaba una columna nueva en la base de datos, el número índice ''7'' quedaba desfasado, trayendo datos incorrectos en silencio.</li>
        <li><strong>Falta de manejo nativo de errores:</strong> Si el código no existía, devolvía el feo error <code>#N/D</code>, obligando a anidar la función dentro de <code>SI.ERROR()</code>.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-code-square text-success me-2"></i>2. La Sintaxis Quirúrgica de BUSCARX (XLOOKUP)</h4>
    <p>Disponible en Excel para Microsoft 365 y versiones recientes, <strong>BUSCARX</strong> utiliza rangos desacoplados en lugar de matrices fijas:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3">
        <code>=BUSCARX(valor_buscado; matriz_busqueda; matriz_devuelta; [si_no_se_encuentra]; [modo_coincidencia]; [modo_busqueda])</code>
    </div>
    <div class="table-responsive mb-4">
        <table class="table table-bordered table-sm small align-middle">
            <thead class="table-light">
                <tr>
                    <th>Argumento</th>
                    <th>Propósito Práctico</th>
                    <th>Ejemplo en Oficina</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>valor_buscado</code></td>
                    <td>La celda con el código o criterio a rastrear.</td>
                    <td><code>A2</code> (el código de producto <code>PRD-104</code>).</td>
                </tr>
                <tr>
                    <td><code>matriz_busqueda</code></td>
                    <td>La columna exacta donde reside ese código.</td>
                    <td><code>Inventario!$C$2:$C$5000</code></td>
                </tr>
                <tr>
                    <td><code>matriz_devuelta</code></td>
                    <td>La columna que contiene el dato que deseas extraer (¡puede estar a la izquierda o derecha!).</td>
                    <td><code>Inventario!$A$2:$A$5000</code> (columna de Nombres).</td>
                </tr>
                <tr>
                    <td><code>[si_no_se_encuentra]</code></td>
                    <td>El texto a mostrar si el código no existe, sin necesidad de usar SI.ERROR.</td>
                    <td><code>"Artículo No Registrado"</code></td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shuffle text-primary me-2"></i>3. El Dúo Clásico: ÍNDICE y COINCIDIR (Para Versiones Antiguas)</h4>
    <p>Si trabajas en una empresa con computadoras que usan Excel 2016 o 2013, BUSCARX no estará disponible. En ese escenario, el estándar profesional universal es combinar <strong>ÍNDICE</strong> con <strong>COINCIDIR</strong>:</p>
    <div class="card border-0 bg-light p-3 mb-4 rounded-3">
        <p class="small mb-0 font-monospace text-dark">
            <code>=INDICE(Columna_Resultado; COINCIDIR(Valor_Buscado; Columna_Busqueda; 0))</code><br /><br />
            <strong>¿Cómo funciona internamente?</strong><br />
            1. <code>COINCIDIR(A2; C:C; 0)</code> localiza el número de fila exacto donde se encuentra el valor (por ejemplo, fila 42).<br />
            2. <code>INDICE(A:A; 42)</code> va directamente a esa fila en la columna de nombres y extrae el resultado con máxima velocidad computacional.
        </p>
    </div>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Discrepancia en el tamaño de las matrices en BUSCARX:</strong> Si tu <code>matriz_busqueda</code> es de <code>C2:C500</code> (499 filas) pero tu <code>matriz_devuelta</code> es de <code>A2:A600</code> (599 filas), Excel arrojará un error <code>#¡VALOR!</code> inmediato. Ambas columnas deben tener exactamente la misma cantidad de filas.</li>
        <li><strong>Olvidar el cero (0) en COINCIDIR:</strong> Si omites el tercer argumento (<code>0</code> para coincidencia exacta), Excel asumirá coincidencia aproximada, trayendo datos de filas cercanas incorrectos si la lista no está ordenada alfabéticamente.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Reemplazaste BUSCARV por BUSCARX para evitar fallas al insertar columnas en la base de datos?</li>
            <li>¿Definiste el argumento [si_no_se_encuentra] en BUSCARX para mantener tu informe limpio de errores #N/D?</li>
            <li>¿Fijaste con F4 ($) los rangos de búsqueda y retorno al arrastrar fórmulas hacia abajo?</li>
        </ul>
    </div>
</div>', 'Supera las limitaciones históricas de BUSCARV. Domina la función BUSCARX (XLOOKUP) para búsquedas hacia la izquierda, valores predeterminados ante errores y la clásica combinación robusta ÍNDICE y COINCIDIR.', 45, 1, true);
INSERT INTO public."Lessons" VALUES (42, 42, 'Árboles de Decisión Empresarial y Blindaje de Celdas contra Errores de Usuario', 'Reading', '<div class="reading-lesson p-3">
    <div class="alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4">
        <i class="bi bi-diagram-3-fill fs-2 text-info"></i>
        <div>
            <h5 class="fw-bold mb-1">Lógica Condicional: Programar la Inteligencia de tu Negocio en Celdas</h5>
            <p class="mb-0 small">Anidar cinco funciones ''SI'' tradicionales una dentro de otra produce fórmulas kilométricas ilegibles e imposibles de auditar. SI.CONJUNTO simplifica las escalas salariales, comisiones y categorizaciones en una sola línea elegante.</p>
        </div>
    </div>

    <div class="ratio ratio-16x9 rounded-3 shadow-sm mb-4">
        <iframe src="https://www.youtube.com/embed/Ua2gMyITt4g" title="La función SI.CONJUNTO en Excel" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-book-half text-primary me-2"></i>1. La Evolución de la Lógica: De SI() Anidado a SI.CONJUNTO()</h4>
    <p>En análisis de negocios, frecuentemente debemos categorizar registros según múltiples rangos (ej: comisiones por tramos de ventas, calificación de riesgo crediticio o antigüedad de cartera). Antiguamente se escribía:</p>
    <div class="p-2 bg-light rounded font-monospace small mb-2 text-muted">
        <code>=SI(B2>10000; "Excelente"; SI(B2>5000; "Bueno"; SI(B2>2000; "Regular"; "Deficiente")))</code>
    </div>
    <p>Con <strong>SI.CONJUNTO</strong>, la sintaxis opera por pares directos de <code>(Condición; Resultado)</code> que se evalúan de izquierda a derecha. En el instante en que una condición resulta verdadera, Excel devuelve ese valor y detiene la evaluación:</p>
    <div class="p-3 bg-light rounded border font-monospace small mb-3 text-dark">
        <code>=SI.CONJUNTO(B2>=10000; "Excelente"; B2>=5000; "Bueno"; B2>=2000; "Regular"; VERDADERO; "Deficiente")</code>
    </div>
    <p class="small text-muted"><em>Nota clave:</em> El último par <code>VERDADERO; "Deficiente"</code> actúa como la cláusula ''ELSE'' o por defecto: si ninguna de las condiciones anteriores se cumplió, devolverá ''Deficiente''.</p>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-intersect text-primary me-2"></i>2. Evaluación Booleana con Y() y O()</h4>
    <p>Cuando un incentivo comercial exige que se cumplan <strong>dos o más condiciones simultáneamente</strong>, se utiliza la función lógica <code>Y()</code> dentro del SI:</p>
    <ul>
        <li><code>=SI(Y(Ventas>=10000; Cobranza>=95%); "Bono Aprobado"; "Sin Bono")</code>: Exige que el asesor haya vendido más de $10.000 Y ADEMÁS haya recuperado al menos el 95% de la cartera. Si una de las dos falla, no cobra bono.</li>
        <li><code>=SI(O(Antiguedad>5; Desempeno="Sobresaliente"); "Aplica Ascenso"; "En Espera")</code>: La función <code>O()</code> devuelve verdadero si <strong>al menos una</strong> de las dos condiciones se cumple.</li>
    </ul>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-shield-check text-success me-2"></i>3. Blindaje de Celdas con Validación de Datos</h4>
    <p>Si una columna de tu hoja de cálculo se titula ''Estado de Pedido'', permitir que los usuarios escriban libremente provocará que uno escriba ''Entregado'', otro ''entregado'', otro ''ENTREGADA'' y otro ''Despachado''. Esto destruye cualquier tabla dinámica o reporte de Power BI.</p>
    <p>Para garantizar consistencia absoluta, se debe aplicar <strong>Validación de Datos</strong>:</p>
    <ol>
        <li>Seleccionar el rango de celdas a proteger.</li>
        <li>Ir a la pestaña <strong>Datos</strong> y hacer clic en <strong>Validación de datos</strong>.</li>
        <li>En el campo ''Permitir'', seleccionar <strong>Lista</strong>.</li>
        <li>En el campo ''Origen'', escribir los valores permitidos separados por punto y coma (ej: <code>Pendiente; En Tránsito; Entregado; Anulado</code>) o seleccionar un rango de celdas maestro.</li>
        <li>En la pestaña ''Mensaje de error'', configurar estilo <strong>Alto (Stop)</strong> para impedir que el usuario ingrese cualquier texto fuera de la lista oficial.</li>
    </ol>

    <h4 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Alterar el orden de mayor a menor en escalas numéricas:</strong> Si en SI.CONJUNTO colocas primero <code>B2>=2000; "Regular"</code> y luego <code>B2>=10000; "Excelente"</code>, una venta de $15.000 se clasificará como ''Regular'' porque 15.000 es mayor a 2.000 y Excel evalúa en cascada de izquierda a derecha. Siempre ordena tus condiciones numéricas de mayor a menor (o de menor a mayor usando <code><</code>).</li>
        <li><strong>Olvidar comillas en textos dentro de fórmulas:</strong> En Excel, cualquier palabra o texto literal dentro de una función debe ir obligatoriamente entre comillas dobles (<code>"Aprobado"</code>). Si omites las comillas, Excel creerá que es el nombre de una fórmula no existente y arrojará el error <code>#¿NOMBRE?</code>.</li>
    </ul>

    <div class="card border-0 bg-primary text-white p-3 rounded-3 mt-4">
        <h6 class="fw-bold mb-2"><i class="bi bi-check2-all me-2"></i>Checklist de Excelencia Profesional</h6>
        <ul class="mb-0 small">
            <li>¿Estructuraste tus condiciones en SI.CONJUNTO ordenadas rigurosamente de mayor a menor?</li>
            <li>¿Agregaste el cierre VERDADERO al final de SI.CONJUNTO para capturar valores que no cumplen ningún criterio?</li>
            <li>¿Protegiste las columnas críticas de entrada con Listas Desplegables de Validación de Datos?</li>
        </ul>
    </div>
</div>', 'Domina la evaluación lógica en cascada con SI.CONJUNTO. Combina múltiples criterios con Y() y O(), y blinda tus hojas de cálculo con listas desplegables y reglas estrictas de Validación de Datos.', 45, 1, true);


--
-- Data for Name: Payments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: QuizAttempts; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: QuizOptions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."QuizOptions" VALUES (20657, 5165, 'She aren''t at home today.', false);
INSERT INTO public."QuizOptions" VALUES (20658, 5165, 'She isn''t at home today.', true);
INSERT INTO public."QuizOptions" VALUES (20659, 5165, 'She don''t is at home today.', false);
INSERT INTO public."QuizOptions" VALUES (20660, 5165, 'She not is at home today.', false);
INSERT INTO public."QuizOptions" VALUES (20661, 5166, 'He watchs television.', false);
INSERT INTO public."QuizOptions" VALUES (20662, 5166, 'He watches television.', true);
INSERT INTO public."QuizOptions" VALUES (20663, 5166, 'He watchies television.', false);
INSERT INTO public."QuizOptions" VALUES (20664, 5166, 'He watching television.', false);
INSERT INTO public."QuizOptions" VALUES (20665, 5167, 'Únicamente delante de sustantivos en plural.', false);
INSERT INTO public."QuizOptions" VALUES (20666, 5167, 'Delante de palabras que comienzan fonéticamente con sonido vocálico (ej. an apple, an hour).', true);
INSERT INTO public."QuizOptions" VALUES (20667, 5167, 'Solo cuando la palabra comienza con la letra ''s''.', false);
INSERT INTO public."QuizOptions" VALUES (20668, 5167, 'Delante de cualquier adjetivo de color.', false);
INSERT INTO public."QuizOptions" VALUES (20669, 5168, 'El Present Simple describe rutinas y hábitos permanentes, mientras que el Present Continuous describe acciones que ocurren en este preciso momento.', true);
INSERT INTO public."QuizOptions" VALUES (20670, 5168, 'El Present Simple solo se usa en el Reino Unido y el Present Continuous en Estados Unidos.', false);
INSERT INTO public."QuizOptions" VALUES (20671, 5168, 'No hay diferencia, pueden intercambiarse sin alterar el significado.', false);
INSERT INTO public."QuizOptions" VALUES (20672, 5168, 'El Present Continuous solo se utiliza con el pronombre ''I''.', false);
INSERT INTO public."QuizOptions" VALUES (20673, 5169, 'Goed.', false);
INSERT INTO public."QuizOptions" VALUES (20674, 5169, 'Went.', true);
INSERT INTO public."QuizOptions" VALUES (20675, 5169, 'Gone.', false);
INSERT INTO public."QuizOptions" VALUES (20676, 5169, 'Going.', false);
INSERT INTO public."QuizOptions" VALUES (20677, 5170, 'En pasado con terminación ''-ed'' (ej. She didn''t played).', false);
INSERT INTO public."QuizOptions" VALUES (20678, 5170, 'En su forma base infinitivo sin to (ej. She didn''t play).', true);
INSERT INTO public."QuizOptions" VALUES (20679, 5170, 'En participio pasado irregular.', false);
INSERT INTO public."QuizOptions" VALUES (20680, 5170, 'Con la terminación ''-ing''.', false);
INSERT INTO public."QuizOptions" VALUES (20681, 5171, 'Future Simple con ''WILL'' (ej. I will help you).', true);
INSERT INTO public."QuizOptions" VALUES (20682, 5171, 'Be Going To (ej. I am going to help you).', false);
INSERT INTO public."QuizOptions" VALUES (20683, 5171, 'Past Continuous.', false);
INSERT INTO public."QuizOptions" VALUES (20684, 5171, 'Imperativo negativo.', false);
INSERT INTO public."QuizOptions" VALUES (20685, 5172, 'Persons.', false);
INSERT INTO public."QuizOptions" VALUES (20686, 5172, 'People.', true);
INSERT INTO public."QuizOptions" VALUES (20687, 5172, 'Peoples.', false);
INSERT INTO public."QuizOptions" VALUES (20688, 5172, 'Persones.', false);
INSERT INTO public."QuizOptions" VALUES (20689, 5173, 'AT.', false);
INSERT INTO public."QuizOptions" VALUES (20690, 5173, 'IN.', false);
INSERT INTO public."QuizOptions" VALUES (20691, 5173, 'ON.', true);
INSERT INTO public."QuizOptions" VALUES (20692, 5173, 'BY.', false);
INSERT INTO public."QuizOptions" VALUES (20693, 5174, 'Must.', false);
INSERT INTO public."QuizOptions" VALUES (20694, 5174, 'Should.', true);
INSERT INTO public."QuizOptions" VALUES (20695, 5174, 'Can.', false);
INSERT INTO public."QuizOptions" VALUES (20696, 5174, 'Will.', false);
INSERT INTO public."QuizOptions" VALUES (20897, 5225, 'Escribir los títulos y números de página a mano con la barra espaciadora', false);
INSERT INTO public."QuizOptions" VALUES (20898, 5225, 'Aplicar Estilos de Título (Título 1, Título 2) y luego insertar una Tabla de Contenido en Referencias', true);
INSERT INTO public."QuizOptions" VALUES (20899, 5225, 'Insertar una tabla de Excel dentro del documento', false);
INSERT INTO public."QuizOptions" VALUES (20900, 5225, 'Crear una viñeta numerada en la primera página', false);
INSERT INTO public."QuizOptions" VALUES (20901, 5226, 'Con el signo numeral (#)', false);
INSERT INTO public."QuizOptions" VALUES (20902, 5226, 'Con el signo de interrogación (?)', false);
INSERT INTO public."QuizOptions" VALUES (20903, 5226, 'Con el signo igual (=)', true);
INSERT INTO public."QuizOptions" VALUES (20904, 5226, 'Con el signo arroba (@)', false);
INSERT INTO public."QuizOptions" VALUES (20905, 5227, 'Ambas celdas aumentan de fila (C3 * D2)', false);
INSERT INTO public."QuizOptions" VALUES (20906, 5227, 'C2 cambia a C3 pero $D$1 permanece fija porque tiene fijación absoluta', true);
INSERT INTO public."QuizOptions" VALUES (20907, 5227, 'Se produce un error de sintaxis y se borra la fórmula', false);
INSERT INTO public."QuizOptions" VALUES (20908, 5227, '$D$1 cambia pero C2 se queda fija', false);
INSERT INTO public."QuizOptions" VALUES (20909, 5228, '=CONTAR solo cuenta valores numéricos, mientras que =CONTARA cuenta cualquier celda que no esté vacía (texto, números)', true);
INSERT INTO public."QuizOptions" VALUES (20910, 5228, 'Son exactamente la misma función', false);
INSERT INTO public."QuizOptions" VALUES (20911, 5228, '=CONTAR suma dinero y =CONTARA resta gastos', false);
INSERT INTO public."QuizOptions" VALUES (20912, 5228, '=CONTARA solo funciona los fines de semana', false);
INSERT INTO public."QuizOptions" VALUES (20913, 5229, 'Presionar la tecla Enter repetidamente 25 veces', false);
INSERT INTO public."QuizOptions" VALUES (20914, 5229, 'Ctrl + Salto', false);
INSERT INTO public."QuizOptions" VALUES (20915, 5229, 'Ctrl + Enter', true);
INSERT INTO public."QuizOptions" VALUES (20916, 5229, 'Alt + Shift + P', false);
INSERT INTO public."QuizOptions" VALUES (20917, 5230, '=SUMAR(B5 a B20)', false);
INSERT INTO public."QuizOptions" VALUES (20918, 5230, '=SUMA(B5:B20)', true);
INSERT INTO public."QuizOptions" VALUES (20919, 5230, '=B5+B20', false);
INSERT INTO public."QuizOptions" VALUES (20920, 5230, '=TOTAL(B5..B20)', false);
INSERT INTO public."QuizOptions" VALUES (20921, 5231, 'Usar 6 diapositivas por cada 6 minutos', false);
INSERT INTO public."QuizOptions" VALUES (20922, 5231, 'Máximo 6 viñetas por diapositiva y un promedio de 6 palabras por línea para evitar sobrecarga de lectura', true);
INSERT INTO public."QuizOptions" VALUES (20923, 5231, 'Tener 6 tipos de letra diferentes en cada página', false);
INSERT INTO public."QuizOptions" VALUES (20924, 5231, 'Usar solo 6 colores fluorescentes', false);
INSERT INTO public."QuizOptions" VALUES (20925, 5232, 'El archivo tiene un virus informático grave', false);
INSERT INTO public."QuizOptions" VALUES (20926, 5232, 'El ancho de la columna es insuficiente para desplegar el número; se soluciona ampliando el ancho de la columna', true);
INSERT INTO public."QuizOptions" VALUES (20927, 5232, 'La fórmula contiene un error ortográfico en el nombre', false);
INSERT INTO public."QuizOptions" VALUES (20928, 5232, 'Se introdujo una división entre cero', false);
INSERT INTO public."QuizOptions" VALUES (20929, 5233, 'WordArt', false);
INSERT INTO public."QuizOptions" VALUES (20930, 5233, 'SmartArt', true);
INSERT INTO public."QuizOptions" VALUES (20931, 5233, 'ClipArt', false);
INSERT INTO public."QuizOptions" VALUES (20932, 5233, 'PaintBrush', false);
INSERT INTO public."QuizOptions" VALUES (20933, 5234, 'Archivo de texto plano (.txt)', false);
INSERT INTO public."QuizOptions" VALUES (20934, 5234, 'Documento PDF (.pdf)', true);
INSERT INTO public."QuizOptions" VALUES (20935, 5234, 'Imagen BMP (.bmp)', false);
INSERT INTO public."QuizOptions" VALUES (20936, 5234, 'Página Web (.html)', false);
INSERT INTO public."QuizOptions" VALUES (20937, 5235, 'Permite buscar datos hacia la izquierda, no requiere indicar un índice de columna numérico y tiene manejo de errores nativo', true);
INSERT INTO public."QuizOptions" VALUES (20938, 5235, 'Solo funciona en computadoras con procesadores de última generación', false);
INSERT INTO public."QuizOptions" VALUES (20939, 5235, 'No requiere escribir el signo igual (=)', false);
INSERT INTO public."QuizOptions" VALUES (20940, 5235, 'Es una función exclusiva para imprimir documentos', false);
INSERT INTO public."QuizOptions" VALUES (20941, 5236, 'Indica que se sume cero al resultado', false);
INSERT INTO public."QuizOptions" VALUES (20942, 5236, 'Fuerza una coincidencia exacta del valor buscado', true);
INSERT INTO public."QuizOptions" VALUES (20943, 5236, 'Significa que la búsqueda se realice en segundo plano', false);
INSERT INTO public."QuizOptions" VALUES (20944, 5236, 'Borra el valor si no existe', false);
INSERT INTO public."QuizOptions" VALUES (20945, 5237, '=SI.CONJUNTO() (IFS)', true);
INSERT INTO public."QuizOptions" VALUES (20946, 5237, '=SUMAR.SI()', false);
INSERT INTO public."QuizOptions" VALUES (20947, 5237, '=CONTAR.BLANCO()', false);
INSERT INTO public."QuizOptions" VALUES (20948, 5237, '=REPETIR()', false);
INSERT INTO public."QuizOptions" VALUES (20949, 5238, 'Filtros', false);
INSERT INTO public."QuizOptions" VALUES (20950, 5238, 'Columnas', false);
INSERT INTO public."QuizOptions" VALUES (20951, 5238, 'Filas', false);
INSERT INTO public."QuizOptions" VALUES (20952, 5238, 'Valores', true);
INSERT INTO public."QuizOptions" VALUES (20953, 5239, '.docx', false);
INSERT INTO public."QuizOptions" VALUES (20954, 5239, '.xlsx', false);
INSERT INTO public."QuizOptions" VALUES (20955, 5239, '.xlsm (Libro de Excel habilitado para macros)', true);
INSERT INTO public."QuizOptions" VALUES (20956, 5239, '.csv', false);
INSERT INTO public."QuizOptions" VALUES (20957, 5240, 'WordPad', false);
INSERT INTO public."QuizOptions" VALUES (20958, 5240, 'Power Query', true);
INSERT INTO public."QuizOptions" VALUES (20959, 5240, 'ClipArt', false);
INSERT INTO public."QuizOptions" VALUES (20960, 5240, 'Buscador de Fuentes', false);
INSERT INTO public."QuizOptions" VALUES (20961, 5241, 'Ctrl + Alt + Supr', false);
INSERT INTO public."QuizOptions" VALUES (20962, 5241, 'Alt + F11', true);
INSERT INTO public."QuizOptions" VALUES (20963, 5241, 'Shift + F4', false);
INSERT INTO public."QuizOptions" VALUES (20964, 5241, 'Ctrl + P', false);
INSERT INTO public."QuizOptions" VALUES (20965, 5242, '=O(Ciudad="Caracas", Compras>1000)', false);
INSERT INTO public."QuizOptions" VALUES (20966, 5242, '=Y(Ciudad="Caracas", Compras>1000)', true);
INSERT INTO public."QuizOptions" VALUES (20967, 5242, '=NO(Ciudad="Caracas")', false);
INSERT INTO public."QuizOptions" VALUES (20968, 5242, '=SUMA(Ciudad, Compras)', false);
INSERT INTO public."QuizOptions" VALUES (20969, 5243, 'Segmentador de Datos (Slicer)', true);
INSERT INTO public."QuizOptions" VALUES (20970, 5243, 'Marca de agua', false);
INSERT INTO public."QuizOptions" VALUES (20971, 5243, 'WordArt', false);
INSERT INTO public."QuizOptions" VALUES (20972, 5243, 'Comentario de celda', false);
INSERT INTO public."QuizOptions" VALUES (20973, 5244, 'Busca archivos perdidos en el disco duro', false);
INSERT INTO public."QuizOptions" VALUES (20974, 5244, 'Calcula el valor que debe tener una variable de entrada para alcanzar un resultado deseado en la fórmula final', true);
INSERT INTO public."QuizOptions" VALUES (20975, 5244, 'Cambia el color de la hoja de cálculo', false);
INSERT INTO public."QuizOptions" VALUES (20976, 5244, 'Envía un correo electrónico al cliente', false);
INSERT INTO public."QuizOptions" VALUES (20977, 5245, 'Modelo en Copo de Nieve infinito', false);
INSERT INTO public."QuizOptions" VALUES (20978, 5245, 'Esquema en Estrella (Star Schema)', true);
INSERT INTO public."QuizOptions" VALUES (20979, 5245, 'Una sola tabla plana con 80 columnas desnormalizadas', false);
INSERT INTO public."QuizOptions" VALUES (20980, 5245, 'Modelo circular sin relaciones', false);
INSERT INTO public."QuizOptions" VALUES (20981, 5246, 'Las Medidas se calculan dinámicamente en tiempo de ejecución sin inflar el tamaño de la memoria RAM del archivo', true);
INSERT INTO public."QuizOptions" VALUES (20982, 5246, 'Las Columnas Calculadas son siempre más rápidas que las medidas', false);
INSERT INTO public."QuizOptions" VALUES (20983, 5246, 'Las medidas solo funcionan con texto', false);
INSERT INTO public."QuizOptions" VALUES (20984, 5246, 'No existe ninguna diferencia', false);
INSERT INTO public."QuizOptions" VALUES (20985, 5247, '=SUM()', false);
INSERT INTO public."QuizOptions" VALUES (20986, 5247, '=AVERAGE()', false);
INSERT INTO public."QuizOptions" VALUES (20987, 5247, '=CALCULATE()', true);
INSERT INTO public."QuizOptions" VALUES (20988, 5247, '=COUNTROWS()', false);
INSERT INTO public."QuizOptions" VALUES (20989, 5248, 'Power Query Editor', true);
INSERT INTO public."QuizOptions" VALUES (20990, 5248, 'Microsoft Outlook', false);
INSERT INTO public."QuizOptions" VALUES (20991, 5248, 'DirectShow', false);
INSERT INTO public."QuizOptions" VALUES (20992, 5248, 'Paint 3D', false);
INSERT INTO public."QuizOptions" VALUES (20993, 5249, 'Muchos a Muchos (*:*)', false);
INSERT INTO public."QuizOptions" VALUES (20994, 5249, 'Uno a Varios (1:*)', true);
INSERT INTO public."QuizOptions" VALUES (20995, 5249, 'Ninguna relación', false);
INSERT INTO public."QuizOptions" VALUES (20996, 5249, 'Cero a Cero (0:0)', false);
INSERT INTO public."QuizOptions" VALUES (20997, 5250, '=RELATED()', true);
INSERT INTO public."QuizOptions" VALUES (20998, 5250, '=VLOOKUP()', false);
INSERT INTO public."QuizOptions" VALUES (20999, 5250, '=IMPORT()', false);
INSERT INTO public."QuizOptions" VALUES (21000, 5250, '=TRAER()', false);
INSERT INTO public."QuizOptions" VALUES (21001, 5251, 'Porque gastan demasiada batería', false);
INSERT INTO public."QuizOptions" VALUES (21002, 5251, 'Porque el ojo humano tiene dificultades para comparar ángulos y áreas similares con precisión, siendo mucho más efectivo un gráfico de barras', true);
INSERT INTO public."QuizOptions" VALUES (21003, 5251, 'Porque Power BI no permite crearlos', false);
INSERT INTO public."QuizOptions" VALUES (21004, 5251, 'Porque están prohibidos por ley', false);
INSERT INTO public."QuizOptions" VALUES (21005, 5252, 'Para que el informe muestre la hora actual', false);
INSERT INTO public."QuizOptions" VALUES (21006, 5252, 'Para habilitar funciones de Inteligencia de Tiempo (Time Intelligence) como comparativas Año contra Año (YoY) o acumulados del año (YTD)', true);
INSERT INTO public."QuizOptions" VALUES (21007, 5252, 'Para programar alarmas de despertador', false);
INSERT INTO public."QuizOptions" VALUES (21008, 5252, 'Es obligatoria solo si la empresa abre en días feriados', false);
INSERT INTO public."QuizOptions" VALUES (21009, 5253, 'Gráfico de Dispersión', false);
INSERT INTO public."QuizOptions" VALUES (21010, 5253, 'Tarjeta de KPI', true);
INSERT INTO public."QuizOptions" VALUES (21011, 5253, 'Mapa de formas', false);
INSERT INTO public."QuizOptions" VALUES (21012, 5253, 'Nube de palabras', false);
INSERT INTO public."QuizOptions" VALUES (21013, 5254, 'Enviando una foto por WhatsApp', false);
INSERT INTO public."QuizOptions" VALUES (21014, 5254, 'Publicándolo en el Servicio en la Nube de Power BI (Power BI Service) en un área de trabajo protegida con permisos por rol', true);
INSERT INTO public."QuizOptions" VALUES (21015, 5254, 'Tomando captura de pantalla e imprimiéndola en papel térmico', false);
INSERT INTO public."QuizOptions" VALUES (21016, 5254, 'Subiéndolo a una red social pública', false);
INSERT INTO public."QuizOptions" VALUES (21017, 5255, 'WHERE filtra filas individuales antes del agrupamiento, mientras que HAVING filtra los resultados agregados después del GROUP BY', true);
INSERT INTO public."QuizOptions" VALUES (21018, 5255, 'WHERE solo funciona en MySQL y HAVING solo en PostgreSQL', false);
INSERT INTO public."QuizOptions" VALUES (21019, 5255, 'Son sinónimos intercambiables en cualquier parte de la consulta', false);
INSERT INTO public."QuizOptions" VALUES (21020, 5255, 'HAVING solo se usa para fechas', false);
INSERT INTO public."QuizOptions" VALUES (21021, 5256, 'INNER JOIN', false);
INSERT INTO public."QuizOptions" VALUES (21022, 5256, 'LEFT JOIN (o LEFT OUTER JOIN)', true);
INSERT INTO public."QuizOptions" VALUES (21023, 5256, 'CROSS JOIN', false);
INSERT INTO public."QuizOptions" VALUES (21024, 5256, 'FULL JOIN', false);
INSERT INTO public."QuizOptions" VALUES (21025, 5257, 'Series', false);
INSERT INTO public."QuizOptions" VALUES (21026, 5257, 'DataFrame', true);
INSERT INTO public."QuizOptions" VALUES (21027, 5257, 'Tupla', false);
INSERT INTO public."QuizOptions" VALUES (21028, 5257, 'Matriz escalar', false);
INSERT INTO public."QuizOptions" VALUES (21029, 5258, 'df.pivot()', false);
INSERT INTO public."QuizOptions" VALUES (21030, 5258, 'df.groupby()', true);
INSERT INTO public."QuizOptions" VALUES (21031, 5258, 'df.sort_values()', false);
INSERT INTO public."QuizOptions" VALUES (21032, 5258, 'df.head()', false);
INSERT INTO public."QuizOptions" VALUES (21033, 5259, 'Dibujar un logotipo tridimensional', false);
INSERT INTO public."QuizOptions" VALUES (21034, 5259, 'Identificar visualmente la dispersión, la mediana, los cuartiles y los valores atípicos (outliers)', true);
INSERT INTO public."QuizOptions" VALUES (21035, 5259, 'Graficar coordenadas satelitales', false);
INSERT INTO public."QuizOptions" VALUES (21036, 5259, 'Contar palabras en un texto', false);
INSERT INTO public."QuizOptions" VALUES (21037, 5260, 'Para que el archivo pese la mitad', false);
INSERT INTO public."QuizOptions" VALUES (21038, 5260, 'Para evitar el sobreajuste (overfitting) y validar cómo se comporta el modelo frente a datos nuevos que nunca vio', true);
INSERT INTO public."QuizOptions" VALUES (21039, 5260, 'Porque Python no permite entrenar con más de 100 datos', false);
INSERT INTO public."QuizOptions" VALUES (21040, 5260, 'Es una norma opcional de diseño', false);
INSERT INTO public."QuizOptions" VALUES (21041, 5261, 'Scikit-Learn (sklearn)', true);
INSERT INTO public."QuizOptions" VALUES (21042, 5261, 'PyGame', false);
INSERT INTO public."QuizOptions" VALUES (21043, 5261, 'Tkinter', false);
INSERT INTO public."QuizOptions" VALUES (21044, 5261, 'Requests', false);
INSERT INTO public."QuizOptions" VALUES (21045, 5262, 'Existe una correlación lineal positiva muy fuerte: al aumentar una variable, la otra tiende a aumentar en proporción similar', true);
INSERT INTO public."QuizOptions" VALUES (21046, 5262, 'No existe ninguna relación entre las variables', false);
INSERT INTO public."QuizOptions" VALUES (21047, 5262, 'Existe una relación inversa negativa perfecta', false);
INSERT INTO public."QuizOptions" VALUES (21048, 5262, 'Los datos están corruptos', false);
INSERT INTO public."QuizOptions" VALUES (21049, 5263, 'SUM()', false);
INSERT INTO public."QuizOptions" VALUES (21050, 5263, 'MEDIAN()', false);
INSERT INTO public."QuizOptions" VALUES (21051, 5263, 'AVG()', true);
INSERT INTO public."QuizOptions" VALUES (21052, 5263, 'TOTAL()', false);
INSERT INTO public."QuizOptions" VALUES (21053, 5264, 'Un caso negativo que el modelo predijo erróneamente como positivo', true);
INSERT INTO public."QuizOptions" VALUES (21054, 5264, 'Un caso positivo clasificado correctamente', false);
INSERT INTO public."QuizOptions" VALUES (21055, 5264, 'Un dato borrado de la base de datos', false);
INSERT INTO public."QuizOptions" VALUES (21056, 5264, 'Un error de conexión a internet', false);
INSERT INTO public."QuizOptions" VALUES (21057, 5265, 'Combinación de Correspondencia (Mail Merge)', true);
INSERT INTO public."QuizOptions" VALUES (21058, 5265, 'Control de Cambios', false);
INSERT INTO public."QuizOptions" VALUES (21059, 5265, 'AutoCorrección', false);
INSERT INTO public."QuizOptions" VALUES (21060, 5265, 'Buscador de Sinónimos', false);
INSERT INTO public."QuizOptions" VALUES (21061, 5266, '=SUMAR.SI()', false);
INSERT INTO public."QuizOptions" VALUES (21062, 5266, '=SUMAR.SI.CONJUNTO()', true);
INSERT INTO public."QuizOptions" VALUES (21063, 5266, '=CONTAR.SI()', false);
INSERT INTO public."QuizOptions" VALUES (21064, 5266, '=TOTAL.CONDICIONADO()', false);
INSERT INTO public."QuizOptions" VALUES (21065, 5267, 'Gráficos pequeños que se dibujan e incrustan dentro de una sola celda para mostrar tendencias visuales compactas', true);
INSERT INTO public."QuizOptions" VALUES (21066, 5267, 'Gráficos que solo se imprimen en papel pequeño', false);
INSERT INTO public."QuizOptions" VALUES (21067, 5267, 'Un tipo de virus informático', false);
INSERT INTO public."QuizOptions" VALUES (21068, 5267, 'Archivos de imagen externos', false);
INSERT INTO public."QuizOptions" VALUES (21069, 5268, 'Borra todo el texto de la presentación', false);
INSERT INTO public."QuizOptions" VALUES (21070, 5268, 'Reconoce objetos comunes entre diapositivas y crea una animación fluida de movimiento, tamaño y posición', true);
INSERT INTO public."QuizOptions" VALUES (21071, 5268, 'Convierte la diapositiva en un archivo de Word', false);
INSERT INTO public."QuizOptions" VALUES (21072, 5268, 'Cambia el idioma del teclado', false);
INSERT INTO public."QuizOptions" VALUES (21073, 5269, '=CONTAR.SI evalúa un único criterio, mientras que =CONTAR.SI.CONJUNTO permite evaluar múltiples criterios simultáneos', true);
INSERT INTO public."QuizOptions" VALUES (21074, 5269, 'Son exactamente lo mismo', false);
INSERT INTO public."QuizOptions" VALUES (21075, 5269, '=CONTAR.SI solo cuenta números negativos', false);
INSERT INTO public."QuizOptions" VALUES (21076, 5269, '=CONTAR.SI.CONJUNTO no admite texto', false);
INSERT INTO public."QuizOptions" VALUES (21077, 5270, '=UNIRCADENAS() (TEXTJOIN)', true);
INSERT INTO public."QuizOptions" VALUES (21078, 5270, '=SUMA()', false);
INSERT INTO public."QuizOptions" VALUES (21079, 5270, '=BUSCAR()', false);
INSERT INTO public."QuizOptions" VALUES (21080, 5270, '=TEXTO.SEPARADO()', false);
INSERT INTO public."QuizOptions" VALUES (21081, 5271, 'Para cambiar el color del fondo de la página', false);
INSERT INTO public."QuizOptions" VALUES (21082, 5271, 'Para registrar, marcar y visualizar todas las ediciones, eliminaciones y sugerencias hechas por diferentes revisores', true);
INSERT INTO public."QuizOptions" VALUES (21083, 5271, 'Para borrar el historial de guardado', false);
INSERT INTO public."QuizOptions" VALUES (21084, 5271, 'Para traducir el documento a código binario', false);
INSERT INTO public."QuizOptions" VALUES (21085, 5272, 'Desbloquear las celdas de entrada en Formato de Celdas y luego activar ''Proteger Hoja''', true);
INSERT INTO public."QuizOptions" VALUES (21086, 5272, 'Ponerle contraseña a la computadora', false);
INSERT INTO public."QuizOptions" VALUES (21087, 5272, 'Borrar las fórmulas antes de enviar el archivo', false);
INSERT INTO public."QuizOptions" VALUES (21088, 5272, 'Guardar la hoja como imagen estática', false);
INSERT INTO public."QuizOptions" VALUES (21089, 5273, 'Gráfico de Dispersión XY', false);
INSERT INTO public."QuizOptions" VALUES (21090, 5273, 'Gráfico Circular o de Anillo (con pocas categorías)', true);
INSERT INTO public."QuizOptions" VALUES (21091, 5273, 'Gráfico de Cotizaciones', false);
INSERT INTO public."QuizOptions" VALUES (21092, 5273, 'Gráfico de Radar', false);
INSERT INTO public."QuizOptions" VALUES (21093, 5274, 'Apaga el monitor del expositor', false);
INSERT INTO public."QuizOptions" VALUES (21094, 5274, 'Permite al expositor ver sus notas privadas, el tiempo transcurrido y la siguiente diapositiva mientras la audiencia solo ve la presentación actual', true);
INSERT INTO public."QuizOptions" VALUES (21095, 5274, 'Graba la voz del público sin permiso', false);
INSERT INTO public."QuizOptions" VALUES (21096, 5274, 'Obliga a la audiencia a responder encuestas', false);
INSERT INTO public."QuizOptions" VALUES (21097, 5275, 'Rol, Tarea, Formato y Restricciones', true);
INSERT INTO public."QuizOptions" VALUES (21098, 5275, 'Rápido, Temprano, Fácil y Repetitivo', false);
INSERT INTO public."QuizOptions" VALUES (21099, 5275, 'Ratón, Teclado, Fuente y Red', false);
INSERT INTO public."QuizOptions" VALUES (21100, 5275, 'Registro, Tiempo, Firma y Revisión', false);
INSERT INTO public."QuizOptions" VALUES (21101, 5276, 'Escribir el prompt en menos de 5 palabras', false);
INSERT INTO public."QuizOptions" VALUES (21102, 5276, 'Proporcionar al modelo algunos ejemplos previos de entrada y salida esperada para que aprenda el patrón y tono deseado', true);
INSERT INTO public."QuizOptions" VALUES (21103, 5276, 'Apagar y encender el computador antes de consultar', false);
INSERT INTO public."QuizOptions" VALUES (21104, 5276, 'Usar la IA solo en las mañanas', false);
INSERT INTO public."QuizOptions" VALUES (21105, 5277, 'Hace que el modelo se bloquee por completo', false);
INSERT INTO public."QuizOptions" VALUES (21106, 5277, 'Descompone el razonamiento en pasos lógicos intermedios, reduciendo drásticamente errores en cálculos y deducciones complejas', true);
INSERT INTO public."QuizOptions" VALUES (21107, 5277, 'Borra el historial de la cuenta', false);
INSERT INTO public."QuizOptions" VALUES (21108, 5277, 'Cambia el idioma a inglés británico', false);
INSERT INTO public."QuizOptions" VALUES (21109, 5278, 'Un virus informático que infecta el navegador', false);
INSERT INTO public."QuizOptions" VALUES (21110, 5278, 'Cuando el modelo genera afirmaciones falsas, datos inventados o citas inexistentes con total seguridad y tono convincente', true);
INSERT INTO public."QuizOptions" VALUES (21111, 5278, 'Una imagen con colores brillantes generada por la IA', false);
INSERT INTO public."QuizOptions" VALUES (21112, 5278, 'Un fallo en la tarjeta de video', false);
INSERT INTO public."QuizOptions" VALUES (21113, 5279, 'Pedirle que redacte una felicitación de cumpleaños genérica', false);
INSERT INTO public."QuizOptions" VALUES (21114, 5279, 'Copiar y pegar una base de datos con nombres, cédulas, teléfonos y salarios reales de los empleados de la empresa', true);
INSERT INTO public."QuizOptions" VALUES (21115, 5279, 'Consultar la definición de un término contable estándar', false);
INSERT INTO public."QuizOptions" VALUES (21116, 5279, 'Solicitar un sinónimo de una palabra en español', false);
INSERT INTO public."QuizOptions" VALUES (21117, 5280, 'Anonimización: reemplazar nombres reales, cuentas bancarias y razones sociales por identificadores ficticios (ej. Cliente A, Empresa X)', true);
INSERT INTO public."QuizOptions" VALUES (21118, 5280, 'Escribir todo en letras mayúsculas', false);
INSERT INTO public."QuizOptions" VALUES (21119, 5280, 'Traducir los datos al latín', false);
INSERT INTO public."QuizOptions" VALUES (21120, 5280, 'Eliminar todas las vocales del texto', false);
INSERT INTO public."QuizOptions" VALUES (21121, 5281, 'No necesita conexión a internet', false);
INSERT INTO public."QuizOptions" VALUES (21122, 5281, 'Su ventana de contexto masiva de hasta 1 a 2 millones de tokens, capaz de procesar manuales técnicos enteros, videos o PDFs de cientos de páginas de una sola vez', true);
INSERT INTO public."QuizOptions" VALUES (21123, 5281, 'Es la única IA que habla español', false);
INSERT INTO public."QuizOptions" VALUES (21124, 5281, 'Solo funciona en teléfonos móviles', false);
INSERT INTO public."QuizOptions" VALUES (21125, 5282, 'Un poema en verso alejandrino', false);
INSERT INTO public."QuizOptions" VALUES (21126, 5282, 'Una tabla comparativa en formato Markdown con columnas de precio, plazo de entrega, garantías y veredicto sugerido', true);
INSERT INTO public."QuizOptions" VALUES (21127, 5282, 'Un archivo de audio en código Morse', false);
INSERT INTO public."QuizOptions" VALUES (21128, 5282, 'Un solo párrafo de 800 palabras continuas sin puntos', false);
INSERT INTO public."QuizOptions" VALUES (21129, 5283, 'Porque la IA se siente ofendida', false);
INSERT INTO public."QuizOptions" VALUES (21130, 5283, 'Porque los modelos responden mucho mejor a instrucciones positivas directas sobre qué estilo adoptar (ej: ''Usa un tono corporativo dinámico y vocabulario accesible'')', true);
INSERT INTO public."QuizOptions" VALUES (21131, 5283, 'Porque la palabra ''No'' desactiva el servidor', false);
INSERT INTO public."QuizOptions" VALUES (21132, 5283, 'No tiene ningún impacto en la respuesta', false);
INSERT INTO public."QuizOptions" VALUES (21133, 5284, 'Creer ciegamente en el resultado y aplicarlo en la base de datos principal de producción', false);
INSERT INTO public."QuizOptions" VALUES (21134, 5284, 'Verificar y probar la fórmula o código en un entorno de pruebas o con datos de muestra para constatar que devuelve los resultados correctos', true);
INSERT INTO public."QuizOptions" VALUES (21135, 5284, 'Imprimir el código en papel y guardarlo en una gaveta', false);
INSERT INTO public."QuizOptions" VALUES (21136, 5284, 'Eliminar la copia de respaldo de la base de datos', false);
INSERT INTO public."QuizOptions" VALUES (21137, 5285, 'Confidencialidad, Integridad y Disponibilidad', true);
INSERT INTO public."QuizOptions" VALUES (21138, 5285, 'Computadoras, Internet y Antivirus', false);
INSERT INTO public."QuizOptions" VALUES (21139, 5285, 'Control, Inspección y Auditoría', false);
INSERT INTO public."QuizOptions" VALUES (21140, 5285, 'Cables, Interruptores y Adaptadores', false);
INSERT INTO public."QuizOptions" VALUES (21141, 5286, 'Un software para acelerar la velocidad de descarga', false);
INSERT INTO public."QuizOptions" VALUES (21142, 5286, 'Una técnica de ingeniería social donde el atacante suplanta la identidad de una entidad legítima (banco, jefe, proveedor) mediante correos o mensajes engañosos para robar credenciales', true);
INSERT INTO public."QuizOptions" VALUES (21143, 5286, 'La compra legal de dominios en internet', false);
INSERT INTO public."QuizOptions" VALUES (21144, 5286, 'Un protocolo de red para conectar impresoras', false);
INSERT INTO public."QuizOptions" VALUES (21145, 5287, 'Porque hace que la computadora no consuma electricidad', false);
INSERT INTO public."QuizOptions" VALUES (21146, 5287, 'Porque requiere un segundo factor independiente (como un código temporal en tu teléfono móvil) que el atacante no posee aunque robe tu contraseña', true);
INSERT INTO public."QuizOptions" VALUES (21147, 5287, 'Porque cambia la clave cada 10 segundos automáticamente sin avisar', false);
INSERT INTO public."QuizOptions" VALUES (21148, 5287, 'Solo es obligatoria para ingenieros de sistemas', false);
INSERT INTO public."QuizOptions" VALUES (21149, 5288, 'Formatea la pantalla con colores fosforescentes', false);
INSERT INTO public."QuizOptions" VALUES (21150, 5288, 'Cifra (bloquea matemáticamente) los archivos, bases de datos y discos duros del servidor, exigiendo el pago de un rescate financiero para recuperar la clave de descifrado', true);
INSERT INTO public."QuizOptions" VALUES (21151, 5288, 'Apaga el aire acondicionado del edificio', false);
INSERT INTO public."QuizOptions" VALUES (21152, 5288, 'Disminuye la resolución de las fotos de perfil', false);
INSERT INTO public."QuizOptions" VALUES (21153, 5289, 'Tener 3 copias de los datos, en 2 medios de almacenamiento distintos, con al menos 1 copia fuera de las instalaciones físicas (en la nube o sitio remoto)', true);
INSERT INTO public."QuizOptions" VALUES (21154, 5289, 'Hacer copias los días 3, 2 y 1 de cada mes', false);
INSERT INTO public."QuizOptions" VALUES (21155, 5289, 'Usar solo 3 contraseñas de 2 dígitos y 1 símbolo', false);
INSERT INTO public."QuizOptions" VALUES (21156, 5289, 'Hacer 3 clics cada 2 minutos en 1 archivo', false);
INSERT INTO public."QuizOptions" VALUES (21157, 5290, 'Que la batería del portátil se dañe físicamente', false);
INSERT INTO public."QuizOptions" VALUES (21158, 5290, 'Ataques de intercepción de tráfico (Man-in-the-Middle) donde terceros maliciosos en la misma red capturan cookies de sesión y datos transmitidos', true);
INSERT INTO public."QuizOptions" VALUES (21159, 5290, 'Que el teclado se desconfigure de idioma', false);
INSERT INTO public."QuizOptions" VALUES (21160, 5290, 'No existe ningún riesgo si el café es formal', false);
INSERT INTO public."QuizOptions" VALUES (21161, 5291, 'Que la página web es 100% honesta y nunca intentará estafarte', false);
INSERT INTO public."QuizOptions" VALUES (21162, 5291, 'Que la comunicación entre tu navegador y el servidor está cifrada mediante certificados SSL/TLS, impidiendo que terceros lean los datos en tránsito', true);
INSERT INTO public."QuizOptions" VALUES (21163, 5291, 'Que la página pertenece al gobierno nacional', false);
INSERT INTO public."QuizOptions" VALUES (21164, 5291, 'Que la computadora tiene antivirus instalado', false);
INSERT INTO public."QuizOptions" VALUES (21165, 5292, 'Anotarlas en un papel adhesivo pegado en el marco del monitor', false);
INSERT INTO public."QuizOptions" VALUES (21166, 5292, 'Utilizar la misma contraseña sencilla para todas las cuentas personales y laborales', false);
INSERT INTO public."QuizOptions" VALUES (21167, 5292, 'Utilizar un Gestor de Contraseñas seguro con cifrado de conocimiento cero (Zero-Knowledge) protegido por una frase maestra fuerte', true);
INSERT INTO public."QuizOptions" VALUES (21168, 5292, 'Guardarlas en un bloc de notas sin clave en el escritorio', false);
INSERT INTO public."QuizOptions" VALUES (21169, 5293, 'Dársela de inmediato para evitar que te bloqueen', false);
INSERT INTO public."QuizOptions" VALUES (21170, 5293, 'Negarse rotundamente a divulgar la contraseña, colgar y validar directamente a través de los canales internos oficiales de soporte técnico (Ingeniería Social / Vishing)', true);
INSERT INTO public."QuizOptions" VALUES (21171, 5293, 'Darle la contraseña de tu compañero de trabajo', false);
INSERT INTO public."QuizOptions" VALUES (21172, 5293, 'Publicarla en el grupo de WhatsApp', false);
INSERT INTO public."QuizOptions" VALUES (21173, 5294, 'Un cable físico muy largo que llega a la casa del empleado', false);
INSERT INTO public."QuizOptions" VALUES (21174, 5294, 'Un túnel de comunicación cifrado que protege los datos transmitidos a través de internet y permite acceder a los servidores de la empresa como si estuvieras en la red local', true);
INSERT INTO public."QuizOptions" VALUES (21175, 5294, 'Un tipo de monitor de pantalla curva', false);
INSERT INTO public."QuizOptions" VALUES (21176, 5294, 'Un software para ver canales de televisión por suscripción', false);
INSERT INTO public."QuizOptions" VALUES (21177, 5295, 'Blanco-Naranja, Naranja, Blanco-Verde, Azul, Blanco-Azul, Verde, Blanco-Marrón, Marrón', true);
INSERT INTO public."QuizOptions" VALUES (21178, 5295, 'Blanco-Verde, Verde, Blanco-Naranja, Azul, Blanco-Azul, Naranja, Blanco-Marrón, Marrón', false);
INSERT INTO public."QuizOptions" VALUES (21179, 5295, 'Azul, Blanco-Azul, Verde, Blanco-Verde, Marrón, Blanco-Marrón, Naranja, Blanco-Naranja', false);
INSERT INTO public."QuizOptions" VALUES (21180, 5295, 'Todos los cables blancos primero y luego los de color sólido', false);
INSERT INTO public."QuizOptions" VALUES (21181, 5296, 'El mouse de un pasante tiene el cable un poco sucio', false);
INSERT INTO public."QuizOptions" VALUES (21182, 5296, 'Una falla general que detiene la operación medular del negocio (ej. servidor de facturación caído o falla en todas las cajas de cobro)', true);
INSERT INTO public."QuizOptions" VALUES (21183, 5296, 'Un usuario olvidó la clave de su cuenta de red social personal', false);
INSERT INTO public."QuizOptions" VALUES (21184, 5296, 'El protector de pantalla de la recepción no se activa', false);
INSERT INTO public."QuizOptions" VALUES (21185, 5297, 'Porque el alcohol medicinal huele más fuerte', false);
INSERT INTO public."QuizOptions" VALUES (21186, 5297, 'Porque el alcohol medicinal contiene agua y aditivos que oxidan los circuitos metálicos y provocan cortocircuitos al secar', true);
INSERT INTO public."QuizOptions" VALUES (21187, 5297, 'Porque el alcohol isopropílico es más dulce', false);
INSERT INTO public."QuizOptions" VALUES (21188, 5297, 'Ambos alcoholes son idénticos para electrónica', false);
INSERT INTO public."QuizOptions" VALUES (21189, 5298, 'dir /s', false);
INSERT INTO public."QuizOptions" VALUES (21190, 5298, 'ping [dirección_ip]', true);
INSERT INTO public."QuizOptions" VALUES (21191, 5298, 'format c:', false);
INSERT INTO public."QuizOptions" VALUES (21192, 5298, 'cls', false);
INSERT INTO public."QuizOptions" VALUES (21193, 5299, 'El monitor no tiene enchufe', false);
INSERT INTO public."QuizOptions" VALUES (21194, 5299, 'Falla de contacto o daño en los módulos de memoria RAM', true);
INSERT INTO public."QuizOptions" VALUES (21195, 5299, 'El teclado no tiene pilas', false);
INSERT INTO public."QuizOptions" VALUES (21196, 5299, 'La alfombrilla del mouse está desalineada', false);
INSERT INTO public."QuizOptions" VALUES (21197, 5300, 'Pegar el procesador para que nunca se pueda sacar', false);
INSERT INTO public."QuizOptions" VALUES (21198, 5300, 'Rellenar las microscópicas imperfecciones del aire para maximizar la transferencia de calor del CPU hacia el disipador', true);
INSERT INTO public."QuizOptions" VALUES (21199, 5300, 'Aislar la corriente eléctrica', false);
INSERT INTO public."QuizOptions" VALUES (21200, 5300, 'Aumentar la velocidad del disco duro', false);
INSERT INTO public."QuizOptions" VALUES (21201, 5301, 'Windows Media Player', false);
INSERT INTO public."QuizOptions" VALUES (21202, 5301, 'Rufus', true);
INSERT INTO public."QuizOptions" VALUES (21203, 5301, 'Notepad++', false);
INSERT INTO public."QuizOptions" VALUES (21204, 5301, 'VLC Media Player', false);
INSERT INTO public."QuizOptions" VALUES (21205, 5302, 'ipconfig', true);
INSERT INTO public."QuizOptions" VALUES (21206, 5302, 'netstat', false);
INSERT INTO public."QuizOptions" VALUES (21207, 5302, 'hostname', false);
INSERT INTO public."QuizOptions" VALUES (21208, 5302, 'tasklist', false);
INSERT INTO public."QuizOptions" VALUES (21209, 5303, 'Para que no gasten tinta', false);
INSERT INTO public."QuizOptions" VALUES (21210, 5303, 'Para evitar que el router les cambie la IP al reiniciarse, lo que provocaría que las computadoras de cobro pierdan la conexión con la impresora o el sistema de vigilancia', true);
INSERT INTO public."QuizOptions" VALUES (21211, 5303, 'Porque las cámaras no funcionan con cables', false);
INSERT INTO public."QuizOptions" VALUES (21212, 5303, 'Es una sugerencia estética', false);
INSERT INTO public."QuizOptions" VALUES (21213, 5304, 'La computadora gasta más electricidad', false);
INSERT INTO public."QuizOptions" VALUES (21214, 5304, 'Multiplica la velocidad de lectura y arranque del sistema operativo entre 5 y 10 veces, eliminando lentitudes por cuellos de botella de disco', true);
INSERT INTO public."QuizOptions" VALUES (21215, 5304, 'El monitor cambia de color', false);
INSERT INTO public."QuizOptions" VALUES (21216, 5304, 'La máquina se vuelve inmune a virus', false);
INSERT INTO public."QuizOptions" VALUES (21217, 5305, 'Digitalizar es solo pasar archivos de papel a formato PDF, mientras que la Transformación Digital rediseña los procesos, cultura y modelos de negocio apoyándose en tecnología', true);
INSERT INTO public."QuizOptions" VALUES (21218, 5305, 'No existe diferencia alguna', false);
INSERT INTO public."QuizOptions" VALUES (21219, 5305, 'Digitalizar requiere comprar computadoras caras y la transformación no', false);
INSERT INTO public."QuizOptions" VALUES (21220, 5305, 'La transformación digital aplica solo para redes sociales', false);
INSERT INTO public."QuizOptions" VALUES (21221, 5306, 'IaaS (Infraestructura como Servicio)', false);
INSERT INTO public."QuizOptions" VALUES (21222, 5306, 'SaaS (Software como Servicio)', true);
INSERT INTO public."QuizOptions" VALUES (21223, 5306, 'PaaS (Plataforma como Servicio)', false);
INSERT INTO public."QuizOptions" VALUES (21224, 5306, 'DaaS (Disco como Servicio)', false);
INSERT INTO public."QuizOptions" VALUES (21225, 5307, 'Permite pagar suscripciones operativas mensuales deducibles según el consumo real en lugar de hacer desembolsos de capital masivos en servidores físicos que se deprecian', true);
INSERT INTO public."QuizOptions" VALUES (21226, 5307, 'Elimina la necesidad de pagar internet', false);
INSERT INTO public."QuizOptions" VALUES (21227, 5307, 'Obliga a la empresa a pedir préstamos bancarios de alto riesgo', false);
INSERT INTO public."QuizOptions" VALUES (21228, 5307, 'Hace que el software sea gratis', false);
INSERT INTO public."QuizOptions" VALUES (21229, 5308, 'Dibujar planos de ingeniería', false);
INSERT INTO public."QuizOptions" VALUES (21230, 5308, 'Integrar y centralizar en una única base de datos los procesos de compras, inventario, ventas, producción, finanzas y contabilidad', true);
INSERT INTO public."QuizOptions" VALUES (21231, 5308, 'Descargar películas en streaming', false);
INSERT INTO public."QuizOptions" VALUES (21232, 5308, 'Enviar mensajes masivos no solicitados', false);
INSERT INTO public."QuizOptions" VALUES (21233, 5309, 'Gestionar la relación, interacciones, historial, presupuestos y seguimiento con prospectos y clientes a lo largo de su ciclo de vida', true);
INSERT INTO public."QuizOptions" VALUES (21234, 5309, 'Controlar la temperatura del servidor', false);
INSERT INTO public."QuizOptions" VALUES (21235, 5309, 'Calcular el impuesto sobre la renta anual', false);
INSERT INTO public."QuizOptions" VALUES (21236, 5309, 'Reparar cables de red', false);
INSERT INTO public."QuizOptions" VALUES (21237, 5310, 'El dinero ahorrado en el mes', false);
INSERT INTO public."QuizOptions" VALUES (21238, 5310, 'El tiempo máximo tolerable que un sistema o servicio tecnológico puede estar caído antes de causar daños graves al negocio', true);
INSERT INTO public."QuizOptions" VALUES (21239, 5310, 'La cantidad de gigabytes del disco duro', false);
INSERT INTO public."QuizOptions" VALUES (21240, 5310, 'El salario del gerente de tecnología', false);
INSERT INTO public."QuizOptions" VALUES (21241, 5311, 'La cantidad máxima de datos o transacciones que la empresa puede permitirse perder en términos de tiempo transcurrido desde el último respaldo', true);
INSERT INTO public."QuizOptions" VALUES (21242, 5311, 'La cantidad de pantallas conectadas al servidor', false);
INSERT INTO public."QuizOptions" VALUES (21243, 5311, 'El tiempo que tarda un empleado en almorzar', false);
INSERT INTO public."QuizOptions" VALUES (21244, 5311, 'El precio del servidor en dólares', false);
INSERT INTO public."QuizOptions" VALUES (21245, 5312, 'Que las computadoras sean de color negro', false);
INSERT INTO public."QuizOptions" VALUES (21246, 5312, 'La resistencia cultural al cambio por parte de los empleados y la falta de definición clara de los procesos de negocio antes de configurar el sistema', true);
INSERT INTO public."QuizOptions" VALUES (21247, 5312, 'Que el sistema funcione demasiado rápido', false);
INSERT INTO public."QuizOptions" VALUES (21248, 5312, 'Que el software esté en español', false);
INSERT INTO public."QuizOptions" VALUES (21249, 5313, 'RPA (Robotic Process Automation / Automatización Robótica de Procesos)', true);
INSERT INTO public."QuizOptions" VALUES (21250, 5313, 'Disquetes magnéticos', false);
INSERT INTO public."QuizOptions" VALUES (21251, 5313, 'Cables coaxiales', false);
INSERT INTO public."QuizOptions" VALUES (21252, 5313, 'Monitores analógicos CRT', false);
INSERT INTO public."QuizOptions" VALUES (21253, 5314, 'Para evitar que la gente use calculadoras', false);
INSERT INTO public."QuizOptions" VALUES (21254, 5314, 'Porque define políticas claras sobre quién puede acceder, modificar, resguardar y eliminar los datos sensibles de la organización y sus clientes', true);
INSERT INTO public."QuizOptions" VALUES (21255, 5314, 'Para que los datos sean públicos en internet', false);
INSERT INTO public."QuizOptions" VALUES (21256, 5314, 'No tiene utilidad en empresas modernas', false);
INSERT INTO public."QuizOptions" VALUES (21257, 5315, 'Disminuye de inmediato las existencias físicas en el almacén.', false);
INSERT INTO public."QuizOptions" VALUES (21258, 5315, 'Incrementa la cantidad en el campo ''Comprometido'', reservando el stock sin mover existencias físicas todavía.', true);
INSERT INTO public."QuizOptions" VALUES (21259, 5315, 'Genera de forma obligatoria el asiento contable de cuentas por cobrar e IVA.', false);
INSERT INTO public."QuizOptions" VALUES (21260, 5315, 'Factura automáticamente al cliente sin necesidad de emitir albarán ni entrega.', false);
INSERT INTO public."QuizOptions" VALUES (21261, 5316, 'Solo la casilla de ''Artículo General''.', false);
INSERT INTO public."QuizOptions" VALUES (21262, 5316, '''Artículo de Inventario'', ''Artículo de Venta'' y ''Artículo de Compra''.', true);
INSERT INTO public."QuizOptions" VALUES (21263, 5316, '''Artículo Fijo'', ''Artículo Variable'' y ''Artículo Contable''.', false);
INSERT INTO public."QuizOptions" VALUES (21264, 5316, '''Activo Corriente'', ''Pasivo'' y ''Patrimonio''.', false);
INSERT INTO public."QuizOptions" VALUES (21265, 5317, 'En la Solicitud de Compra interna.', false);
INSERT INTO public."QuizOptions" VALUES (21266, 5317, 'En el Pedido de Compra (Purchase Order).', false);
INSERT INTO public."QuizOptions" VALUES (21267, 5317, 'En la Entrada de Mercancías por Compras (Goods Receipt PO - GRPO).', true);
INSERT INTO public."QuizOptions" VALUES (21268, 5317, 'En el Pago Efectuado bancario.', false);
INSERT INTO public."QuizOptions" VALUES (21269, 5318, 'Asistente de Consultas Rápidas.', false);
INSERT INTO public."QuizOptions" VALUES (21270, 5318, 'Mapa de Relaciones (Relationship Map).', true);
INSERT INTO public."QuizOptions" VALUES (21271, 5318, 'Explorador de Archivos de Windows.', false);
INSERT INTO public."QuizOptions" VALUES (21272, 5318, 'Historial de Impresión de Facturas.', false);
INSERT INTO public."QuizOptions" VALUES (21273, 5319, 'Factura de Clientes con costo cero.', false);
INSERT INTO public."QuizOptions" VALUES (21274, 5319, 'Salida de Mercancías (Goods Issue) imputada a cuenta contable de merma/pérdida.', true);
INSERT INTO public."QuizOptions" VALUES (21275, 5319, 'Entrada de Mercancías negativa.', false);
INSERT INTO public."QuizOptions" VALUES (21276, 5319, 'Orden de Venta en estado cancelado.', false);
INSERT INTO public."QuizOptions" VALUES (21277, 5320, 'Cliente (Customer).', false);
INSERT INTO public."QuizOptions" VALUES (21278, 5320, 'Prospecto (Lead).', false);
INSERT INTO public."QuizOptions" VALUES (21279, 5320, 'Proveedor (Vendor).', true);
INSERT INTO public."QuizOptions" VALUES (21280, 5320, 'Empleado de Ventas.', false);
INSERT INTO public."QuizOptions" VALUES (21281, 5321, 'Se debita la cuenta de efectivo y se borra el inventario.', false);
INSERT INTO public."QuizOptions" VALUES (21282, 5321, 'Se genera la cuenta por cobrar al deudor (Débito) y se reconoce el ingreso por ventas e impuestos (Crédito).', true);
INSERT INTO public."QuizOptions" VALUES (21283, 5321, 'No se genera ningún asiento contable hasta que el cliente decida pagar.', false);
INSERT INTO public."QuizOptions" VALUES (21284, 5321, 'Se descuenta el saldo bancario de la empresa compradora.', false);
INSERT INTO public."QuizOptions" VALUES (21285, 5322, 'Indica las unidades que los clientes pidieron por internet.', false);
INSERT INTO public."QuizOptions" VALUES (21286, 5322, 'Indica la cantidad pedida a proveedores que aún está pendiente por ingresar al almacén.', true);
INSERT INTO public."QuizOptions" VALUES (21287, 5322, 'Indica los artículos devueltos por garantía.', false);
INSERT INTO public."QuizOptions" VALUES (21288, 5322, 'Indica los productos que han sido desechados en auditoría.', false);
INSERT INTO public."QuizOptions" VALUES (21289, 5323, 'Stock En Stock - Comprometido + Solicitado.', true);
INSERT INTO public."QuizOptions" VALUES (21290, 5323, 'Stock Físico / 2.', false);
INSERT INTO public."QuizOptions" VALUES (21291, 5323, 'Stock Solicitado - Comprometido.', false);
INSERT INTO public."QuizOptions" VALUES (21292, 5323, 'Stock En Stock * Costo Promedio.', false);
INSERT INTO public."QuizOptions" VALUES (21293, 5324, 'Para vender mercancía a una sucursal con cobro de comisión.', false);
INSERT INTO public."QuizOptions" VALUES (21294, 5324, 'Para mover existencias entre centros de costo sin afectar cuentas de resultados de pérdidas o ingresos.', true);
INSERT INTO public."QuizOptions" VALUES (21295, 5324, 'Para liquidar el inventario de fin de año fiscal.', false);
INSERT INTO public."QuizOptions" VALUES (21296, 5324, 'Para anular facturas de compras erróneas.', false);
INSERT INTO public."QuizOptions" VALUES (21297, 5325, 'Que los productos son más económicos para los compradores.', false);
INSERT INTO public."QuizOptions" VALUES (21298, 5325, 'Que los productos se agrupan automáticamente según condiciones y etiquetas sin intervención manual diaria.', true);
INSERT INTO public."QuizOptions" VALUES (21299, 5325, 'Que traduce automáticamente la tienda a 50 idiomas.', false);
INSERT INTO public."QuizOptions" VALUES (21300, 5325, 'Que elimina la necesidad de pagar comisiones por pasarela.', false);
INSERT INTO public."QuizOptions" VALUES (21301, 5326, 'Solo un archivo TXT con el nombre del propietario.', false);
INSERT INTO public."QuizOptions" VALUES (21302, 5326, 'El Registro A apuntando a la IP oficial de Shopify y el CNAME ''shops.myshopify.com''.', true);
INSERT INTO public."QuizOptions" VALUES (21303, 5326, 'Un registro MX bancario.', false);
INSERT INTO public."QuizOptions" VALUES (21304, 5326, 'Una redirección HTTP 301 en WhatsApp.', false);
INSERT INTO public."QuizOptions" VALUES (21305, 5327, 'Checkout Criptográfico.', false);
INSERT INTO public."QuizOptions" VALUES (21306, 5327, 'Métodos de Pago Manuales (Manual Payment Methods).', true);
INSERT INTO public."QuizOptions" VALUES (21307, 5327, 'Shopify Direct Wire.', false);
INSERT INTO public."QuizOptions" VALUES (21308, 5327, 'Billetera Virtual Externa.', false);
INSERT INTO public."QuizOptions" VALUES (21309, 5328, 'Devuelve el dinero al cliente de forma automática.', false);
INSERT INTO public."QuizOptions" VALUES (21310, 5328, 'Marca el pedido como preparado y despachado, notificando al cliente con su número de rastreo si aplica.', true);
INSERT INTO public."QuizOptions" VALUES (21311, 5328, 'Elimina permanentemente la cuenta del comprador.', false);
INSERT INTO public."QuizOptions" VALUES (21312, 5328, 'Aumenta el precio del producto vendido.', false);
INSERT INTO public."QuizOptions" VALUES (21313, 5329, 'Llamar por teléfono al cliente cada 15 minutos.', false);
INSERT INTO public."QuizOptions" VALUES (21314, 5329, 'Activar la automatización nativa de correos de recuperación de carritos con incentivos oportunos.', true);
INSERT INTO public."QuizOptions" VALUES (21315, 5329, 'Borrar los carritos abandonados cada noche para que no hagan peso en la base de datos.', false);
INSERT INTO public."QuizOptions" VALUES (21316, 5329, 'Aumentar el precio de los productos en el carrito.', false);
INSERT INTO public."QuizOptions" VALUES (21317, 5330, 'Un producto de la competencia que se muestra en tu web.', false);
INSERT INTO public."QuizOptions" VALUES (21318, 5330, 'Una opción específica de un artículo, como talla, color o material, que puede tener su propio precio y stock.', true);
INSERT INTO public."QuizOptions" VALUES (21319, 5330, 'Una imagen rota en el banner principal.', false);
INSERT INTO public."QuizOptions" VALUES (21320, 5330, 'Un descuento del 50% para amigos.', false);
INSERT INTO public."QuizOptions" VALUES (21321, 5331, 'Ninguno, las tiendas online no necesitan textos legales.', false);
INSERT INTO public."QuizOptions" VALUES (21322, 5331, 'Desconfianza en los usuarios y posible suspensión de cuentas publicitarias en Meta Ads y Google Merchant Center.', true);
INSERT INTO public."QuizOptions" VALUES (21323, 5331, 'Shopify cobra el triple de comisión de suscripción.', false);
INSERT INTO public."QuizOptions" VALUES (21324, 5331, 'Los productos se borran del inventario a las 48 horas.', false);
INSERT INTO public."QuizOptions" VALUES (21325, 5332, 'El editor visual Online Store 2.0 con bloques dinámicos.', true);
INSERT INTO public."QuizOptions" VALUES (21326, 5332, 'El compilador C++ de Shopify.', false);
INSERT INTO public."QuizOptions" VALUES (21327, 5332, 'La consola de comandos de Linux.', false);
INSERT INTO public."QuizOptions" VALUES (21328, 5332, 'El bloc de notas de Windows.', false);
INSERT INTO public."QuizOptions" VALUES (21329, 5333, 'Tasa de Rebote (Bounce Rate).', false);
INSERT INTO public."QuizOptions" VALUES (21330, 5333, 'Tasa de Conversión (Conversion Rate).', true);
INSERT INTO public."QuizOptions" VALUES (21331, 5333, 'Retorno del Gasto Publicitario (ROAS).', false);
INSERT INTO public."QuizOptions" VALUES (21332, 5333, 'Costo por Clic (CPC).', false);
INSERT INTO public."QuizOptions" VALUES (21333, 5334, 'Para que la tienda se vea de color verde.', false);
INSERT INTO public."QuizOptions" VALUES (21334, 5334, 'Para mantener un control riguroso de inventario y facilitar la sincronización con almacenes y software ERP.', true);
INSERT INTO public."QuizOptions" VALUES (21335, 5334, 'Porque la ley prohíbe vender sin SKU en internet.', false);
INSERT INTO public."QuizOptions" VALUES (21336, 5334, 'Para ocultar los precios a los clientes mayoristas.', false);
INSERT INTO public."QuizOptions" VALUES (21337, 5335, 'Encender el televisor de la tienda.', false);
INSERT INTO public."QuizOptions" VALUES (21338, 5335, 'Realizar el conteo físico del fondo inicial de caja (sencillo) en presencia de un supervisor y firmar la entrega.', true);
INSERT INTO public."QuizOptions" VALUES (21339, 5335, 'Realizar un retiro de remesa a la bóveda.', false);
INSERT INTO public."QuizOptions" VALUES (21340, 5335, 'Cambiar las contraseñas del sistema POS.', false);
INSERT INTO public."QuizOptions" VALUES (21341, 5336, 'En cobrar dos veces el mismo producto por error.', false);
INSERT INTO public."QuizOptions" VALUES (21342, 5336, 'En sugerir un producto complementario útil que se relacione directamente con el artículo principal que el cliente ya eligió.', true);
INSERT INTO public."QuizOptions" VALUES (21343, 5336, 'En convencer al cliente de que no compre nada.', false);
INSERT INTO public."QuizOptions" VALUES (21344, 5336, 'En vender artículos de la tienda vecina.', false);
INSERT INTO public."QuizOptions" VALUES (21345, 5337, 'Gritar por el altavoz el nombre de la persona sospechosa.', false);
INSERT INTO public."QuizOptions" VALUES (21346, 5337, 'Brindar un saludo y atención al cliente activa, amable y cercana (''¡Buenas tardes! ¿En qué puedo asesorarle hoy?'').', true);
INSERT INTO public."QuizOptions" VALUES (21347, 5337, 'Cerrar las puertas con llave para que nadie pueda salir.', false);
INSERT INTO public."QuizOptions" VALUES (21348, 5337, 'Seguir a la persona a 10 centímetros de distancia con cara de enojo.', false);
INSERT INTO public."QuizOptions" VALUES (21349, 5338, 'El catálogo de precios.', false);
INSERT INTO public."QuizOptions" VALUES (21350, 5338, 'El reporte de Cierre de Lote o Reporte Z del terminal financiero.', true);
INSERT INTO public."QuizOptions" VALUES (21351, 5338, 'La lista de asistencia del personal.', false);
INSERT INTO public."QuizOptions" VALUES (21352, 5338, 'El contrato de trabajo del cajero.', false);
INSERT INTO public."QuizOptions" VALUES (21353, 5339, 'El comprobante o factura fiscal de compra dentro del plazo vigente y el estado físico impecable del artículo y empaque.', true);
INSERT INTO public."QuizOptions" VALUES (21354, 5339, 'Que el cliente tenga más de 30 años de edad.', false);
INSERT INTO public."QuizOptions" VALUES (21355, 5339, 'Que el producto esté abierto y usado por varias semanas.', false);
INSERT INTO public."QuizOptions" VALUES (21356, 5339, 'Que el supervisor no se encuentre en la tienda.', false);
INSERT INTO public."QuizOptions" VALUES (21357, 5340, 'Contar el dinero con los ojos cerrados.', false);
INSERT INTO public."QuizOptions" VALUES (21358, 5340, 'Que el cajero cuenta todo el dinero y comprobantes sin ver previamente el saldo que el sistema informático dice que debería haber.', true);
INSERT INTO public."QuizOptions" VALUES (21359, 5340, 'Apagar las luces del local para contar las monedas.', false);
INSERT INTO public."QuizOptions" VALUES (21360, 5340, 'Entregar la gaveta de dinero sin contar nada.', false);
INSERT INTO public."QuizOptions" VALUES (21361, 5341, 'Discutir fuertemente y decirle que la culpa es de él por no saber usarlo.', false);
INSERT INTO public."QuizOptions" VALUES (21362, 5341, 'Mantener la calma, escuchar activamente sin interrumpir, mostrar empatía y proceder a la revisión según la política de garantías.', true);
INSERT INTO public."QuizOptions" VALUES (21363, 5341, 'Ignorarlo y llamar a la policía inmediatamente.', false);
INSERT INTO public."QuizOptions" VALUES (21364, 5341, 'Darse la vuelta y marcharse a la bodega.', false);
INSERT INTO public."QuizOptions" VALUES (21365, 5342, 'Para gastar el dinero en compras personales.', false);
INSERT INTO public."QuizOptions" VALUES (21366, 5342, 'Por seguridad operativa, para minimizar la cantidad de dinero expuesta en gaveta ante posibles robos o emergencias.', true);
INSERT INTO public."QuizOptions" VALUES (21367, 5342, 'Porque la gaveta de caja se rompe si tiene más de 10 billetes.', false);
INSERT INTO public."QuizOptions" VALUES (21368, 5342, 'Para pagarle a los proveedores en efectivo sin factura.', false);
INSERT INTO public."QuizOptions" VALUES (21369, 5343, 'Ofrecer una versión de mayor gama o con prestaciones superiores demostrando el valor y beneficio añadido.', true);
INSERT INTO public."QuizOptions" VALUES (21370, 5343, 'Obligar al cliente a llevar tres unidades del mismo artículo.', false);
INSERT INTO public."QuizOptions" VALUES (21371, 5343, 'Rebajar el precio a la mitad sin permiso de la gerencia.', false);
INSERT INTO public."QuizOptions" VALUES (21372, 5343, 'Vender productos vencidos con descuento.', false);
INSERT INTO public."QuizOptions" VALUES (21373, 5344, 'La marca de agua nítida, la cinta de seguridad incrustada y los hilos fluorescentes.', true);
INSERT INTO public."QuizOptions" VALUES (21374, 5344, 'El aroma del papel moneda.', false);
INSERT INTO public."QuizOptions" VALUES (21375, 5344, 'El grosor de la tinta de bolígrafo.', false);
INSERT INTO public."QuizOptions" VALUES (21376, 5344, 'El sello de la tienda de la esquina.', false);
INSERT INTO public."QuizOptions" VALUES (21377, 5345, 'Nivel Suelo (por debajo de 80 cm).', false);
INSERT INTO public."QuizOptions" VALUES (21378, 5345, 'Nivel Ojos (entre 1.30 m y 1.70 m).', true);
INSERT INTO public."QuizOptions" VALUES (21379, 5345, 'Nivel Techo (por encima de 2 metros).', false);
INSERT INTO public."QuizOptions" VALUES (21380, 5345, 'La trastienda de descarga.', false);
INSERT INTO public."QuizOptions" VALUES (21381, 5346, 'First In, First Out (Primero en Entrar, Primero en Salir).', false);
INSERT INTO public."QuizOptions" VALUES (21382, 5346, 'First Expired, First Out (El producto con fecha de vencimiento más próxima debe colocarse al frente para venderse primero).', true);
INSERT INTO public."QuizOptions" VALUES (21383, 5346, 'Fast Entry, Fast Output (Venta ultra rápida sin control de fechas).', false);
INSERT INTO public."QuizOptions" VALUES (21384, 5346, 'Free Exchange For Others (Cambios gratis sin factura).', false);
INSERT INTO public."QuizOptions" VALUES (21385, 5347, 'Una foto carnet del mercaderista.', false);
INSERT INTO public."QuizOptions" VALUES (21386, 5347, 'La cantidad de unidades frontales o caras de un mismo producto que se exhiben en la primera fila del estante.', true);
INSERT INTO public."QuizOptions" VALUES (21387, 5347, 'El precio de oferta colocado con plumón.', false);
INSERT INTO public."QuizOptions" VALUES (21388, 5347, 'Un tipo de detergente industrial.', false);
INSERT INTO public."QuizOptions" VALUES (21389, 5348, 'El Planograma.', true);
INSERT INTO public."QuizOptions" VALUES (21390, 5348, 'El Balance General de la empresa.', false);
INSERT INTO public."QuizOptions" VALUES (21391, 5348, 'El Recibo de Sueldo.', false);
INSERT INTO public."QuizOptions" VALUES (21392, 5348, 'El Cronograma de Vacaciones.', false);
INSERT INTO public."QuizOptions" VALUES (21393, 5349, 'Ocultar los productos detrás de otras cajas para no tener problemas.', false);
INSERT INTO public."QuizOptions" VALUES (21394, 5349, 'Avisar de inmediato al supervisor comercial y jefe de sección para activar protocolo de liquidación, promoción o canje oportuno.', true);
INSERT INTO public."QuizOptions" VALUES (21395, 5349, 'Tirar los productos a la basura sin reportar a nadie.', false);
INSERT INTO public."QuizOptions" VALUES (21396, 5349, 'Modificar la fecha de vencimiento con una etiqueta falsa.', false);
INSERT INTO public."QuizOptions" VALUES (21397, 5350, 'Música bailable que suena en los altavoces de la tienda.', false);
INSERT INTO public."QuizOptions" VALUES (21398, 5350, 'Elementos gráficos y publicitarios (cenefas, stoppers, afiches, bandejas) colocados en el punto de venta para llamar la atención del shopper.', true);
INSERT INTO public."QuizOptions" VALUES (21399, 5350, 'El uniforme de tela que usan los cajeros.', false);
INSERT INTO public."QuizOptions" VALUES (21400, 5350, 'El sistema contable de emisión de facturas.', false);
INSERT INTO public."QuizOptions" VALUES (21401, 5351, 'Porque están cerca del sol o de hornos de panadería.', false);
INSERT INTO public."QuizOptions" VALUES (21402, 5351, 'Porque reciben el flujo constante de clientes que transitan por los pasillos principales, multiplicando la visibilidad.', true);
INSERT INTO public."QuizOptions" VALUES (21403, 5351, 'Porque son los lugares más oscuros de la tienda.', false);
INSERT INTO public."QuizOptions" VALUES (21404, 5351, 'Porque no requieren que nadie las limpie.', false);
INSERT INTO public."QuizOptions" VALUES (21405, 5352, 'Que el mercaderista está cansado tras su turno.', false);
INSERT INTO public."QuizOptions" VALUES (21406, 5352, 'La ausencia total del producto en la góndola para la venta, impidiendo que el cliente lo compre.', true);
INSERT INTO public."QuizOptions" VALUES (21407, 5352, 'Que el producto se vendió con 100% de descuento.', false);
INSERT INTO public."QuizOptions" VALUES (21408, 5352, 'Que el producto cambió de empaque en la fábrica.', false);
INSERT INTO public."QuizOptions" VALUES (21409, 5353, 'Facilita apagar las luces del pasillo.', false);
INSERT INTO public."QuizOptions" VALUES (21410, 5353, 'Crea un impacto visual cromático uniforme que ayuda al cliente a identificar rápidamente la marca a distancia.', true);
INSERT INTO public."QuizOptions" VALUES (21411, 5353, 'Reduce el precio de costo del producto.', false);
INSERT INTO public."QuizOptions" VALUES (21412, 5353, 'Evita tener que limpiar el polvo de los estantes.', false);
INSERT INTO public."QuizOptions" VALUES (21413, 5354, 'Por ergonomía y seguridad: evita accidentes graves por caídas y facilita que el cliente los arrastre al carrito.', true);
INSERT INTO public."QuizOptions" VALUES (21414, 5354, 'Porque a los perros les gusta mirar el suelo.', false);
INSERT INTO public."QuizOptions" VALUES (21415, 5354, 'Porque están hechos de materiales que no se pueden mojar.', false);
INSERT INTO public."QuizOptions" VALUES (21416, 5354, 'Para que nadie los encuentre.', false);
INSERT INTO public."QuizOptions" VALUES (21417, 5355, 'Que WhatsApp regala crédito publicitario gratis.', false);
INSERT INTO public."QuizOptions" VALUES (21418, 5355, 'Permite enviar información predefinida (catálogo, cuentas de pago, políticas) en segundos usando atajos como ''/pago''.', true);
INSERT INTO public."QuizOptions" VALUES (21419, 5355, 'Que bloquea a los clientes molestos automáticamente.', false);
INSERT INTO public."QuizOptions" VALUES (21420, 5355, 'Que apaga el teléfono automáticamente al llegar la noche.', false);
INSERT INTO public."QuizOptions" VALUES (21421, 5356, 'Contestar amablemente con un saludo cordial.', false);
INSERT INTO public."QuizOptions" VALUES (21422, 5356, 'Enviar únicamente el número del precio aislado sin explicar el valor ni rematar con una pregunta de cierre.', true);
INSERT INTO public."QuizOptions" VALUES (21423, 5356, 'Confirmar que hay stock disponible en bodega.', false);
INSERT INTO public."QuizOptions" VALUES (21424, 5356, 'Ofrecer opciones de entrega a domicilio.', false);
INSERT INTO public."QuizOptions" VALUES (21425, 5357, 'ROAS (Return on Ad Spend).', false);
INSERT INTO public."QuizOptions" VALUES (21426, 5357, 'CAC (Costo de Adquisición de Clientes).', true);
INSERT INTO public."QuizOptions" VALUES (21427, 5357, 'CTR (Click-Through Rate).', false);
INSERT INTO public."QuizOptions" VALUES (21428, 5357, 'EBITDA.', false);
INSERT INTO public."QuizOptions" VALUES (21429, 5358, 'Porque el algoritmo premia el tiempo de respuesta y los compradores online suelen comprar a la primera tienda que les resuelve la duda.', true);
INSERT INTO public."QuizOptions" VALUES (21430, 5358, 'Porque si tardas más de 10 minutos, el banco cancela tu cuenta.', false);
INSERT INTO public."QuizOptions" VALUES (21431, 5358, 'Porque la aplicación se desinstala del teléfono.', false);
INSERT INTO public."QuizOptions" VALUES (21432, 5358, 'Porque es obligatorio por ley constitucional.', false);
INSERT INTO public."QuizOptions" VALUES (21433, 5359, 'El límite de tarjetas virtuales en el banco.', false);
INSERT INTO public."QuizOptions" VALUES (21434, 5359, 'El beneficio económico total neto que un cliente aporta a la empresa a lo largo de toda su relación comercial.', true);
INSERT INTO public."QuizOptions" VALUES (21435, 5359, 'La longitud total del texto de un anuncio.', false);
INSERT INTO public."QuizOptions" VALUES (21436, 5359, 'El tiempo que la persona pasa conectada a internet al día.', false);
INSERT INTO public."QuizOptions" VALUES (21437, 5360, 'Cierre por agotamiento.', false);
INSERT INTO public."QuizOptions" VALUES (21438, 5360, 'Técnica de la alternativa doble (ej. ''¿Prefieres envío a oficina o a tu casa?'').', true);
INSERT INTO public."QuizOptions" VALUES (21439, 5360, 'Cierre con descuento no autorizado.', false);
INSERT INTO public."QuizOptions" VALUES (21440, 5360, 'Silencio absoluto de 24 horas.', false);
INSERT INTO public."QuizOptions" VALUES (21441, 5361, 'Para ponerle stickers graciosos a los clientes.', false);
INSERT INTO public."QuizOptions" VALUES (21442, 5361, 'Para clasificar visualmente a los prospectos según la etapa de su embudo (nuevo lead, esperando pago, despachado).', true);
INSERT INTO public."QuizOptions" VALUES (21443, 5361, 'Para cobrarles un impuesto extra por mensaje.', false);
INSERT INTO public."QuizOptions" VALUES (21444, 5361, 'Para cambiar el color de la aplicación.', false);
INSERT INTO public."QuizOptions" VALUES (21445, 5362, '1x.', false);
INSERT INTO public."QuizOptions" VALUES (21446, 5362, '5x.', true);
INSERT INTO public."QuizOptions" VALUES (21447, 5362, '50x.', false);
INSERT INTO public."QuizOptions" VALUES (21448, 5362, '0.5x.', false);
INSERT INTO public."QuizOptions" VALUES (21449, 5363, 'Oferta imperdible compra ya barato 123.', false);
INSERT INTO public."QuizOptions" VALUES (21450, 5363, 'Producto principal + Marca + Modelo + Característica o especificación clave.', true);
INSERT INTO public."QuizOptions" VALUES (21451, 5363, 'Solo emojis de fueguitos y estrellas.', false);
INSERT INTO public."QuizOptions" VALUES (21452, 5363, 'El nombre del dueño del negocio.', false);
INSERT INTO public."QuizOptions" VALUES (21453, 5364, 'CAC debe ser el triple que LTV.', false);
INSERT INTO public."QuizOptions" VALUES (21454, 5364, 'LTV debe ser al menos 3 veces mayor que el CAC (LTV : CAC >= 3:1).', true);
INSERT INTO public."QuizOptions" VALUES (21455, 5364, 'Deben ser exactamente iguales a cero.', false);
INSERT INTO public."QuizOptions" VALUES (21456, 5364, 'No tiene ninguna importancia medir la relación entre ambos.', false);
INSERT INTO public."QuizOptions" VALUES (21457, 5365, 'Nivel Operativo.', false);
INSERT INTO public."QuizOptions" VALUES (21458, 5365, 'Nivel Táctico.', false);
INSERT INTO public."QuizOptions" VALUES (21459, 5365, 'Nivel Estratégico (Directorio y Gerencia General).', true);
INSERT INTO public."QuizOptions" VALUES (21460, 5365, 'Personal de seguridad externa.', false);
INSERT INTO public."QuizOptions" VALUES (21461, 5366, 'La Requisición Interna.', false);
INSERT INTO public."QuizOptions" VALUES (21462, 5366, 'La Orden de Compra (Purchase Order).', true);
INSERT INTO public."QuizOptions" VALUES (21463, 5366, 'La Hoja de Vida del Gerente.', false);
INSERT INTO public."QuizOptions" VALUES (21464, 5366, 'El Memorándum de despido.', false);
INSERT INTO public."QuizOptions" VALUES (21465, 5367, 'Para retrasar el trabajo y no trabajar por dos semanas.', false);
INSERT INTO public."QuizOptions" VALUES (21466, 5367, 'Para comparar precios de mercado, calidad y tiempos de entrega, previniendo gastos inflados o favoritismos indebidos.', true);
INSERT INTO public."QuizOptions" VALUES (21467, 5367, 'Porque el banco bloquea las cuentas si no hay tres cartas.', false);
INSERT INTO public."QuizOptions" VALUES (21468, 5367, 'Para engañar a los proveedores y que todos bajen su margen a cero.', false);
INSERT INTO public."QuizOptions" VALUES (21469, 5368, 'Los años de servicio de los empleados del departamento.', false);
INSERT INTO public."QuizOptions" VALUES (21470, 5368, 'La fecha de vencimiento de las cuentas por cobrar agrupadas por tramos de tiempo (corriente, 30, 60, 90+ días).', true);
INSERT INTO public."QuizOptions" VALUES (21471, 5368, 'La edad del mobiliario y computadoras de la oficina.', false);
INSERT INTO public."QuizOptions" VALUES (21472, 5368, 'El tiempo que tiene el producto guardado en almacén.', false);
INSERT INTO public."QuizOptions" VALUES (21473, 5369, 'Rellenar páginas para que el informe se vea más pesado.', false);
INSERT INTO public."QuizOptions" VALUES (21474, 5369, 'Proporcionar a los directivos los datos clave, resultados y conclusiones más importantes en 1 página para tomar decisiones rápidas.', true);
INSERT INTO public."QuizOptions" VALUES (21475, 5369, 'Incluir chistes para entretener al gerente.', false);
INSERT INTO public."QuizOptions" VALUES (21476, 5369, 'Esconder las pérdidas financieras al final del año.', false);
INSERT INTO public."QuizOptions" VALUES (21477, 5370, 'Ventas debe generar la orden formal para que Almacén verifique existencias físicas y proceda al embalaje y entrega.', true);
INSERT INTO public."QuizOptions" VALUES (21478, 5370, 'Ventas debe ingresar al almacén sin avisar y llevarse las cajas en sus autos personales.', false);
INSERT INTO public."QuizOptions" VALUES (21479, 5370, 'Almacén decide a qué precio vender los productos a los clientes.', false);
INSERT INTO public."QuizOptions" VALUES (21480, 5370, 'Ninguna, nunca se comunican entre sí.', false);
INSERT INTO public."QuizOptions" VALUES (21481, 5371, 'La cantidad total de facturas emitidas sin importar si fueron pagadas.', false);
INSERT INTO public."QuizOptions" VALUES (21482, 5371, 'Las entradas y salidas reales de dinero líquido o efectivo en las cuentas bancarias durante un periodo determinado.', true);
INSERT INTO public."QuizOptions" VALUES (21483, 5371, 'El valor del edificio corporativo.', false);
INSERT INTO public."QuizOptions" VALUES (21484, 5371, 'El total de seguidores que tiene la empresa en redes sociales.', false);
INSERT INTO public."QuizOptions" VALUES (21485, 5372, 'Tecnología e Informática.', false);
INSERT INTO public."QuizOptions" VALUES (21486, 5372, 'Gestión de Talento Humano / Recursos Humanos.', true);
INSERT INTO public."QuizOptions" VALUES (21487, 5372, 'Mantenimiento e Infraestructura.', false);
INSERT INTO public."QuizOptions" VALUES (21488, 5372, 'Compras y Suministros.', false);
INSERT INTO public."QuizOptions" VALUES (21489, 5373, 'La renuncia inmediata de todo el equipo de trabajo.', false);
INSERT INTO public."QuizOptions" VALUES (21490, 5373, 'La explicación de la causa raíz de la desviación y un plan de acción concreto con responsables y fechas para corregirla.', true);
INSERT INTO public."QuizOptions" VALUES (21491, 5373, 'Un cambio de colores en la gráfica para que parezca que sí se cumplió.', false);
INSERT INTO public."QuizOptions" VALUES (21492, 5373, 'Eliminar la gráfica del documento final.', false);
INSERT INTO public."QuizOptions" VALUES (21493, 5374, 'Porque el cliente se ofende por comprar a crédito.', false);
INSERT INTO public."QuizOptions" VALUES (21494, 5374, 'Porque incrementa exponencialmente el riesgo de impago, morosidad severa y quiebra por falta de liquidez en la empresa.', true);
INSERT INTO public."QuizOptions" VALUES (21495, 5374, 'Porque el gobierno impone multas si se vende a crédito.', false);
INSERT INTO public."QuizOptions" VALUES (21496, 5374, 'Porque las ventas aumentan demasiado rápido.', false);
INSERT INTO public."QuizOptions" VALUES (21497, 5375, 'Son los artículos más baratos que ocupan todo el almacén.', false);
INSERT INTO public."QuizOptions" VALUES (21498, 5375, 'Representan aproximadamente el 70-80% del valor total monetario del stock, a pesar de constituir solo el 10-20% de los códigos SKU.', true);
INSERT INTO public."QuizOptions" VALUES (21499, 5375, 'Son productos que nunca se venden y deben ser desechados.', false);
INSERT INTO public."QuizOptions" VALUES (21500, 5375, 'Son materiales de oficina de bajo costo.', false);
INSERT INTO public."QuizOptions" VALUES (21501, 5376, 'Garantizar que los empleados tengan regalos de fin de año.', false);
INSERT INTO public."QuizOptions" VALUES (21502, 5376, 'Proteger a la empresa contra fluctuaciones imprevistas en la demanda o demoras no planificadas en el tiempo de entrega del proveedor.', true);
INSERT INTO public."QuizOptions" VALUES (21503, 5376, 'Llenar los pasillos para que no se vean vacíos.', false);
INSERT INTO public."QuizOptions" VALUES (21504, 5376, 'Pagar menos impuestos sobre la renta.', false);
INSERT INTO public."QuizOptions" VALUES (21505, 5377, 'La fecha límite en que la empresa se declara en quiebra.', false);
INSERT INTO public."QuizOptions" VALUES (21506, 5377, 'El nivel exacto de existencias en el cual debe generarse un nuevo pedido de compra al proveedor.', true);
INSERT INTO public."QuizOptions" VALUES (21507, 5377, 'La cantidad máxima de cajas que caben en un camión.', false);
INSERT INTO public."QuizOptions" VALUES (21508, 5377, 'El precio de descuento por comprar al mayoreo.', false);
INSERT INTO public."QuizOptions" VALUES (21509, 5378, '50 unidades.', false);
INSERT INTO public."QuizOptions" VALUES (21510, 5378, '70 unidades.', true);
INSERT INTO public."QuizOptions" VALUES (21511, 5378, '20 unidades.', false);
INSERT INTO public."QuizOptions" VALUES (21512, 5378, '100 unidades.', false);
INSERT INTO public."QuizOptions" VALUES (21513, 5379, 'El costo de alquiler del almacén, seguros contra incendio, refrigeración y merma por obsolescencia.', true);
INSERT INTO public."QuizOptions" VALUES (21514, 5379, 'El sello de goma para marcar las facturas.', false);
INSERT INTO public."QuizOptions" VALUES (21515, 5379, 'El almuerzo del conductor del camión.', false);
INSERT INTO public."QuizOptions" VALUES (21516, 5379, 'La comisión bancaria por abrir una cuenta corriente.', false);
INSERT INTO public."QuizOptions" VALUES (21517, 5380, 'Porque permiten corregir errores y detectar mermas en tiempo real a lo largo del año sin necesidad de paralizar la producción y las ventas.', true);
INSERT INTO public."QuizOptions" VALUES (21518, 5380, 'Porque no requieren que nadie cuente nada.', false);
INSERT INTO public."QuizOptions" VALUES (21519, 5380, 'Porque se realizan únicamente en la computadora sin ir a los estantes.', false);
INSERT INTO public."QuizOptions" VALUES (21520, 5380, 'Porque son obligatorios por ley constitucional los días domingos.', false);
INSERT INTO public."QuizOptions" VALUES (21521, 5381, 'La cantidad de artículos rotos en el piso.', false);
INSERT INTO public."QuizOptions" VALUES (21797, 5450, 'Hablar en privado de forma respetuosa.', false);
INSERT INTO public."QuizOptions" VALUES (21522, 5381, 'El porcentaje de concordancia entre las unidades físicas reales contadas en el estante y los registros del software de inventarios.', true);
INSERT INTO public."QuizOptions" VALUES (21523, 5381, 'El número de empleados que usan casco en bodega.', false);
INSERT INTO public."QuizOptions" VALUES (21524, 5381, 'El costo de transporte por kilómetro recorrido.', false);
INSERT INTO public."QuizOptions" VALUES (21525, 5382, 'Encontrar la cantidad de compra que minimiza la suma de los costos de ordenar y los costos de mantener existencias.', true);
INSERT INTO public."QuizOptions" VALUES (21526, 5382, 'Comprar la mayor cantidad posible para saturar todos los almacenes.', false);
INSERT INTO public."QuizOptions" VALUES (21527, 5382, 'No comprar nada durante 6 meses.', false);
INSERT INTO public."QuizOptions" VALUES (21528, 5382, 'Calcular el sueldo de los estibadores del almacén.', false);
INSERT INTO public."QuizOptions" VALUES (21529, 5383, 'Contar los productos sin encender las luces.', false);
INSERT INTO public."QuizOptions" VALUES (21530, 5383, 'Entregar al auditor o encargado del conteo una lista de productos sin mostrar las cantidades teóricas que indica el sistema.', true);
INSERT INTO public."QuizOptions" VALUES (21531, 5383, 'Contar únicamente los artículos que no tienen etiquetas.', false);
INSERT INTO public."QuizOptions" VALUES (21532, 5383, 'Delegar el conteo a personas que no trabajan en la empresa.', false);
INSERT INTO public."QuizOptions" VALUES (21533, 5384, 'Que los productos tardan muchos años en venderse y acumulan polvo.', false);
INSERT INTO public."QuizOptions" VALUES (21534, 5384, 'Que el inventario se renueva y vende rápidamente a lo largo del año, optimizando el flujo de caja y reduciendo el riesgo de obsolescencia.', true);
INSERT INTO public."QuizOptions" VALUES (21535, 5384, 'Que los estantes del almacén giran sobre su propio eje.', false);
INSERT INTO public."QuizOptions" VALUES (21536, 5384, 'Que los clientes devuelven todas las compras.', false);
INSERT INTO public."QuizOptions" VALUES (21537, 5385, 'Pintar los pasillos con rayas amarillas.', false);
INSERT INTO public."QuizOptions" VALUES (21538, 5385, 'Recolectar y extraer los artículos específicos de sus ubicaciones de estantería para preparar el pedido de un cliente.', true);
INSERT INTO public."QuizOptions" VALUES (21539, 5385, 'Conducir el camión de reparto hasta la casa del cliente.', false);
INSERT INTO public."QuizOptions" VALUES (21540, 5385, 'Pagar la factura del teléfono del almacén.', false);
INSERT INTO public."QuizOptions" VALUES (21541, 5386, 'Mantener las piernas completamente rectas y doblar la cintura hacia abajo.', false);
INSERT INTO public."QuizOptions" VALUES (21542, 5386, 'Flexionar las rodillas con la espalda recta, acercar la carga al cuerpo y hacer la fuerza con las piernas al levantarse.', true);
INSERT INTO public."QuizOptions" VALUES (21543, 5386, 'Girar bruscamente el torso mientras se sube el peso con los brazos estirados.', false);
INSERT INTO public."QuizOptions" VALUES (21544, 5386, 'Levantar la caja corriendo para no sentir el peso.', false);
INSERT INTO public."QuizOptions" VALUES (21545, 5387, 'Sandalias abiertas y camiseta sin mangas.', false);
INSERT INTO public."QuizOptions" VALUES (21546, 5387, 'Botas de seguridad con puntera reforzada, chaleco reflectante y casco en zonas de estiba elevada.', true);
INSERT INTO public."QuizOptions" VALUES (21547, 5387, 'Guantes de lana para el frío en verano.', false);
INSERT INTO public."QuizOptions" VALUES (21548, 5387, 'Lentes oscuros de sol.', false);
INSERT INTO public."QuizOptions" VALUES (21549, 5388, 'Porque las cajas se sienten incómodas.', false);
INSERT INTO public."QuizOptions" VALUES (21550, 5388, 'Porque pierden hasta un 30% de resistencia al apilamiento, corren riesgo de rasgarse en los racks y pueden desestabilizar la carga entera.', true);
INSERT INTO public."QuizOptions" VALUES (21551, 5388, 'Porque el pallet pesa menos.', false);
INSERT INTO public."QuizOptions" VALUES (21552, 5388, 'Porque el film stretch no se pega al cartón.', false);
INSERT INTO public."QuizOptions" VALUES (21553, 5389, 'Tirar todo a la basura sin revisar.', false);
INSERT INTO public."QuizOptions" VALUES (21554, 5389, 'Un lugar para cada cosa y cada cosa en su lugar, delimitando y rotulando claramente ubicaciones y herramientas.', true);
INSERT INTO public."QuizOptions" VALUES (21555, 5389, 'Tomar fotos de recuerdo con el equipo.', false);
INSERT INTO public."QuizOptions" VALUES (21556, 5389, 'Desconectar los refrigeradores por la noche.', false);
INSERT INTO public."QuizOptions" VALUES (21557, 5390, 'Para proteger el producto de la lluvia y unificar la carga de cajas para que no se desplace ni caiga durante el transporte.', true);
INSERT INTO public."QuizOptions" VALUES (21558, 5390, 'Para que la carga pese el doble al pasar por la balanza.', false);
INSERT INTO public."QuizOptions" VALUES (21559, 5390, 'Para que nadie pueda abrir las cajas nunca más.', false);
INSERT INTO public."QuizOptions" VALUES (21560, 5390, 'Para ocultar si faltan productos en el envío.', false);
INSERT INTO public."QuizOptions" VALUES (21561, 5391, 'Es la cafetería donde los empleados descansan al mediodía.', false);
INSERT INTO public."QuizOptions" VALUES (21562, 5391, 'Es la zona donde se agrupan, validan y rotulan los pedidos ya empacados antes de cargarlos en los vehículos de reparto.', true);
INSERT INTO public."QuizOptions" VALUES (21563, 5391, 'El estacionamiento exclusivo de la gerencia general.', false);
INSERT INTO public."QuizOptions" VALUES (21564, 5391, 'El cuarto de almacenamiento de desechos biológicos.', false);
INSERT INTO public."QuizOptions" VALUES (21565, 5392, 'Ignorarlo y esperar que se seque solo en un par de días.', false);
INSERT INTO public."QuizOptions" VALUES (21566, 5392, 'Señalizar el área de inmediato con conos de advertencia y aplicar material absorbente o limpiarlo para evitar caídas y derrapes.', true);
INSERT INTO public."QuizOptions" VALUES (21567, 5392, 'Tapar el derrame con un pedazo de cartón sucio y no decirle a nadie.', false);
INSERT INTO public."QuizOptions" VALUES (21568, 5392, 'Apagar las luces del pasillo.', false);
INSERT INTO public."QuizOptions" VALUES (21569, 5393, 'Una calculadora científica de bolsillo.', false);
INSERT INTO public."QuizOptions" VALUES (21570, 5393, 'Un terminal de radiofrecuencia (Handheld o Colector de Datos).', true);
INSERT INTO public."QuizOptions" VALUES (21571, 5393, 'Un televisor portátil.', false);
INSERT INTO public."QuizOptions" VALUES (21572, 5393, 'Un radiotransmisor de onda corta.', false);
INSERT INTO public."QuizOptions" VALUES (21573, 5394, 'Para que el almacén se vea colorido como un arcoíris.', false);
INSERT INTO public."QuizOptions" VALUES (21574, 5394, 'Para garantizar que el tránsito de peatones esté separado de las rutas de circulación de montacargas y transpaletas motorizadas, evitando atropellos.', true);
INSERT INTO public."QuizOptions" VALUES (21575, 5394, 'Porque es un requisito para que la policía otorgue licencias de conducir.', false);
INSERT INTO public."QuizOptions" VALUES (21576, 5394, 'No tiene ninguna importancia, los peatones pueden caminar por cualquier sitio.', false);
INSERT INTO public."QuizOptions" VALUES (21577, 5395, 'Seguir un plan rígido por encima de responder a los cambios del entorno.', false);
INSERT INTO public."QuizOptions" VALUES (21578, 5395, 'Software o producto funcionando por encima de documentación exhaustiva.', true);
INSERT INTO public."QuizOptions" VALUES (21579, 5395, 'Negociar contratos hostiles por encima de colaborar con el cliente.', false);
INSERT INTO public."QuizOptions" VALUES (21580, 5395, 'Procesos y herramientas por encima de los individuos y sus interacciones.', false);
INSERT INTO public."QuizOptions" VALUES (21581, 5396, 'El Scrum Master.', false);
INSERT INTO public."QuizOptions" VALUES (21582, 5396, 'El Product Owner.', true);
INSERT INTO public."QuizOptions" VALUES (21583, 5396, 'El Director de Finanzas.', false);
INSERT INTO public."QuizOptions" VALUES (21584, 5396, 'El cliente que más grita.', false);
INSERT INTO public."QuizOptions" VALUES (21585, 5397, 'Asignar tareas individuales a cada programador y controlar su horario de entrada.', false);
INSERT INTO public."QuizOptions" VALUES (21586, 5397, 'Actuar como un líder servidor que ayuda a eliminar impedimentos y promueve las prácticas y valores de Scrum.', true);
INSERT INTO public."QuizOptions" VALUES (21587, 5397, 'Escribir todo el código fuente del proyecto él solo.', false);
INSERT INTO public."QuizOptions" VALUES (21588, 5397, 'Cobrar el dinero de las ventas a los clientes.', false);
INSERT INTO public."QuizOptions" VALUES (21589, 5398, '2 horas con presentaciones en diapositivas.', false);
INSERT INTO public."QuizOptions" VALUES (21590, 5398, 'Máximo 15 minutos, realizándose preferiblemente a la misma hora y lugar.', true);
INSERT INTO public."QuizOptions" VALUES (21591, 5398, 'Todo el día de trabajo.', false);
INSERT INTO public."QuizOptions" VALUES (21592, 5398, '30 segundos por mensaje de texto.', false);
INSERT INTO public."QuizOptions" VALUES (21593, 5399, 'Sprint Planning.', false);
INSERT INTO public."QuizOptions" VALUES (21594, 5399, 'Sprint Retrospective (Retrospectiva).', true);
INSERT INTO public."QuizOptions" VALUES (21595, 5399, 'Sprint Review.', false);
INSERT INTO public."QuizOptions" VALUES (21596, 5399, 'Reunión de accionistas anual.', false);
INSERT INTO public."QuizOptions" VALUES (21597, 5400, 'La cantidad de café que puede tomar el equipo al día.', false);
INSERT INTO public."QuizOptions" VALUES (21598, 5400, 'El número máximo de tareas o ítems de trabajo permitidos simultáneamente en una columna o etapa del flujo.', true);
INSERT INTO public."QuizOptions" VALUES (21599, 5400, 'El precio de compra de una tarjeta Kanban.', false);
INSERT INTO public."QuizOptions" VALUES (21600, 5400, 'La velocidad de conexión a internet del servidor.', false);
INSERT INTO public."QuizOptions" VALUES (21601, 5401, 'El aumento de sueldo que pide el equipo al final de cada mes.', false);
INSERT INTO public."QuizOptions" VALUES (21602, 5401, 'La suma de todos los elementos del Product Backlog completados durante el Sprint, en un estado funcional que cumple la Definición de Terminado (DoD).', true);
INSERT INTO public."QuizOptions" VALUES (21603, 5401, 'El incremento del presupuesto por retrasos.', false);
INSERT INTO public."QuizOptions" VALUES (21604, 5401, 'Una lista de promesas para el próximo año.', false);
INSERT INTO public."QuizOptions" VALUES (21605, 5402, 'Despedir a los miembros del equipo con menor desempeño.', false);
INSERT INTO public."QuizOptions" VALUES (21606, 5402, 'Mostrar el producto o incremento terminado a los interesados (stakeholders) y recibir retroalimentación para adaptar el futuro producto.', true);
INSERT INTO public."QuizOptions" VALUES (21607, 5402, 'Calcular los impuestos de fin de mes.', false);
INSERT INTO public."QuizOptions" VALUES (21608, 5402, 'Firmar contratos de trabajo nuevos.', false);
INSERT INTO public."QuizOptions" VALUES (21609, 5403, 'Una biografía novelada sobre la vida del cliente.', false);
INSERT INTO public."QuizOptions" VALUES (21610, 5403, 'Una descripción breve en lenguaje natural de una funcionalidad deseada, redactada desde la perspectiva del usuario final (Como... Quiero... Para...).', true);
INSERT INTO public."QuizOptions" VALUES (21611, 5403, 'Un manual técnico en código binario.', false);
INSERT INTO public."QuizOptions" VALUES (21612, 5403, 'La factura comercial por servicios prestados.', false);
INSERT INTO public."QuizOptions" VALUES (21613, 5404, 'Porque los calendarios se acaban a las 4 semanas.', false);
INSERT INTO public."QuizOptions" VALUES (21614, 5404, 'Para crear un ritmo constante (cadencia) predecible y limitar el riesgo financiero a un periodo corto de tiempo.', true);
INSERT INTO public."QuizOptions" VALUES (21615, 5404, 'Para que los desarrolladores no puedan tomar vacaciones.', false);
INSERT INTO public."QuizOptions" VALUES (21616, 5404, 'Porque la ley prohíbe reuniones que duren más de un mes.', false);
INSERT INTO public."QuizOptions" VALUES (21617, 5405, 'Oportunidades y Amenazas.', false);
INSERT INTO public."QuizOptions" VALUES (21618, 5405, 'Fortalezas y Debilidades.', true);
INSERT INTO public."QuizOptions" VALUES (21619, 5405, 'Políticos y Ecológicos.', false);
INSERT INTO public."QuizOptions" VALUES (21620, 5405, 'Inflación y Tipo de Cambio.', false);
INSERT INTO public."QuizOptions" VALUES (21621, 5406, 'Precios, Envío, Software, Teléfonos, Empleados y Licencias.', false);
INSERT INTO public."QuizOptions" VALUES (21622, 5406, 'Factores Políticos, Económicos, Sociales, Tecnológicos, Ecológicos y Legales.', true);
INSERT INTO public."QuizOptions" VALUES (21623, 5406, 'Pesos, Euros, Soles, Tarifas, Exportaciones y Logística.', false);
INSERT INTO public."QuizOptions" VALUES (21624, 5406, 'Pólizas, Estadísticas, Salarios, Turnos, Entrevistas y Liquidaciones.', false);
INSERT INTO public."QuizOptions" VALUES (21625, 5407, 'Que exista un solo proveedor monopólico en el país.', false);
INSERT INTO public."QuizOptions" VALUES (21626, 5407, 'Que existan múltiples proveedores que ofrezcan productos estandarizados con bajos costos de cambio para la empresa compradora.', true);
INSERT INTO public."QuizOptions" VALUES (21627, 5407, 'Que el insumo sea sumamente escaso y no existan sustitutos.', false);
INSERT INTO public."QuizOptions" VALUES (21628, 5407, 'Que el proveedor decida cerrar sus puertas.', false);
INSERT INTO public."QuizOptions" VALUES (21629, 5408, 'Debe ser una frase poética sin números.', false);
INSERT INTO public."QuizOptions" VALUES (21630, 5408, 'Debe ser obligatoriamente cuantitativo, medible y acotado en el tiempo para verificar inequívocamente su cumplimiento.', true);
INSERT INTO public."QuizOptions" VALUES (21631, 5408, 'Debe ser secreto y conocido únicamente por el CEO.', false);
INSERT INTO public."QuizOptions" VALUES (21632, 5408, 'Debe redactarse exclusivamente al final del año fiscal.', false);
INSERT INTO public."QuizOptions" VALUES (21633, 5409, 'Compras, Ventas, Almacén y Sistemas.', false);
INSERT INTO public."QuizOptions" VALUES (21634, 5409, 'Financiera, Clientes, Procesos Internos, y Aprendizaje y Crecimiento.', true);
INSERT INTO public."QuizOptions" VALUES (21635, 5409, 'Dirección, Supervisión, Operación y Seguridad.', false);
INSERT INTO public."QuizOptions" VALUES (21636, 5409, 'Entrada, Proceso, Salida y Desecho.', false);
INSERT INTO public."QuizOptions" VALUES (21637, 5410, 'En cerrar la empresa y mudarse de país.', false);
INSERT INTO public."QuizOptions" VALUES (21638, 5410, 'En utilizar las Fortalezas internas de la empresa para mitigar o neutralizar el impacto de las Amenazas del entorno externo.', true);
INSERT INTO public."QuizOptions" VALUES (21639, 5410, 'En aumentar los precios sin avisar a los clientes.', false);
INSERT INTO public."QuizOptions" VALUES (21640, 5410, 'En contratar a la competencia.', false);
INSERT INTO public."QuizOptions" VALUES (21641, 5411, 'Porque el cliente tiene un poder de negociación extremo y la pérdida de ese contrato provocaría la quiebra inmediata de la firma.', true);
INSERT INTO public."QuizOptions" VALUES (21642, 5411, 'Porque ese cliente paga más rápido de lo normal.', false);
INSERT INTO public."QuizOptions" VALUES (21643, 5411, 'Porque el banco rechaza depósitos grandes.', false);
INSERT INTO public."QuizOptions" VALUES (21644, 5411, 'No tiene ningún riesgo, es la situación ideal para cualquier compañía.', false);
INSERT INTO public."QuizOptions" VALUES (21645, 5412, 'La visión es para los empleados y la misión para los clientes.', false);
INSERT INTO public."QuizOptions" VALUES (21646, 5412, 'La Misión define el propósito y la razón de ser actual de la empresa, mientras que la Visión proyecta a dónde aspira llegar en el futuro a largo plazo.', true);
INSERT INTO public."QuizOptions" VALUES (21647, 5412, 'Son exactamente lo mismo con diferente ortografía.', false);
INSERT INTO public."QuizOptions" VALUES (21648, 5412, 'La misión es legalmente obligatoria y la visión es opcional.', false);
INSERT INTO public."QuizOptions" VALUES (21649, 5413, 'La cantidad de correos electrónicos que envía el personal al día.', false);
INSERT INTO public."QuizOptions" VALUES (21650, 5413, 'La eficiencia, calidad, tiempos de ciclo e innovación de las operaciones clave que generan valor para el cliente.', true);
INSERT INTO public."QuizOptions" VALUES (21651, 5413, 'El color de la pintura de la fachada del edificio.', false);
INSERT INTO public."QuizOptions" VALUES (21652, 5413, 'La cotización del dólar en el mercado paralelo.', false);
INSERT INTO public."QuizOptions" VALUES (21653, 5414, 'Cada 5 años.', false);
INSERT INTO public."QuizOptions" VALUES (21654, 5414, 'Trimestralmente (cada 3 meses).', true);
INSERT INTO public."QuizOptions" VALUES (21655, 5414, 'Cada 24 horas.', false);
INSERT INTO public."QuizOptions" VALUES (21656, 5414, 'Una vez por década.', false);
INSERT INTO public."QuizOptions" VALUES (21657, 5415, 'La misión es para los accionistas y los valores para el gobierno.', false);
INSERT INTO public."QuizOptions" VALUES (21658, 5415, 'La Misión define la actividad y propósito comercial actual de la organización, mientras que los Valores son los principios éticos no negociables que rigen la conducta.', true);
INSERT INTO public."QuizOptions" VALUES (21659, 5415, 'No existe ninguna diferencia; son términos sinónimos.', false);
INSERT INTO public."QuizOptions" VALUES (21660, 5415, 'La misión es un eslogan publicitario que se cambia cada semana.', false);
INSERT INTO public."QuizOptions" VALUES (21661, 5416, 'Tener una discusión acalorada sobre fútbol en el almuerzo.', false);
INSERT INTO public."QuizOptions" VALUES (21662, 5416, 'Una situación donde los intereses personales, familiares o económicos de un empleado interfieren o pueden influir indebidamente en su juicio profesional y decisiones laborales.', true);
INSERT INTO public."QuizOptions" VALUES (21663, 5416, 'Llegar 5 minutos tarde debido al tráfico vehicular.', false);
INSERT INTO public."QuizOptions" VALUES (21664, 5416, 'Pedir un aumento de salario anual.', false);
INSERT INTO public."QuizOptions" VALUES (21665, 5417, 'Aceptarlo en secreto y guardarlo en la mochila sin decir nada a nadie.', false);
INSERT INTO public."QuizOptions" VALUES (21666, 5417, 'Declararlo de inmediato al comité de ética o recursos humanos conforme a la política de regalos de la compañía y proceder a su devolución o donación institucional.', true);
INSERT INTO public."QuizOptions" VALUES (21667, 5417, 'Exigirle al proveedor que también le regale otro teléfono a su cónyuge.', false);
INSERT INTO public."QuizOptions" VALUES (21668, 5417, 'Vender el teléfono por internet para ganar dinero extra.', false);
INSERT INTO public."QuizOptions" VALUES (21669, 5418, 'Publicar rumores sobre la vida personal de los compañeros de trabajo.', false);
INSERT INTO public."QuizOptions" VALUES (21670, 5418, 'Permitir a los colaboradores reportar infracciones legales, acoso o fraudes de forma confidencial y protegida sin temor a represalias laborales.', true);
INSERT INTO public."QuizOptions" VALUES (21671, 5418, 'Pedir comida a domicilio sin pagar.', false);
INSERT INTO public."QuizOptions" VALUES (21672, 5418, 'Calificar los uniformes del personal.', false);
INSERT INTO public."QuizOptions" VALUES (21673, 5419, 'El compromiso legal de no revelar ni utilizar secretos comerciales, datos de clientes o información financiera sensible de la empresa fuera de las labores autorizadas.', true);
INSERT INTO public."QuizOptions" VALUES (21674, 5419, 'La obligación de no hablar con nadie durante las 8 horas de la jornada.', false);
INSERT INTO public."QuizOptions" VALUES (21675, 5419, 'Que el empleado renuncia a cobrar su sueldo.', false);
INSERT INTO public."QuizOptions" VALUES (21676, 5419, 'Que el trabajador no puede cambiarse de ropa.', false);
INSERT INTO public."QuizOptions" VALUES (21677, 5420, 'Pagar el triple de sueldo a los directores.', false);
INSERT INTO public."QuizOptions" VALUES (21678, 5420, 'Generar valor equilibrado en tres dimensiones: rentabilidad económica, justicia social y sostenibilidad ambiental.', true);
INSERT INTO public."QuizOptions" VALUES (21679, 5420, 'Abrir tres sucursales nuevas al año.', false);
INSERT INTO public."QuizOptions" VALUES (21680, 5420, 'Lanzar tres campañas de publicidad por televisión.', false);
INSERT INTO public."QuizOptions" VALUES (21681, 5421, 'El sistema para obligar a los clientes a comprar más productos.', false);
INSERT INTO public."QuizOptions" VALUES (21682, 5421, 'El conjunto de procedimientos y buenas prácticas para identificar y prevenir riesgos legales y regulatorios que puedan afectar a la empresa.', true);
INSERT INTO public."QuizOptions" VALUES (21683, 5421, 'La fiesta de aniversario de la compañía.', false);
INSERT INTO public."QuizOptions" VALUES (21684, 5421, 'El software de diseño gráfico de la empresa.', false);
INSERT INTO public."QuizOptions" VALUES (21685, 5422, 'Unirse a las burlas para no ser el siguiente blanco.', false);
INSERT INTO public."QuizOptions" VALUES (21686, 5422, 'No ser cómplice con el silencio y reportar la situación de forma objetiva a través de los canales institucionales de Recursos Humanos o Comité de Convivencia.', true);
INSERT INTO public."QuizOptions" VALUES (21687, 5422, 'Grabar vídeos para subirlos a TikTok con burlas.', false);
INSERT INTO public."QuizOptions" VALUES (21688, 5422, 'Fingir que no se dio cuenta de nada.', false);
INSERT INTO public."QuizOptions" VALUES (21689, 5423, 'Porque ahorra dinero en paredes de concreto.', false);
INSERT INTO public."QuizOptions" VALUES (21690, 5423, 'Porque construye confianza sólida con clientes, inversionistas y la sociedad, blindando la reputación ante crisis de mercado.', true);
INSERT INTO public."QuizOptions" VALUES (21691, 5423, 'Porque la ley prohíbe tener puertas cerradas en las oficinas.', false);
INSERT INTO public."QuizOptions" VALUES (21692, 5423, 'Para que los competidores copien los productos más fácilmente.', false);
INSERT INTO public."QuizOptions" VALUES (21693, 5424, 'Utilizar la impresora de la oficina para fotocopiar e imprimir volúmenes masivos de libros personales o para un negocio privado ajeno a la compañía.', true);
INSERT INTO public."QuizOptions" VALUES (21694, 5424, 'Apagar la computadora al terminar el turno de trabajo.', false);
INSERT INTO public."QuizOptions" VALUES (21695, 5424, 'Solicitar un bolígrafo nuevo cuando se agota la tinta del anterior.', false);
INSERT INTO public."QuizOptions" VALUES (21696, 5424, 'Lavarse las manos en los sanitarios del personal.', false);
INSERT INTO public."QuizOptions" VALUES (21697, 5425, 'Mirar fijamente al suelo para mostrar sumisión.', false);
INSERT INTO public."QuizOptions" VALUES (21698, 5425, 'Mantener contacto visual directo entre el 60% y 70% del tiempo para proyectar seguridad, empatía e interés genuino.', true);
INSERT INTO public."QuizOptions" VALUES (21699, 5425, 'Mirar la pantalla del teléfono celular todo el tiempo.', false);
INSERT INTO public."QuizOptions" VALUES (21700, 5425, 'Mirar fijamente a los ojos sin pestañear durante 15 minutos continuos.', false);
INSERT INTO public."QuizOptions" VALUES (21701, 5426, 'Amenazar al cliente con llamar a la policía.', false);
INSERT INTO public."QuizOptions" VALUES (21702, 5426, 'Ofrecer una disculpa empática e institucional por el inconveniente ocasionado sin tomárselo como un ataque personal.', true);
INSERT INTO public."QuizOptions" VALUES (21703, 5426, 'Aceptar que el empleado es culpable de todos los males del mundo.', false);
INSERT INTO public."QuizOptions" VALUES (21704, 5426, 'Anotar el nombre del cliente en una lista negra.', false);
INSERT INTO public."QuizOptions" VALUES (21705, 5427, 'Porque es una palabra en otro idioma.', false);
INSERT INTO public."QuizOptions" VALUES (21706, 5427, 'Porque descalifica sus emociones, suena condescendiente y le hace sentir incomprendido y minimizado.', true);
INSERT INTO public."QuizOptions" VALUES (21707, 5427, 'Porque es ilegal decirla en oficinas públicas.', false);
INSERT INTO public."QuizOptions" VALUES (21708, 5427, 'Porque provoca que el cliente hable más rápido.', false);
INSERT INTO public."QuizOptions" VALUES (21709, 5428, 'Repetir con nuestras propias palabras la necesidad expresada por el cliente para confirmar que la hemos entendido con exactitud.', true);
INSERT INTO public."QuizOptions" VALUES (21710, 5428, 'Cantar una canción para calmar el ambiente.', false);
INSERT INTO public."QuizOptions" VALUES (21711, 5428, 'Hablar con palabras técnicas complejas para impresionar al usuario.', false);
INSERT INTO public."QuizOptions" VALUES (21712, 5428, 'Inventar respuestas que no existen.', false);
INSERT INTO public."QuizOptions" VALUES (21713, 5429, 'Detractores.', false);
INSERT INTO public."QuizOptions" VALUES (21714, 5429, 'Promotores.', true);
INSERT INTO public."QuizOptions" VALUES (21715, 5429, 'Pasivos.', false);
INSERT INTO public."QuizOptions" VALUES (21716, 5429, 'Cancelados.', false);
INSERT INTO public."QuizOptions" VALUES (21717, 5430, 'Mantener una sonrisa amable y erguida.', false);
INSERT INTO public."QuizOptions" VALUES (21718, 5430, 'Estar recostado desganado, con los brazos cruzados y la mirada fija en el teléfono móvil.', true);
INSERT INTO public."QuizOptions" VALUES (21719, 5430, 'Saludar con un tono de voz cordial y enérgico.', false);
INSERT INTO public."QuizOptions" VALUES (21720, 5430, 'Asentir con la cabeza mientras el cliente explica su problema.', false);
INSERT INTO public."QuizOptions" VALUES (21721, 5431, 'Para que el empleado pueda ir al baño.', false);
INSERT INTO public."QuizOptions" VALUES (21722, 5431, 'Para permitir que libere la carga emocional inicial, tras lo cual la persona estará mucho más receptiva para escuchar una solución racional.', true);
INSERT INTO public."QuizOptions" VALUES (21723, 5431, 'Porque la ley exige no hablar los primeros 2 minutos.', false);
INSERT INTO public."QuizOptions" VALUES (21724, 5431, 'Para memorizar su tono de voz.', false);
INSERT INTO public."QuizOptions" VALUES (21725, 5432, '''No sé de qué me habla''.', false);
INSERT INTO public."QuizOptions" VALUES (21726, 5432, '''Con mucho gusto le acompaño o le comunico con el área especializada para que le atiendan de inmediato''.', true);
INSERT INTO public."QuizOptions" VALUES (21727, 5432, '''Vuelva la próxima semana a ver si hay alguien''.', false);
INSERT INTO public."QuizOptions" VALUES (21728, 5432, '''Vaya a quejarse con el gerente si no le gusta''.', false);
INSERT INTO public."QuizOptions" VALUES (21729, 5433, 'Gritar muy fuerte cuando entra una persona al local.', false);
INSERT INTO public."QuizOptions" VALUES (21730, 5433, 'Superar gratamente las expectativas del cliente con un detalle de servicio inesperado y memorable.', true);
INSERT INTO public."QuizOptions" VALUES (21731, 5433, 'Cobrar el doble de lo acordado.', false);
INSERT INTO public."QuizOptions" VALUES (21732, 5433, 'Apagar las luces del local por sorpresa.', false);
INSERT INTO public."QuizOptions" VALUES (21733, 5434, 'Porque no cuesta nada fabricar productos para clientes viejos.', false);
INSERT INTO public."QuizOptions" VALUES (21734, 5434, 'Porque captar un nuevo cliente exige cuantiosas inversiones en publicidad y prospección, mientras que el cliente fiel ya confía y recompra a menor costo.', true);
INSERT INTO public."QuizOptions" VALUES (21735, 5434, 'Porque los clientes nuevos siempre pagan con billetes rotos.', false);
INSERT INTO public."QuizOptions" VALUES (21736, 5434, 'Porque las leyes impiden buscar clientes nuevos.', false);
INSERT INTO public."QuizOptions" VALUES (21737, 5435, 'Que nunca se debe pedir perdón a los clientes bajo ninguna circunstancia.', false);
INSERT INTO public."QuizOptions" VALUES (21738, 5435, 'El fenómeno en el que un cliente que sufrió una falla, al recibir una solución excepcionalmente rápida y empática, termina teniendo un nivel de lealtad mayor que un cliente que nunca tuvo problemas.', true);
INSERT INTO public."QuizOptions" VALUES (21739, 5435, 'Que las máquinas de café en la oficina siempre se descomponen.', false);
INSERT INTO public."QuizOptions" VALUES (21740, 5435, 'Que los clientes que no se quejan nunca vuelven a comprar.', false);
INSERT INTO public."QuizOptions" VALUES (21741, 5436, 'Facturación de Crédito Rápida.', false);
INSERT INTO public."QuizOptions" VALUES (21742, 5436, 'Resolución en el Primer Contacto: el porcentaje de casos solucionados en la primera interacción sin requerir llamadas o trámites posteriores.', true);
INSERT INTO public."QuizOptions" VALUES (21743, 5436, 'Firma de Contratos de Redes.', false);
INSERT INTO public."QuizOptions" VALUES (21744, 5436, 'Filtro de Correos Rechazados.', false);
INSERT INTO public."QuizOptions" VALUES (21745, 5437, 'Dejar caer el auricular sobre la mesa caliente.', false);
INSERT INTO public."QuizOptions" VALUES (21746, 5437, 'Poner al cliente en espera, explicarle al compañero receptor quién llama y cuál es su caso, y luego conectar la comunicación para que el cliente no tenga que repetir todo.', true);
INSERT INTO public."QuizOptions" VALUES (21747, 5437, 'Gritarle al compañero a través de toda la oficina.', false);
INSERT INTO public."QuizOptions" VALUES (21748, 5437, 'Colgarle al cliente y pedirle que vuelva a marcar otra extensión.', false);
INSERT INTO public."QuizOptions" VALUES (21749, 5438, 'La cantidad de calorías que gasta el cliente al caminar hasta la tienda.', false);
INSERT INTO public."QuizOptions" VALUES (21750, 5438, 'El grado de facilidad o esfuerzo que tuvo que hacer el cliente para que la empresa resolviera su solicitud o reclamo.', true);
INSERT INTO public."QuizOptions" VALUES (21751, 5438, 'El precio de compra del producto.', false);
INSERT INTO public."QuizOptions" VALUES (21752, 5438, 'La cantidad de años que tiene la empresa funcionando.', false);
INSERT INTO public."QuizOptions" VALUES (21753, 5439, 'El sueldo que cobrará el agente de soporte.', false);
INSERT INTO public."QuizOptions" VALUES (21754, 5439, 'El compromiso formal y medible de tiempos de respuesta y solución pactados entre el proveedor del servicio y el cliente.', true);
INSERT INTO public."QuizOptions" VALUES (21755, 5439, 'El manual de instalación del sistema operativo.', false);
INSERT INTO public."QuizOptions" VALUES (21756, 5439, 'La lista de días festivos del año.', false);
INSERT INTO public."QuizOptions" VALUES (21757, 5440, 'Porque las redes sociales cobran dinero por debatir.', false);
INSERT INTO public."QuizOptions" VALUES (21758, 5440, 'Porque expone negativamente a la marca frente a miles de espectadores; lo profesional es dar una respuesta inicial empática y canalizar el caso por mensaje privado.', true);
INSERT INTO public."QuizOptions" VALUES (21759, 5440, 'Porque el cliente siempre tiene poderes mágicos.', false);
INSERT INTO public."QuizOptions" VALUES (21760, 5440, 'Porque las computadoras se sobrecalientan.', false);
INSERT INTO public."QuizOptions" VALUES (21761, 5441, 'Ninguno, porque el teléfono solo transmite imágenes.', false);
INSERT INTO public."QuizOptions" VALUES (21762, 5441, 'Modifica físicamente la posición de los músculos faciales y resonadores bucales, haciendo que el tono de voz suene naturalmente más cálido, amable y acogedor.', true);
INSERT INTO public."QuizOptions" VALUES (21763, 5441, 'Hace que la llamada se corte de inmediato.', false);
INSERT INTO public."QuizOptions" VALUES (21764, 5441, 'Aumenta el costo por minuto de la llamada.', false);
INSERT INTO public."QuizOptions" VALUES (21765, 5442, 'Escribir en mayúsculas sostenidas y sin signos de puntuación.', false);
INSERT INTO public."QuizOptions" VALUES (21766, 5442, 'Saludar cordialmente con su nombre, agradecer el reporte, explicar con claridad la causa y solución paso a paso, y dejar abierta la vía de contacto.', true);
INSERT INTO public."QuizOptions" VALUES (21767, 5442, 'Enviar solo un enlace sin texto explicativo.', false);
INSERT INTO public."QuizOptions" VALUES (21768, 5442, 'Copiar a todos los empleados de la empresa para que se burlen.', false);
INSERT INTO public."QuizOptions" VALUES (21769, 5443, 'Sumando todas las quejas del mes.', false);
INSERT INTO public."QuizOptions" VALUES (21770, 5443, 'Dividiendo el número de respuestas positivas (calificaciones 4 y 5) entre el total de encuestas respondidas y multiplicando por 100.', true);
INSERT INTO public."QuizOptions" VALUES (21771, 5443, 'Contando los clics en el botón de salida.', false);
INSERT INTO public."QuizOptions" VALUES (21772, 5443, 'Multiplicando las horas trabajadas por el número de agentes.', false);
INSERT INTO public."QuizOptions" VALUES (21773, 5444, '45 minutos.', false);
INSERT INTO public."QuizOptions" VALUES (21774, 5444, 'No más de 60 a 90 segundos sin regresar para agradecer su paciencia e informarle que se sigue gestionando su consulta.', true);
INSERT INTO public."QuizOptions" VALUES (21775, 5444, 'Todo el día hasta que se canse y cuelgue.', false);
INSERT INTO public."QuizOptions" VALUES (21776, 5444, 'Exactamente 10 milisegundos.', false);
INSERT INTO public."QuizOptions" VALUES (21777, 5445, 'La Autorregulación emocional.', true);
INSERT INTO public."QuizOptions" VALUES (21778, 5445, 'La memoria fotográfica.', false);
INSERT INTO public."QuizOptions" VALUES (21779, 5445, 'El cálculo aritmético veloz.', false);
INSERT INTO public."QuizOptions" VALUES (21780, 5445, 'La ambición desmedida de poder.', false);
INSERT INTO public."QuizOptions" VALUES (21781, 5446, 'Que todos los miembros fueran egresados de las mismas universidades de élite.', false);
INSERT INTO public."QuizOptions" VALUES (21782, 5446, 'La Seguridad Psicológica: la confianza de que el equipo es un entorno seguro para asumir riesgos, admitir dudas y cometer errores sin ser juzgado.', true);
INSERT INTO public."QuizOptions" VALUES (21783, 5446, 'Tener la oficina con los muebles más caros y mesas de billar.', false);
INSERT INTO public."QuizOptions" VALUES (21784, 5446, 'Trabajar 16 horas diarias sin descansar.', false);
INSERT INTO public."QuizOptions" VALUES (21785, 5447, 'Sueldo, Bonificación, Impuestos.', false);
INSERT INTO public."QuizOptions" VALUES (21786, 5447, 'Situación (el momento concreto), Conducta (el hecho observable sin juicios) e Impacto (la consecuencia que provocó).', true);
INSERT INTO public."QuizOptions" VALUES (21787, 5447, 'Saludos, Burlas, Insultos.', false);
INSERT INTO public."QuizOptions" VALUES (21788, 5447, 'Sanción, Boicot, Indemnización.', false);
INSERT INTO public."QuizOptions" VALUES (21789, 5448, 'Todos los miembros del equipo deben tener la misma personalidad para no discutir jamás.', false);
INSERT INTO public."QuizOptions" VALUES (21790, 5448, 'Los equipos de alto desempeño requieren una combinación equilibrada de roles orientados a la acción, a las personas y al pensamiento cerebral.', true);
INSERT INTO public."QuizOptions" VALUES (21791, 5448, 'El equipo solo debe tener un líder que trabaje y los demás observen.', false);
INSERT INTO public."QuizOptions" VALUES (21792, 5448, 'Los roles se asignan por sorteo de lotería.', false);
INSERT INTO public."QuizOptions" VALUES (21793, 5449, 'Trabajar solo 2 minutos al día.', false);
INSERT INTO public."QuizOptions" VALUES (21794, 5449, 'Si una tarea pendiente te toma menos de dos minutos en completarse, realízala de inmediato en lugar de agendarla o posponerla.', true);
INSERT INTO public."QuizOptions" VALUES (21795, 5449, 'Tomar una siesta de dos minutos en la oficina.', false);
INSERT INTO public."QuizOptions" VALUES (21796, 5449, 'Llegar a las reuniones dos minutos tarde.', false);
INSERT INTO public."QuizOptions" VALUES (21798, 5450, 'Atacar la personalidad o carácter de la persona (ej. ''Eres un irresponsable'') en lugar de describir el hecho específico objetivo.', true);
INSERT INTO public."QuizOptions" VALUES (21799, 5450, 'Agradecer sus contribuciones positivas.', false);
INSERT INTO public."QuizOptions" VALUES (21800, 5450, 'Proponer acciones de mejora conjunta.', false);
INSERT INTO public."QuizOptions" VALUES (21801, 5451, 'Una operación quirúrgica de garganta.', false);
INSERT INTO public."QuizOptions" VALUES (21802, 5451, 'Una reacción emocional instintiva e intensa desencadenada por el cerebro límbico que anula temporalmente la lógica racional ante una amenaza percibida.', true);
INSERT INTO public."QuizOptions" VALUES (21803, 5451, 'Un virus informático que borra hojas de cálculo.', false);
INSERT INTO public."QuizOptions" VALUES (21804, 5451, 'Una técnica de meditación zen.', false);
INSERT INTO public."QuizOptions" VALUES (21805, 5452, 'Gritar con furia.', false);
INSERT INTO public."QuizOptions" VALUES (21806, 5452, 'Identificar y expresar los sentimientos y necesidades reales no satisfechas.', true);
INSERT INTO public."QuizOptions" VALUES (21807, 5452, 'Amenazar con una demanda judicial.', false);
INSERT INTO public."QuizOptions" VALUES (21808, 5452, 'Guardar rencor durante años.', false);
INSERT INTO public."QuizOptions" VALUES (21809, 5453, 'Porque son demasiado inteligentes para trabajar.', false);
INSERT INTO public."QuizOptions" VALUES (21810, 5453, 'Porque abundan las ideas pero carecen de roles ejecutores, finalizadores y organizadores que aterricen los proyectos a la realidad concreta.', true);
INSERT INTO public."QuizOptions" VALUES (21811, 5453, 'Porque la creatividad está prohibida en las empresas.', false);
INSERT INTO public."QuizOptions" VALUES (21812, 5453, 'Porque las computadoras no soportan tantas ideas.', false);
INSERT INTO public."QuizOptions" VALUES (21813, 5454, 'Que los grandes cambios solo ocurren de golpe mediante sacrificios sobrehumanos.', false);
INSERT INTO public."QuizOptions" VALUES (21814, 5454, 'Que pequeñas mejoras del 1% sostenidas con consistencia diaria generan transformaciones masivas acumuladas a lo largo del tiempo.', true);
INSERT INTO public."QuizOptions" VALUES (21815, 5454, 'Que hay que trabajar de noche para ser exitoso.', false);
INSERT INTO public."QuizOptions" VALUES (21816, 5454, 'Que los hábitos no tienen ninguna influencia en la productividad.', false);
INSERT INTO public."QuizOptions" VALUES (21817, 5455, 'Delegación total sin supervisión.', false);
INSERT INTO public."QuizOptions" VALUES (21818, 5455, 'Estilo Directivo / Ordenar (E1), con instrucciones concretas paso a paso y seguimiento cercano.', true);
INSERT INTO public."QuizOptions" VALUES (21819, 5455, 'Ignorarlo hasta que aprenda por sí solo.', false);
INSERT INTO public."QuizOptions" VALUES (21820, 5455, 'Nombrarlo de inmediato gerente general.', false);
INSERT INTO public."QuizOptions" VALUES (21821, 5456, 'Revisar cada tarea minuciosa de la lista de pendientes del día.', false);
INSERT INTO public."QuizOptions" VALUES (21822, 5456, 'Crear un espacio seguro centrado en el desarrollo profesional del empleado, su bienestar, motivación y eliminación de bloqueos en el trabajo.', true);
INSERT INTO public."QuizOptions" VALUES (21823, 5456, 'Amonestar formalmente al colaborador por llegar tarde.', false);
INSERT INTO public."QuizOptions" VALUES (21824, 5456, 'Hacerle firmar renuncias en blanco.', false);
INSERT INTO public."QuizOptions" VALUES (21825, 5457, 'La fabricación de microchips para computadoras.', false);
INSERT INTO public."QuizOptions" VALUES (21826, 5457, 'El control excesivo y obsesivo de cada detalle y paso que da el empleado, destruyendo su autonomía, creatividad y motivación.', true);
INSERT INTO public."QuizOptions" VALUES (21827, 5457, 'El pago puntual de los sueldos en quincena.', false);
INSERT INTO public."QuizOptions" VALUES (21828, 5457, 'La entrega de reconocimientos públicos a los empleados destacados.', false);
INSERT INTO public."QuizOptions" VALUES (21829, 5458, 'No hay diferencia, significan lo mismo.', false);
INSERT INTO public."QuizOptions" VALUES (21830, 5458, 'Delegar define claramente el resultado esperado, otorga autonomía con criterios claros y establece fechas fijas de control y rendición de cuentas compartida.', true);
INSERT INTO public."QuizOptions" VALUES (21831, 5458, 'Delegar es gratis y abdicar tiene costo bancario.', false);
INSERT INTO public."QuizOptions" VALUES (21832, 5458, 'Delegar solo se puede hacer con parientes.', false);
INSERT INTO public."QuizOptions" VALUES (21833, 5459, 'Ignorar las malas noticias y fingir que todo es maravilloso.', false);
INSERT INTO public."QuizOptions" VALUES (21834, 5459, 'Mantener una fe inquebrantable en el triunfo final y, al mismo tiempo, encarar con total honestidad los hechos más crudos de la realidad presente.', true);
INSERT INTO public."QuizOptions" VALUES (21835, 5459, 'Abandonar el barco al primer signo de dificultad.', false);
INSERT INTO public."QuizOptions" VALUES (21836, 5459, 'Culpar a la economía de todos los fracasos.', false);
INSERT INTO public."QuizOptions" VALUES (21837, 5460, 'Humillarlo en público ante toda la empresa para que aprenda.', false);
INSERT INTO public."QuizOptions" VALUES (21838, 5460, 'Analizar conjuntamente el fallo como una oportunidad de aprendizaje, identificando la causa raíz y medidas correctivas sin cacería de brujas.', true);
INSERT INTO public."QuizOptions" VALUES (21839, 5460, 'Retirarle toda su autonomía para siempre.', false);
INSERT INTO public."QuizOptions" VALUES (21840, 5460, 'Despedirlo de inmediato sin liquidación.', false);
INSERT INTO public."QuizOptions" VALUES (21841, 5461, 'Porque los empleados son más inteligentes que los jefes.', false);
INSERT INTO public."QuizOptions" VALUES (21842, 5461, 'Porque genera fuga de talento cualificado, resentimiento, desmotivación profunda y cumplimiento mediocre por mero miedo.', true);
INSERT INTO public."QuizOptions" VALUES (21843, 5461, 'Porque está prohibido por las normas ISO 9001.', false);
INSERT INTO public."QuizOptions" VALUES (21844, 5461, 'Porque las computadoras no obedecen órdenes autoritarias.', false);
INSERT INTO public."QuizOptions" VALUES (21845, 5462, '''¿Verdad que soy el mejor jefe que has tenido en tu vida?''', false);
INSERT INTO public."QuizOptions" VALUES (21846, 5462, '''¿Hay algo que yo esté haciendo que obstaculice tu trabajo o algo que te gustaría que hiciera de manera diferente para apoyarte mejor?''', true);
INSERT INTO public."QuizOptions" VALUES (21847, 5462, '''¿Por qué no trabajas más horas?''', false);
INSERT INTO public."QuizOptions" VALUES (21848, 5462, '''¿Qué chisme me tienes de tus compañeros?''', false);
INSERT INTO public."QuizOptions" VALUES (21849, 5463, 'Que el colaborador renuncia a su contrato.', false);
INSERT INTO public."QuizOptions" VALUES (21850, 5463, 'Que el colaborador tiene plena facultad para decidir y actuar según su criterio profesional, rindiendo cuentas solo de los resultados consolidados o contingencias mayores.', true);
INSERT INTO public."QuizOptions" VALUES (21851, 5463, 'Que el líder tiene que firmar cada hoja de papel que se usa.', false);
INSERT INTO public."QuizOptions" VALUES (21852, 5463, 'Que nadie sabe qué hace esa persona en la oficina.', false);
INSERT INTO public."QuizOptions" VALUES (21853, 5464, 'Para recibir una multa económica.', false);
INSERT INTO public."QuizOptions" VALUES (21854, 5464, 'Porque el liderazgo ético implica proteger al equipo hacia afuera y corregir con firmeza y pedagogía hacia adentro, ganando respeto y lealtad absoluta.', true);
INSERT INTO public."QuizOptions" VALUES (21855, 5464, 'Para que lo despidan en lugar de sus compañeros.', false);
INSERT INTO public."QuizOptions" VALUES (21856, 5464, 'Porque las leyes lo obligan por contrato notariado.', false);
INSERT INTO public."QuizOptions" VALUES (21857, 5465, 'La posición es secreta y el interés es público.', false);
INSERT INTO public."QuizOptions" VALUES (21858, 5465, 'La Posición es la demanda explícita y concreta que una parte exige (''Quiero un 20% de aumento''), mientras que el Interés es la necesidad profunda subyacente que motiva esa exigencia (''Necesito cubrir el alza de costos familiares'').', true);
INSERT INTO public."QuizOptions" VALUES (21859, 5465, 'Son conceptos idénticos que se usan de forma indistinta.', false);
INSERT INTO public."QuizOptions" VALUES (21860, 5465, 'La posición solo la tiene el comprador y el interés solo el vendedor.', false);
INSERT INTO public."QuizOptions" VALUES (21861, 5466, 'Margen Anual de Activos Netos.', false);
INSERT INTO public."QuizOptions" VALUES (21862, 5466, 'Mejor Alternativa a un Acuerdo Negociado (Best Alternative to a Negotiated Agreement).', true);
INSERT INTO public."QuizOptions" VALUES (21863, 5466, 'Matriz de Asignación de Nombres.', false);
INSERT INTO public."QuizOptions" VALUES (21864, 5466, 'Monto Acordado Antes de Negociar.', false);
INSERT INTO public."QuizOptions" VALUES (21865, 5467, 'Porque le permite gritar más fuerte en la reunión.', false);
INSERT INTO public."QuizOptions" VALUES (21866, 5467, 'Porque le da la libertad y tranquilidad de levantarse de la mesa y rechazar un mal acuerdo si la oferta recibida es inferior a su alternativa externa.', true);
INSERT INTO public."QuizOptions" VALUES (21867, 5467, 'Porque el banco aprueba préstamos gratis a quienes tienen un MAAN.', false);
INSERT INTO public."QuizOptions" VALUES (21868, 5467, 'Porque elimina la necesidad de hablar con la contraparte.', false);
INSERT INTO public."QuizOptions" VALUES (21869, 5468, 'El salón donde se reúnen los diplomáticos de la ONU.', false);
INSERT INTO public."QuizOptions" VALUES (21870, 5468, 'El rango superpuesto entre el precio de reserva máximo del comprador y el precio de reserva mínimo del vendedor donde un acuerdo es mutuamente ventajoso.', true);
INSERT INTO public."QuizOptions" VALUES (21871, 5468, 'La distancia física de dos metros entre negociadores.', false);
INSERT INTO public."QuizOptions" VALUES (21872, 5468, 'Un tipo de contrato de arrendamiento comercial.', false);
INSERT INTO public."QuizOptions" VALUES (21873, 5469, 'Despedir a todas las personas antes de empezar a negociar.', false);
INSERT INTO public."QuizOptions" VALUES (21874, 5469, 'Tratar a los interlocutores con absoluto respeto humano y empatía, mientras se abordan los asuntos técnicos y sustantivos con rigor y firmeza.', true);
INSERT INTO public."QuizOptions" VALUES (21875, 5469, 'Insultar al rival para intimidarlo desde el inicio.', false);
INSERT INTO public."QuizOptions" VALUES (21876, 5469, 'Negociar únicamente por correo sin ver caras nunca.', false);
INSERT INTO public."QuizOptions" VALUES (21877, 5470, 'Porque las leyes tributarias lo sancionan con multas.', false);
INSERT INTO public."QuizOptions" VALUES (21878, 5470, 'Porque la contraparte asume que la concesión no tenía costo real para ti y que tus precios estaban inflados, motivándola a exigir mayores descuentos.', true);
INSERT INTO public."QuizOptions" VALUES (21879, 5470, 'Porque la calculadora se desconfigura.', false);
INSERT INTO public."QuizOptions" VALUES (21880, 5470, 'Porque el banco rechaza la factura.', false);
INSERT INTO public."QuizOptions" VALUES (21881, 5471, 'El peso del contrato en gramos de papel.', false);
INSERT INTO public."QuizOptions" VALUES (21882, 5471, 'El sesgo cognitivo por el cual la primera cifra propuesta en la mesa sirve como punto de referencia psicológico alrededor del cual gravitarán las ofertas posteriores.', true);
INSERT INTO public."QuizOptions" VALUES (21883, 5471, 'El ancla de los barcos de carga en aduana.', false);
INSERT INTO public."QuizOptions" VALUES (21884, 5471, 'La firma manuscrita de un testigo legal.', false);
INSERT INTO public."QuizOptions" VALUES (21885, 5472, 'La táctica del Salchichón.', false);
INSERT INTO public."QuizOptions" VALUES (21886, 5472, 'La táctica del Policía Bueno / Policía Malo (Good Cop / Bad Cop).', true);
INSERT INTO public."QuizOptions" VALUES (21887, 5472, 'La táctica del Anclaje Neutro.', false);
INSERT INTO public."QuizOptions" VALUES (21888, 5472, 'El método de Ishikawa.', false);
INSERT INTO public."QuizOptions" VALUES (21889, 5473, 'Aceptando de inmediato con lágrimas en los ojos.', false);
INSERT INTO public."QuizOptions" VALUES (21890, 5473, 'Manteniendo la compostura, ignorando el dramatismo del ultimátum y enfocando la conversación en los criterios objetivos de mercado o solicitando un receso para evaluar.', true);
INSERT INTO public."QuizOptions" VALUES (21891, 5473, 'Golpeando la mesa con un puño.', false);
INSERT INTO public."QuizOptions" VALUES (21892, 5473, 'Firmando el contrato con un seudónimo.', false);
INSERT INTO public."QuizOptions" VALUES (21893, 5474, 'Determinar quién tiene el auto más moderno en la reunión.', false);
INSERT INTO public."QuizOptions" VALUES (21894, 5474, 'Apoyar los acuerdos en estándares independientes, profesionales y legales (precios de mercado, peritajes, índices de inflación) en lugar de voluntades caprichosas.', true);
INSERT INTO public."QuizOptions" VALUES (21895, 5474, 'Garantizar que nadie pueda hablar durante la negociación.', false);
INSERT INTO public."QuizOptions" VALUES (21896, 5474, 'Redactar contratos en idiomas antiguos.', false);
INSERT INTO public."QuizOptions" VALUES (21897, 5475, 'Eliminarlas inmediatamente de la memoria.', false);
INSERT INTO public."QuizOptions" VALUES (21898, 5475, 'Programar bloques de tiempo específicos en el calendario para ejecutarlas con enfoque y anticipación.', true);
INSERT INTO public."QuizOptions" VALUES (21899, 5475, 'Hacerlas corriendo cuando ya se convirtieron en emergencias críticas.', false);
INSERT INTO public."QuizOptions" VALUES (21900, 5475, 'Delegárselas al empleado más nuevo.', false);
INSERT INTO public."QuizOptions" VALUES (21901, 5476, '10 minutos.', false);
INSERT INTO public."QuizOptions" VALUES (21902, 5476, '25 minutos de trabajo ininterrumpido seguidos de 5 minutos de descanso.', true);
INSERT INTO public."QuizOptions" VALUES (21903, 5476, '4 horas seguidas sin parpadear.', false);
INSERT INTO public."QuizOptions" VALUES (21904, 5476, '60 segundos.', false);
INSERT INTO public."QuizOptions" VALUES (21905, 5477, 'Que los empleados siempre tiemblan al ver al jefe.', false);
INSERT INTO public."QuizOptions" VALUES (21906, 5477, 'Que el trabajo se expande hasta llenar todo el tiempo asignado o disponible para su culminación.', true);
INSERT INTO public."QuizOptions" VALUES (21907, 5477, 'Que las máquinas de café fallan los lunes.', false);
INSERT INTO public."QuizOptions" VALUES (21908, 5477, 'Que el tiempo no existe en el cerebro humano.', false);
INSERT INTO public."QuizOptions" VALUES (21909, 5478, 'En no mirar el reloj en todo el día.', false);
INSERT INTO public."QuizOptions" VALUES (21910, 5478, 'En reservar bloques específicos de tiempo en el calendario para dedicarse de forma exclusiva a una tarea o proyecto concreto.', true);
INSERT INTO public."QuizOptions" VALUES (21911, 5478, 'En apagar las luces de la oficina a las 5:00 pm.', false);
INSERT INTO public."QuizOptions" VALUES (21912, 5478, 'En bloquear a los compañeros de trabajo en WhatsApp.', false);
INSERT INTO public."QuizOptions" VALUES (21913, 5479, 'Aumento del coeficiente intelectual en un 50%.', false);
INSERT INTO public."QuizOptions" VALUES (21914, 5479, 'Residuo de atención (Attention Residue): parte de la capacidad mental queda anclada en la tarea anterior, reduciendo la lucidez y duplicando los errores.', true);
INSERT INTO public."QuizOptions" VALUES (21915, 5479, 'Mejora de la vista a larga distancia.', false);
INSERT INTO public."QuizOptions" VALUES (21916, 5479, 'Desaparición total del estrés laboral.', false);
INSERT INTO public."QuizOptions" VALUES (21917, 5480, 'Borrar todos los correos sin leerlos.', false);
INSERT INTO public."QuizOptions" VALUES (21918, 5480, 'Agrupar la revisión y respuesta de correos en momentos o ventanas horarias específicas y fijas del día en lugar de responder a cada notificación en tiempo real.', true);
INSERT INTO public."QuizOptions" VALUES (21919, 5480, 'Enviar el mismo correo a 1000 personas por error.', false);
INSERT INTO public."QuizOptions" VALUES (21920, 5480, 'Imprimir todos los correos en papel bond.', false);
INSERT INTO public."QuizOptions" VALUES (21921, 5481, 'Cavar zanjas poco profundas en construcción.', false);
INSERT INTO public."QuizOptions" VALUES (21922, 5481, 'Tareas logísticas o administrativas de bajo esfuerzo cognitivo (responder mensajes breves, clasificar archivos) que no crean valor duradero ni son difíciles de replicar.', true);
INSERT INTO public."QuizOptions" VALUES (21923, 5481, 'Trabajar únicamente 2 horas a la semana.', false);
INSERT INTO public."QuizOptions" VALUES (21924, 5481, 'El trabajo que se realiza en el agua.', false);
INSERT INTO public."QuizOptions" VALUES (21925, 5482, 'Una fuga de agua que inunda el almacén principal.', false);
INSERT INTO public."QuizOptions" VALUES (21926, 5482, 'La preparación de una propuesta comercial para el cliente más grande del año.', false);
INSERT INTO public."QuizOptions" VALUES (21927, 5482, 'Navegar de manera compulsiva y pasiva por redes sociales o ver vídeos intrascendentes durante horas laborales.', true);
INSERT INTO public."QuizOptions" VALUES (21928, 5482, 'El pago obligatorio de los impuestos de la empresa antes de las 12:00 pm.', false);
INSERT INTO public."QuizOptions" VALUES (21929, 5483, 'Revisar inmediatamente las noticias de crisis o discutir en Twitter.', false);
INSERT INTO public."QuizOptions" VALUES (21930, 5483, 'Levantarse de la silla, estirar el cuerpo, hidratarse, caminar unos pasos o descansar la vista lejos de cualquier pantalla.', true);
INSERT INTO public."QuizOptions" VALUES (21931, 5483, 'Jugar un videojuego de alta intensidad.', false);
INSERT INTO public."QuizOptions" VALUES (21932, 5483, 'Comenzar a escribir otro informe urgente.', false);
INSERT INTO public."QuizOptions" VALUES (21933, 5484, 'Porque demuestra que la persona es antipática y hostil.', false);
INSERT INTO public."QuizOptions" VALUES (21934, 5484, 'Porque cada vez que dices ''SÍ'' a compromisos ajenos irrelevantes, le estás diciendo ''NO'' por defecto a tus metas estratégicas prioritarias.', true);
INSERT INTO public."QuizOptions" VALUES (21935, 5484, 'Porque está prohibido aceptar favores en el trabajo.', false);
INSERT INTO public."QuizOptions" VALUES (21936, 5484, 'Para que nadie te vuelva a hablar en la oficina.', false);
INSERT INTO public."QuizOptions" VALUES (21937, 5485, 'Parar, Analizar y Salir.', false);
INSERT INTO public."QuizOptions" VALUES (21938, 5485, 'Proteger (asegurar el entorno), Avisar (llamar a emergencias) y Socorrer (atender a la víctima).', true);
INSERT INTO public."QuizOptions" VALUES (21939, 5485, 'Presionar, Aliviar y Sanar.', false);
INSERT INTO public."QuizOptions" VALUES (21940, 5485, 'Preguntar, Abrigar y Sentar.', false);
INSERT INTO public."QuizOptions" VALUES (21941, 5486, '30 a 50 compresiones por minuto.', false);
INSERT INTO public."QuizOptions" VALUES (21942, 5486, 'Entre 100 y 120 compresiones por minuto.', true);
INSERT INTO public."QuizOptions" VALUES (21943, 5486, '200 a 300 compresiones por minuto.', false);
INSERT INTO public."QuizOptions" VALUES (21944, 5486, 'Una compresión cada 10 minutos.', false);
INSERT INTO public."QuizOptions" VALUES (21945, 5487, 'Sobre el lado izquierdo de las costillas bajas.', false);
INSERT INTO public."QuizOptions" VALUES (21946, 5487, 'En el centro del pecho, en la mitad inferior del hueso esternón.', true);
INSERT INTO public."QuizOptions" VALUES (21947, 5487, 'En la boca del estómago (abdomen blando).', false);
INSERT INTO public."QuizOptions" VALUES (21948, 5487, 'En el cuello sobre la carótida.', false);
INSERT INTO public."QuizOptions" VALUES (21949, 5488, 'Golpearle la espalda fuertemente de inmediato.', false);
INSERT INTO public."QuizOptions" VALUES (21950, 5488, 'Animarle a seguir tosiendo con fuerza sin interferir físicamente ni darle líquidos.', true);
INSERT INTO public."QuizOptions" VALUES (21951, 5488, 'Hacerle beber un vaso grande de agua fría.', false);
INSERT INTO public."QuizOptions" VALUES (21952, 5488, 'Tirarlo al suelo de espaldas.', false);
INSERT INTO public."QuizOptions" VALUES (21953, 5489, 'Compresiones firmes hacia adentro y hacia arriba en la boca del estómago (entre el ombligo y el esternón) colocándose detrás de la persona.', true);
INSERT INTO public."QuizOptions" VALUES (21954, 5489, 'Apretarle la garganta con ambas manos.', false);
INSERT INTO public."QuizOptions" VALUES (21955, 5489, 'Levantarle los dos brazos hacia el techo.', false);
INSERT INTO public."QuizOptions" VALUES (21956, 5489, 'Hacerle cosquillas en las axilas.', false);
INSERT INTO public."QuizOptions" VALUES (21957, 5490, 'Untarle mantequilla, pasta de dientes o harina de trigo.', false);
INSERT INTO public."QuizOptions" VALUES (21958, 5490, 'Enfriar la zona inmediatamente con abundante agua corriente limpia a temperatura ambiente durante al menos 15 a 20 minutos.', true);
INSERT INTO public."QuizOptions" VALUES (21959, 5490, 'Frotarle cubos de hielo de forma enérgica sobre la quemadura.', false);
INSERT INTO public."QuizOptions" VALUES (21960, 5490, 'Reventar todas las ampollas con una aguja sucia.', false);
INSERT INTO public."QuizOptions" VALUES (21961, 5491, 'Retirar la gasa empapada y tirarla para poner una limpia.', false);
INSERT INTO public."QuizOptions" VALUES (21962, 5491, 'Colocar apósitos o gasas adicionales directamente encima de la primera sin retirarla y continuar ejerciendo presión firme continua.', true);
INSERT INTO public."QuizOptions" VALUES (21963, 5491, 'Lavar la herida con alcohol puro.', false);
INSERT INTO public."QuizOptions" VALUES (21964, 5491, 'Pedirle a la persona que mueva el brazo rápidamente.', false);
INSERT INTO public."QuizOptions" VALUES (21965, 5492, 'Un aparato que solo pueden usar neurocirujanos con licencia militar.', false);
INSERT INTO public."QuizOptions" VALUES (21966, 5492, 'Un dispositivo médico electrónico portátil y seguro que analiza el ritmo cardíaco y emite instrucciones de voz guiadas paso a paso para que cualquier persona pueda usarlo.', true);
INSERT INTO public."QuizOptions" VALUES (21967, 5492, 'Un medidor de presión arterial casero.', false);
INSERT INTO public."QuizOptions" VALUES (21968, 5492, 'Un tipo de extintor para apagar incendios eléctricos.', false);
INSERT INTO public."QuizOptions" VALUES (21969, 5493, 'Sentarla en una silla y girarle la cabeza para ver si tiene dolores.', false);
INSERT INTO public."QuizOptions" VALUES (21970, 5493, 'No mover a la víctima, mantener alineado el eje cabeza-cuello-tronco y esperar la llegada de los paramédicos con collarín cervical.', true);
INSERT INTO public."QuizOptions" VALUES (21971, 5493, 'Cargarla en brazos entre dos personas corriendo al hospital.', false);
INSERT INTO public."QuizOptions" VALUES (21972, 5493, 'Obligarla a ponerse de pie y caminar.', false);
INSERT INTO public."QuizOptions" VALUES (21973, 5494, 'Porque huelen mal.', false);
INSERT INTO public."QuizOptions" VALUES (21974, 5494, 'Porque son productos citotóxicos que destruyen las células sanas y el tejido de cicatrización, provocando irritación química y retrasando la curación.', true);
INSERT INTO public."QuizOptions" VALUES (21975, 5494, 'Porque cuesta mucho dinero en las farmacias.', false);
INSERT INTO public."QuizOptions" VALUES (21976, 5494, 'Porque duerme a la persona.', false);


--
-- Data for Name: QuizQuestions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."QuizQuestions" VALUES (5165, 13, '¿Cuál de las siguientes oraciones utiliza correctamente el verbo ''To Be'' en forma negativa contraída?', 'Para la 3ª persona del singular (She), la forma negativa contraída correcta del verbo To Be es ''isn''t'' (is not).', 1);
INSERT INTO public."QuizQuestions" VALUES (5166, 13, '¿Cuál es la regla ortográfica correcta para la 3ª persona del singular en Present Simple para el verbo ''watch''?', 'Los verbos terminados en ''-ch'', ''-sh'', ''-s'', ''-x'' u ''-o'' añaden la terminación ''-es'' en la 3ª persona del singular (He watches).', 2);
INSERT INTO public."QuizQuestions" VALUES (5167, 13, '¿Cuándo se debe utilizar el artículo indeterminado ''AN'' en lugar de ''A''?', '''AN'' se emplea ante sonidos vocálicos para facilitar la pronunciación fluida y evitar el choque de vocales (an orange, an hour con ''h'' muda).', 3);
INSERT INTO public."QuizQuestions" VALUES (5168, 13, '¿Cuál es la diferencia fundamental entre ''Present Simple'' y ''Present Continuous''?', 'Present Simple expresa verdades generales y rutinas (I work every day); Present Continuous expresa acciones en desarrollo en el momento del habla (I am working right now).', 4);
INSERT INTO public."QuizQuestions" VALUES (5169, 13, '¿Cuál es la forma correcta en Past Simple (pasado simple) del verbo irregular ''GO'' (ir)?', 'El verbo ''go'' es un verbo irregular cuyo pasado simple afirmativo es ''went'' (She went to London yesterday).', 5);
INSERT INTO public."QuizQuestions" VALUES (5170, 13, 'En una oración negativa en Past Simple, ¿cómo se conjuga el verbo principal tras el auxiliar ''didn''t''?', 'El auxiliar ''didn''t'' ya transporta la marca gramatical de tiempo pasado, por lo que el verbo principal vuelve obligatoriamente a su forma base (She didn''t play).', 6);
INSERT INTO public."QuizQuestions" VALUES (5171, 13, '¿Qué estructura de futuro es la más indicada para expresar una decisión espontánea tomada en el instante de hablar?', '''Will'' se utiliza para decisiones espontáneas, promesas y ofrecimientos surgidos en el momento de la conversación.', 7);
INSERT INTO public."QuizQuestions" VALUES (5172, 13, '¿Cuál es el plural irregular correcto del sustantivo ''person'' (persona)?', 'En inglés general estándar, el plural irregular de ''person'' es ''people'' (There were ten people in the room).', 8);
INSERT INTO public."QuizQuestions" VALUES (5173, 13, '¿Qué preposición de tiempo corresponde utilizar con los días de la semana y fechas específicas (ej. Monday, July 4th)?', 'La preposición ''ON'' se utiliza rigurosamente para días de la semana (on Monday) y fechas completas con día (on July 4th).', 9);
INSERT INTO public."QuizQuestions" VALUES (5174, 13, '¿Qué verbo modal expresa un consejo o recomendación en inglés?', '''Should'' (deberías) se emplea para aconsejar, recomendar o sugerir una acción beneficiosa a otra persona (You should rest).', 10);
INSERT INTO public."QuizQuestions" VALUES (5225, 18, '¿Cuál es el método profesional recomendado en Microsoft Word para generar un índice de contenido que se actualice automáticamente?', 'Word requiere que los títulos tengan asignados estilos jerárquicos para compilar automáticamente la tabla de contenido y paginación exacta.', 1);
INSERT INTO public."QuizQuestions" VALUES (5226, 18, 'En Microsoft Excel, ¿con qué carácter obligatorio debe comenzar cualquier fórmula o función para que realice una operación matemática?', 'El signo igual (=) indica al motor de Excel que interprete el contenido de la celda como una expresión matemática o función y no como texto literal.', 2);
INSERT INTO public."QuizQuestions" VALUES (5227, 18, '¿Qué sucede en una fórmula de Excel si arrastras hacia abajo una celda que contiene la referencia ''C2 * $D$1''?', 'El signo dólar ($) bloquea la columna y/o fila de la celda, manteniéndola fija como referencia absoluta al replicar la fórmula.', 3);
INSERT INTO public."QuizQuestions" VALUES (5228, 18, '¿Qué diferencia existe entre la función =CONTAR() y la función =CONTARA() en Excel?', 'CONTAR evalúa celdas con datos de tipo número, mientras que CONTARA cuenta celdas con cualquier contenido (alfanumérico, texto o símbolos).', 4);
INSERT INTO public."QuizQuestions" VALUES (5229, 18, 'En Microsoft Word, ¿cuál es la combinación de teclas estándar para forzar un salto de página limpio e iniciar en una hoja nueva?', 'Ctrl + Enter inserta un salto de página estructural sin desfasar el texto anterior al modificar los párrafos.', 5);
INSERT INTO public."QuizQuestions" VALUES (5230, 18, '¿Cuál es la fórmula correcta en Excel para sumar todos los valores numéricos comprendidos entre la celda B5 y la celda B20?', 'La sintaxis estándar es =SUMA(rango_inicio:rango_fin), donde los dos puntos indican continuidad de celdas.', 6);
INSERT INTO public."QuizQuestions" VALUES (5231, 18, 'En PowerPoint, ¿qué establece la regla de diseño recomendada ''6x6'' para presentaciones de negocios?', 'La regla 6x6 previene el ''Death by PowerPoint'' al obligar al presentador a sintetizar conceptos en ideas fuerza legibles.', 7);
INSERT INTO public."QuizQuestions" VALUES (5232, 18, 'Si una celda de Excel muestra el error ''#####'', ¿cuál es la causa más común y su solución inmediata?', 'Los signos de almohadilla ''#####'' aparecen cuando un número o fecha no cabe en el ancho visual de la columna; basta con hacer doble clic en el separador de la columna.', 8);
INSERT INTO public."QuizQuestions" VALUES (5233, 18, '¿Qué herramienta de PowerPoint permite transformar listas con viñetas en esquemas visuales, organigramas o flechas de proceso?', 'SmartArt es la función de diagramación ejecutiva para representar visualmente flujos, ciclos, jerarquías y listas interconectadas.', 9);
INSERT INTO public."QuizQuestions" VALUES (5234, 18, '¿Qué formato de archivo se recomienda para enviar un informe final de Word o PowerPoint a un cliente sin que se mueva la tipografía ni los márgenes?', 'El formato PDF (Portable Document Format) fija de manera inalterable la tipografía, diseño y maquetación en cualquier dispositivo o sistema operativo.', 10);
INSERT INTO public."QuizQuestions" VALUES (5235, 3, '¿Cuál es la principal ventaja técnica de la función =BUSCARX() (XLOOKUP) frente a la tradicional =BUSCARV()?', 'BUSCARX supera a BUSCARV al no depender del orden relativo de las columnas, permitir búsquedas bidireccionales y evitar errores al insertar columnas intermedias.', 1);
INSERT INTO public."QuizQuestions" VALUES (5236, 3, 'En la combinación de fórmulas =INDICE(columna_datos, COINCIDIR(valor, columna_clave, 0)), ¿qué función cumple el argumento ''0'' en COINCIDIR?', 'El argumento 0 (o FALSO) en COINCIDIR exige una coincidencia exacta estricta en el texto o número evaluado.', 2);
INSERT INTO public."QuizQuestions" VALUES (5237, 3, '¿Qué función lógica moderna permite evaluar múltiples condiciones jerárquicas consecutivas sin tener que anidar múltiples funciones SI una dentro de otra?', 'SI.CONJUNTO evalúa pares de pruebas lógicas y valores a devolver de forma lineal y legible.', 3);
INSERT INTO public."QuizQuestions" VALUES (5238, 3, '¿En qué cuadrante de una Tabla Dinámica se deben colocar los campos que contienen importes en dinero o cantidades que se desean totalizar?', 'El cuadrante de ''Valores'' aplica operadores de agregación como suma, promedio o recuento sobre los datos numéricos.', 4);
INSERT INTO public."QuizQuestions" VALUES (5239, 3, '¿Con qué extensión obligatoria debe guardarse un libro de Excel que contiene código o Macros automatizadas en VBA para que no se borren?', 'El formato .xlsm preserva los módulos de código Visual Basic; de lo contrario, el formato .xlsx estándar los descarta por seguridad.', 5);
INSERT INTO public."QuizQuestions" VALUES (5240, 3, '¿Qué herramienta de Microsoft Excel está diseñada específicamente para extraer, limpiar, desanidar y transformar bases de datos complejas antes de cargarlas?', 'Power Query es el motor ETL (Extract, Transform, Load) integrado en Excel que automatiza la limpieza y preparación masiva de datos.', 6);
INSERT INTO public."QuizQuestions" VALUES (5241, 3, '¿Cuál es el atajo de teclado global en Windows para abrir de inmediato el editor de Visual Basic for Applications (VBA) en Excel?', 'Alt + F11 abre la consola del entorno de desarrollo integrado de VBA para ver y editar módulos de macros.', 7);
INSERT INTO public."QuizQuestions" VALUES (5242, 3, 'Si necesitas que una fórmula devuelva VERDADERO únicamente cuando el cliente sea de ''Caracas'' Y ADEMÁS sus compras superen $1,000, ¿qué combinación usas?', 'La función Y() requiere el cumplimiento obligatorio y simultáneo de todas las expresiones lógicas contenidas en sus argumentos.', 8);
INSERT INTO public."QuizQuestions" VALUES (5243, 3, '¿Qué elemento interactivo visual se agrega a una Tabla Dinámica para filtrar datos con un solo clic mediante botones en vez de listas desplegables?', 'Los Segmentadores de Datos proporcionan paneles con botones estilizados para filtrar tablas y gráficos dinámicos de forma instantánea.', 9);
INSERT INTO public."QuizQuestions" VALUES (5244, 3, 'En modelado de datos, ¿qué función cumple la herramienta ''Buscar Objetivo'' (Goal Seek) de Excel?', 'Buscar Objetivo resuelve problemas de ingeniería inversa: determina qué variable de entrada se requiere para lograr una meta financiera o de producción concreta.', 10);
INSERT INTO public."QuizQuestions" VALUES (5245, 2, '¿Cuál es el modelo de datos relacional estándar recomendado en Power BI para optimizar el rendimiento y evitar ambigüedades analíticas?', 'El esquema en estrella separa hechos (transacciones) de dimensiones (catálogos), garantizando relaciones 1 a varios limpias y alta velocidad de procesamiento.', 1);
INSERT INTO public."QuizQuestions" VALUES (5246, 2, 'En Power BI, ¿cuál es la principal diferencia de rendimiento entre una ''Columna Calculada'' y una ''Medida DAX''?', 'Las medidas no consumen almacenamiento estático por fila; se calculan al vuelo según el contexto de filtro del usuario en la pantalla.', 2);
INSERT INTO public."QuizQuestions" VALUES (5247, 2, '¿Qué función del lenguaje DAX es la única capaz de modificar, agregar o ignorar el contexto de filtro activo de un reporte?', 'CALCULATE es la función angular de DAX que altera el contexto de evaluación aplicando nuevos filtros a una métrica existente.', 3);
INSERT INTO public."QuizQuestions" VALUES (5248, 2, '¿Qué herramienta integrada en Power BI Desktop se utiliza para la fase ETL (Extracción, Transformación y Limpieza de datos)?', 'Power Query es el entorno de preparación y transformación donde se perfilan, corrigen y limpian las tablas antes del modelado.', 4);
INSERT INTO public."QuizQuestions" VALUES (5249, 2, '¿Qué tipo de cardinalidad de relación es la más común y sana entre una Tabla de Dimensión (Clientes) y una de Hechos (Ventas)?', 'La relación 1 a Varios (1:*) conecta un registro único en la dimensión con múltiples transacciones asociadas en la tabla de hechos.', 5);
INSERT INTO public."QuizQuestions" VALUES (5250, 2, '¿Cuál es la función en DAX que permite ''traer'' el valor de una columna de otra tabla relacionada hacia la tabla actual?', 'RELATED sigue una relación existente para devolver un atributo de una dimensión en el contexto de la fila actual.', 6);
INSERT INTO public."QuizQuestions" VALUES (5251, 2, 'En visualización de datos, ¿por qué los gráficos circulares (pie charts) con más de 5 rebanadas son desaconsejados por los expertos en BI?', 'Los gráficos de barras ordenados de mayor a menor facilitan la comparación visual inmediata, a diferencia de los gráficos circulares que saturan la percepción.', 7);
INSERT INTO public."QuizQuestions" VALUES (5252, 2, '¿Para qué se crea y utiliza una ''Tabla Calendario'' (Date Table) dedicada en un modelo analítico de Power BI?', 'Una tabla calendario continua sin saltos es el requisito indispensable para que fórmulas de Time Intelligence (SAMEPERIODLASTYEAR, TOTALYTD) funcionen con exactitud.', 8);
INSERT INTO public."QuizQuestions" VALUES (5253, 2, '¿Qué tipo de visualización en Power BI está diseñada específicamente para mostrar un número único destacado junto con su estado respecto a una meta?', 'La tarjeta de KPI muestra el valor actual, el objetivo fijado y un indicador visual de color (verde/rojo) que denota éxito o alerta gerencial.', 9);
INSERT INTO public."QuizQuestions" VALUES (5254, 2, '¿Cómo se comparte un reporte terminado de Power BI con directores de la empresa de forma corporativa y segura?', 'Power BI Service en la nube permite gestionar la seguridad de acceso, la actualización programada automática de datos y la visualización desde dispositivos móviles autorizados.', 10);
INSERT INTO public."QuizQuestions" VALUES (5255, 5, 'En SQL, ¿cuál es la diferencia fundamental entre la cláusula WHERE y la cláusula HAVING?', 'WHERE opera sobre registros individuales antes de agrupar; HAVING evalúa condiciones sobre funciones de agregación (como SUM o COUNT) ya agrupadas.', 1);
INSERT INTO public."QuizQuestions" VALUES (5256, 5, '¿Qué tipo de JOIN en SQL devuelve todos los registros de la tabla izquierda y únicamente los registros coincidentes de la tabla derecha?', 'LEFT JOIN garantiza que todas las filas de la tabla izquierda aparezcan en el resultado, rellenando con NULL si no hay coincidencia a la derecha.', 2);
INSERT INTO public."QuizQuestions" VALUES (5257, 5, 'En la biblioteca Pandas de Python, ¿cuál es la estructura de datos bidimensional con filas y columnas etiquetadas más utilizada?', 'El DataFrame es la estructura fundamental bidimensional de Pandas, semejante a una tabla relacional o una hoja de Excel en memoria.', 3);
INSERT INTO public."QuizQuestions" VALUES (5258, 5, '¿Qué método de Pandas se utiliza para agrupar datos por una o más columnas y aplicar cálculos agregados (suma, media, recuento)?', '.groupby() implementa el patrón split-apply-combine para agrupar registros y calcular agregaciones estadísticas.', 4);
INSERT INTO public."QuizQuestions" VALUES (5259, 5, '¿Cuál es el propósito del gráfico de ''Diagrama de Caja'' (Boxplot) en el Análisis Exploratorio de Datos?', 'El boxplot visualiza el rango intercuartílico (IQR) y destaca con puntos externos los outliers o valores extremos.', 5);
INSERT INTO public."QuizQuestions" VALUES (5260, 5, 'En Machine Learning supervisado, ¿por qué es mandatorio separar el conjunto de datos en entrenamiento (Train) y prueba (Test)?', 'La partición Train/Test garantiza una evaluación objetiva de la capacidad de generalización del algoritmo predictivo.', 6);
INSERT INTO public."QuizQuestions" VALUES (5261, 5, '¿Qué biblioteca de Python es el estándar por excelencia para la implementación de algoritmos clásicos de Machine Learning?', 'Scikit-Learn proporciona implementaciones optimizadas de regresión, clasificación, clustering y preprocesamiento de datos.', 7);
INSERT INTO public."QuizQuestions" VALUES (5262, 5, 'Si un coeficiente de correlación lineal de Pearson entre dos variables continuas es de +0.92, ¿qué interpretación técnica tiene?', 'Un valor cercano a +1.0 indica una relación proporcional positiva fuerte entre ambas variables.', 8);
INSERT INTO public."QuizQuestions" VALUES (5263, 5, 'En una consulta SQL, ¿qué función agregada devuelve el valor promedio aritmético de una columna numérica?', 'AVG(columna) calcula la media aritmética sumando los valores y dividiendo entre la cantidad de registros no nulos.', 9);
INSERT INTO public."QuizQuestions" VALUES (5264, 5, 'En una matriz de confusión para clasificación binaria, ¿qué representa un ''Falso Positivo''?', 'Un Falso Positivo (Error Tipo I) ocurre cuando el modelo predice la presencia de una condición (ej. cliente que renuncia) cuando en realidad no es así.', 10);
INSERT INTO public."QuizQuestions" VALUES (5265, 19, '¿Cuál es la herramienta de Microsoft Word que permite generar cientos de cartas o contratos personalizados vinculando una base de datos de Excel?', 'Combinación de Correspondencia vincula un documento base con una lista de datos para emitir documentos personalizados masivos.', 1);
INSERT INTO public."QuizQuestions" VALUES (5266, 19, '¿Qué función de Excel utilizarías para sumar los montos de ventas únicamente si el vendedor es ''Carlos'' y el producto es ''Laptop''?', 'SUMAR.SI.CONJUNTO permite aplicar dos o más condiciones simultáneas para calcular la suma de una columna.', 2);
INSERT INTO public."QuizQuestions" VALUES (5267, 19, '¿Qué son los ''Minigráficos'' (Sparklines) en Microsoft Excel?', 'Los minigráficos son representaciones diminutas que residen en una única celda mostrando la evolución de una fila o columna.', 3);
INSERT INTO public."QuizQuestions" VALUES (5268, 19, '¿Qué efecto produce la transición ''Transformación'' (Morph) en las versiones modernas de PowerPoint?', 'Morph calcula la interpolación visual entre dos diapositivas consecutivas, creando transiciones cinematográficas elegantes.', 4);
INSERT INTO public."QuizQuestions" VALUES (5269, 19, 'En Excel, ¿cuál es la diferencia entre =CONTAR.SI() y =CONTAR.SI.CONJUNTO()?', 'CONTAR.SI se limita a un par rango/criterio; la versión CONJUNTO admite múltiples pares de validación.', 5);
INSERT INTO public."QuizQuestions" VALUES (5270, 19, '¿Qué función de Excel permite concatenar o unir textos de varias celdas incluyendo un separador definido (como una coma o guion) e ignorando vacíos?', 'UNIRCADENAS une un rango de textos incorporando un delimitador y permitiendo omitir celdas en blanco.', 6);
INSERT INTO public."QuizQuestions" VALUES (5271, 19, 'En Word, ¿para qué se utiliza la herramienta ''Control de Cambios'' en revisiones colaborativas de contratos?', 'El control de cambios marca en rojo/color las modificaciones de cada usuario para su posterior aprobación o rechazo.', 7);
INSERT INTO public."QuizQuestions" VALUES (5272, 19, 'Si deseas proteger ciertas celdas de una hoja de Excel para que otros usuarios no alteren las fórmulas pero sí puedan llenar datos, ¿qué pasos debes seguir?', 'Todas las celdas vienen bloqueadas por defecto; se desmarcan las celdas editables y luego se protege la hoja con contraseña.', 8);
INSERT INTO public."QuizQuestions" VALUES (5273, 19, '¿Qué gráfico de Excel es el más indicado para visualizar la distribución porcentual de una categoría respecto al total (composición de partes de un todo)?', 'Los gráficos de anillo o circulares representan participaciones relativas de partes respecto a un total del 100%.', 9);
INSERT INTO public."QuizQuestions" VALUES (5274, 19, 'En PowerPoint, ¿qué función cumple la ''Vista Moderador'' durante una proyección con dos pantallas o cañón proyector?', 'La vista moderador asiste al orador en la pantalla secundaria con notas de apoyo, reloj y previsualizaciones sin que la audiencia lo note.', 10);
INSERT INTO public."QuizQuestions" VALUES (5275, 1, '¿Cuáles son los 4 componentes estructurales del Framework R.T.F.R. para diseñar un prompt corporativo de alta precisión?', 'El framework RTFR asegura que el modelo entienda su rol experto, la tarea concreta, la estructura visual de salida y los límites o restricciones aplicables.', 1);
INSERT INTO public."QuizQuestions" VALUES (5276, 1, '¿En qué consiste la técnica de ''Few-Shot Prompting'' al interactuar con modelos como Gemini o ChatGPT?', 'Few-Shot prompting provee ejemplos concretos de muestra para guiar el formato, vocabulario y estilo de la respuesta.', 2);
INSERT INTO public."QuizQuestions" VALUES (5277, 1, '¿Qué efecto tiene instruir a un modelo de lenguaje con la frase: ''Piensa paso a paso antes de dar tu respuesta final'' (Chain of Thought)?', 'La técnica de Cadena de Pensamiento (Chain of Thought) obliga al LLM a computar tokens de razonamiento intermedio, aumentando notablemente su exactitud lógica.', 3);
INSERT INTO public."QuizQuestions" VALUES (5278, 1, 'En el contexto de los modelos de Inteligencia Artificial Generativa, ¿qué es una ''Alucinación''?', 'Las alucinaciones son respuestas factualmente erróneas producidas por el modelo al predecir palabras estadísticamente plausibles sin verdadero anclaje a la realidad.', 4);
INSERT INTO public."QuizQuestions" VALUES (5279, 1, '¿Cuál de las siguientes acciones representa una violación grave de seguridad y confidencialidad corporativa al usar herramientas públicas de IA?', 'Subir datos personales identificables (PII) o información financiera confidencial a servidores de IA pública vulnera leyes de privacidad y acuerdos de confidencialidad laboral.', 5);
INSERT INTO public."QuizQuestions" VALUES (5280, 1, '¿Qué técnica es recomendable aplicar a los datos de la empresa antes de ingresarlos a una herramienta de IA para un análisis de texto?', 'La anonimización protege los secretos industriales y datos de clientes mientras permite al modelo analizar la lógica de negocio sin riesgos de filtración.', 6);
INSERT INTO public."QuizQuestions" VALUES (5281, 1, '¿Cuál es la principal ventaja analítica de Google Gemini frente a otros modelos al trabajar con documentos empresariales extensos?', 'La enorme ventana de contexto de Gemini permite analizar volúmenes gigantescos de documentación corporativa sin tener que fragmentarla.', 7);
INSERT INTO public."QuizQuestions" VALUES (5282, 1, 'Si necesitas que la IA compare dos cotizaciones de proveedores y te entregue los resultados listos para una presentación ejecutiva, ¿qué formato de salida debes solicitarle explícitamente?', 'Solicitar tablas Markdown estructuradas permite copiar y pegar la comparación directamente en Word, Excel o PowerPoint de forma limpia.', 8);
INSERT INTO public."QuizQuestions" VALUES (5283, 1, '¿Por qué se desaconseja redactar prompts con instrucciones negativas como ''No seas aburrido, no uses palabras difíciles'' en lugar de positivas?', 'Los modelos de lenguaje procesan con mayor precisión pautas afirmativas concretas de lo que deben hacer en vez de listas ambiguas de exclusiones.', 9);
INSERT INTO public."QuizQuestions" VALUES (5284, 1, 'Al usar la IA para generar código de programación o fórmulas avanzadas de Excel, ¿cuál es el paso profesional obligatorio antes de aplicarlo en el trabajo diario?', 'Todo código o fórmula generada por IA debe ser auditada y probada rigurosamente por el profesional antes de implementarla en sistemas productivos de la empresa.', 10);
INSERT INTO public."QuizQuestions" VALUES (5285, 12, '¿Cuáles son los 3 principios fundamentales que conforman la Triada Clásica de la Seguridad de la Información (C.I.A.)?', 'La triada CIA (Confidentiality, Integrity, Availability) define los tres objetivos rectores de cualquier estrategia de ciberseguridad.', 1);
INSERT INTO public."QuizQuestions" VALUES (5286, 12, '¿Qué es el ''Phishing'' en el ámbito de los ciberataques?', 'El phishing busca manipular psicológicamente a la víctima para que entregue contraseñas o instale malware de forma inadvertida.', 2);
INSERT INTO public."QuizQuestions" VALUES (5287, 12, '¿Por qué la Autenticación Multifactor (MFA) es infinitamente más segura que utilizar únicamente una contraseña tradicional?', 'MFA neutraliza el impacto del robo de contraseñas, ya que el ciberdelincuente necesitaría acceso físico simultáneo al dispositivo del usuario.', 3);
INSERT INTO public."QuizQuestions" VALUES (5288, 12, '¿Qué daño específico causa un ataque de ''Ransomware'' en los sistemas de una empresa?', 'El ransomware secuestra la información mediante algoritmos de cifrado de grado militar, paralizando las operaciones comerciales del negocio.', 4);
INSERT INTO public."QuizQuestions" VALUES (5289, 12, '¿Qué establece la estrategia de respaldo ''3-2-1'' para proteger los datos de la empresa ante pérdidas catastróficas?', 'La regla 3-2-1 garantiza redundancia física y geográfica, protegiendo a la empresa contra fallos de hardware, catástrofes y ransomware.', 5);
INSERT INTO public."QuizQuestions" VALUES (5290, 12, '¿Cuál es el principal riesgo de seguridad al conectar la computadora de trabajo a una red Wi-Fi pública sin contraseña en un café o aeropuerto?', 'Las redes abiertas no cifran la comunicación entre tu equipo y el router, exponiendo los datos a herramientas de espionaje en red.', 6);
INSERT INTO public."QuizQuestions" VALUES (5291, 12, '¿Qué indica el prefijo ''https://'' y el icono de candado en la barra de direcciones de una página web?', 'HTTPS garantiza el cifrado del canal de transmisión de datos (claves, tarjetas), aunque no certifica por sí solo la reputación moral de la página.', 7);
INSERT INTO public."QuizQuestions" VALUES (5292, 12, '¿Cuál es la forma más segura y profesional de gestionar decenas de contraseñas complejas y diferentes para cada servicio corporativo?', 'Un gestor de contraseñas genera claves criptográficas aleatorias y únicas para cada servicio sin sobrecargar la memoria del usuario.', 8);
INSERT INTO public."QuizQuestions" VALUES (5293, 12, 'Si recibes una llamada telefónica urgente de alguien que dice ser del departamento de TI pidiéndote tu contraseña para ''reparar tu cuenta'', ¿cómo debes proceder?', 'El personal legítimo de TI jamás solicita contraseñas personales por teléfono; es un ataque clásico de vishing (ingeniería social por voz).', 9);
INSERT INTO public."QuizQuestions" VALUES (5294, 12, '¿Qué es una ''Red Privada Virtual'' (VPN) y para qué se implementa en el teletrabajo empresarial?', 'Una VPN crea un túnel seguro y cifrado sobre internet que protege el tráfico corporativo frente a escuchas ilícitas.', 10);
INSERT INTO public."QuizQuestions" VALUES (5295, 34, '¿Cuál es el orden secuencial correcto de colores para crimpar un cable de red de par trenzado bajo la norma estándar T568B (de izquierda a derecha con los pines mirando hacia arriba)?', 'La norma T568B sigue el orden: Blanco-Naranja, Naranja, Blanco-Verde, Azul, Blanco-Azul, Verde, Blanco-Marrón y Marrón.', 1);
INSERT INTO public."QuizQuestions" VALUES (5296, 34, 'En la gestión de Helpdesk y soporte técnico corporativo, ¿qué caracteriza a una incidencia clasificada como ''P1 - Crítica''?', 'Las incidencias P1 paralizan la actividad comercial de la empresa y exigen atención inmediata por parte de los técnicos de soporte.', 2);
INSERT INTO public."QuizQuestions" VALUES (5297, 34, '¿Por qué se utiliza alcohol isopropílico de alta pureza (99%) y no alcohol medicinal común para limpiar placas base y procesadores de computadoras?', 'El alcohol medicinal común contiene un 30% de agua que puede causar corrosión galvánica y cortocircuitos; el isopropílico se evapora casi al instante sin dejar residuos.', 3);
INSERT INTO public."QuizQuestions" VALUES (5298, 34, '¿Qué comando de la consola de Windows (CMD) permite verificar si la computadora tiene comunicación activa y mide el tiempo de respuesta con el router o un servidor externo?', 'El comando ''ping'' envía paquetes ICMP de solicitud de eco y mide la latencia y porcentaje de pérdida de paquetes.', 4);
INSERT INTO public."QuizQuestions" VALUES (5299, 34, 'Si una computadora de escritorio se enciende, giran los ventiladores pero no da video en pantalla y emite una secuencia de pitidos cortos continuos, ¿cuál es el componente sospechoso número uno?', 'Las fallas de inicialización de memoria RAM en el proceso POST de la BIOS impiden el arranque del video y suelen alertarse con secuencias de beeps sonoros.', 5);
INSERT INTO public."QuizQuestions" VALUES (5300, 34, '¿Cuál es la función primordial de la pasta térmica colocada entre la superficie metálica del procesador (CPU) y la base del disipador?', 'El aire es un pésimo conductor térmico; la pasta térmica elimina las bolsas de aire entre metales facilitando la disipación del calor generado por el silicio.', 6);
INSERT INTO public."QuizQuestions" VALUES (5301, 34, '¿Qué herramienta gratuita oficial o de terceros es la más popular para crear una memoria USB booteable para instalar Windows 10/11 en modo UEFI/GPT?', 'Rufus es la utilidad ligera por excelencia para grabar imágenes ISO en memorias USB con esquemas de arranque GPT y MBR.', 7);
INSERT INTO public."QuizQuestions" VALUES (5302, 34, 'En una red local de oficina, ¿qué comando de Windows muestra la dirección IP local de la máquina y la Puerta de Enlace Predeterminada (Default Gateway)?', 'ipconfig muestra la configuración IP activa de todas las tarjetas de red de la máquina.', 8);
INSERT INTO public."QuizQuestions" VALUES (5303, 34, '¿Por qué las impresoras de red y las cámaras de seguridad CCTV deben configurarse con ''Direcciones IP Estáticas'' en lugar de DHCP dinámico?', 'Una IP estática garantiza que las estaciones de trabajo y servidores siempre encuentren el dispositivo en la misma dirección de red inmutable.', 9);
INSERT INTO public."QuizQuestions" VALUES (5304, 34, '¿Cuál es la principal ventaja de actualizar una computadora de oficina sustituyendo un disco duro mecánico tradicional (HDD) por una unidad de estado sólido (SSD)?', 'Las unidades SSD no tienen partes mecánicas móviles y acceden a los datos de forma instantánea mediante memoria flash NAND, acelerando el equipo drásticamente.', 10);
INSERT INTO public."QuizQuestions" VALUES (5305, 7, '¿Qué diferencia esencial existe entre digitalizar documentos y llevar a cabo una verdadera ''Transformación Digital'' en una empresa?', 'La transformación digital es un cambio cultural y estratégico integral que optimiza la entrega de valor al cliente mediante tecnología, más allá de la simple digitalización de documentos.', 1);
INSERT INTO public."QuizQuestions" VALUES (5306, 7, '¿A qué modelo de computación en la nube pertenecen plataformas empresariales listas para usar como Microsoft 365, Google Workspace o Shopify?', 'SaaS (Software as a Service) entrega aplicaciones completas listas para el usuario final a través de internet sin gestionar servidores.', 2);
INSERT INTO public."QuizQuestions" VALUES (5307, 7, 'En términos financieros de tecnología empresarial, ¿qué ventaja ofrece el modelo en la nube al migrar de gastos CapEx a gastos OpEx?', 'El modelo OpEx (Gastos Operativos) flexibiliza el flujo de caja, pagando solo por la capacidad tecnológica utilizada mes a mes.', 3);
INSERT INTO public."QuizQuestions" VALUES (5308, 7, '¿Cuál es la función primordial de un sistema ERP (Enterprise Resource Planning) en una corporación?', 'Un ERP unifica toda la información de la empresa, evitando silos aislados y asegurando que una venta descuente stock y contabilice ingresos en tiempo real.', 4);
INSERT INTO public."QuizQuestions" VALUES (5309, 7, '¿Qué función cumple un sistema CRM (Customer Relationship Management) dentro de la estrategia comercial de la empresa?', 'El CRM administra la cartera de clientes, registra cada interacción y mide la eficiencia del embudo de ventas.', 5);
INSERT INTO public."QuizQuestions" VALUES (5310, 7, 'En planes de continuidad de negocios y recuperación ante desastres (DRP), ¿qué representa el indicador ''RTO'' (Recovery Time Objective)?', 'El RTO establece el límite de tiempo dentro del cual los servicios deben ser restaurados tras un incidente técnico.', 6);
INSERT INTO public."QuizQuestions" VALUES (5311, 7, 'En planes de continuidad tecnológica, ¿qué mide el indicador ''RPO'' (Recovery Point Objective)?', 'El RPO define la frecuencia de respaldos requerida; un RPO de 1 hora significa que se pueden tolerar máximo 60 minutos de pérdida de datos.', 7);
INSERT INTO public."QuizQuestions" VALUES (5312, 7, '¿Cuál es una de las causas más frecuentes de fracaso en la implementación de software empresarial (ERP/CRM)?', 'El éxito de un ERP depende de la gestión del cambio humano y la estandarización previa de procesos, no solo de la tecnología.', 8);
INSERT INTO public."QuizQuestions" VALUES (5313, 7, '¿Qué tecnología emergente se utiliza para automatizar tareas repetitivas y rutinarias basadas en reglas entre aplicaciones (ej. extraer datos de un PDF y cargarlos en un ERP)?', 'RPA utiliza robots de software para imitar acciones humanas en interfaces digitales, liberando al personal de tareas manuales repetitivas.', 9);
INSERT INTO public."QuizQuestions" VALUES (5314, 7, '¿Por qué la ''Gobernanza de Datos'' (Data Governance) es indispensable para el cumplimiento legal y la confianza de los clientes en una empresa?', 'La gobernanza de datos establece la custodia, calidad, seguridad y cumplimiento normativo de la información corporativa.', 10);
INSERT INTO public."QuizQuestions" VALUES (5315, 30, '¿Cuál es el impacto en SAP B1 cuando se crea una Orden de Venta (Sales Order)?', 'La Orden de Venta formaliza el pedido comercial y aumenta el ''Stock Comprometido'' para evitar que se venda a otros clientes, pero la salida física real ocurre en la Entrega (Delivery).', 1);
INSERT INTO public."QuizQuestions" VALUES (5316, 30, '¿Qué casillas de verificación definen que un artículo pueda ser comprado, vendido y almacenado en SAP B1?', 'En Datos Maestros de Artículos, estas tres casillas gobiernan en qué módulos y documentos puede participar el SKU respectivo.', 2);
INSERT INTO public."QuizQuestions" VALUES (5317, 30, '¿En qué documento del circuito de compras de SAP B1 se produce el ingreso físico real de los productos al almacén?', 'La Entrada de Mercancías (GRPO) es el documento que aumenta el stock disponible en almacén y registra el pasivo transitorio con el proveedor.', 3);
INSERT INTO public."QuizQuestions" VALUES (5318, 30, '¿Qué herramienta interactiva de SAP B1 permite visualizar el árbol documental completo desde la cotización hasta el cobro?', 'El Mapa de Relaciones muestra visualmente todas las ramas documentales vinculadas con sus estados (abierto, cerrado, cancelado).', 4);
INSERT INTO public."QuizQuestions" VALUES (5319, 30, 'Si un producto se daña de forma irreparable en el depósito, ¿cuál es el documento correcto para rebajar el stock en SAP?', 'La Salida de Mercancías extrae las unidades físicas de almacén y refleja la pérdida económica en la cuenta de resultados asignada.', 5);
INSERT INTO public."QuizQuestions" VALUES (5320, 30, '¿Qué tipo de Socio de Negocios (BP) se debe registrar para gestionar las compras a fábricas o mayoristas?', 'Los Socios de Negocios de tipo ''Proveedor'' son los únicos habilitados para órdenes de compra y facturas de acreedores.', 6);
INSERT INTO public."QuizQuestions" VALUES (5321, 30, '¿Qué ocurre financieramente al registrar una Factura de Clientes (A/R Invoice)?', 'La factura fiscal genera el derecho de cobro formal en cuentas por cobrar y acredita el ingreso por ventas en el balance.', 7);
INSERT INTO public."QuizQuestions" VALUES (5322, 30, '¿Qué función cumple el ''Stock Solicitado'' (Ordered) en la ficha de inventario de SAP B1?', 'El stock solicitado refleja los pedidos de compra en tránsito que aún no han sido descargados en almacén.', 8);
INSERT INTO public."QuizQuestions" VALUES (5323, 30, '¿Cuál es el cálculo exacto del ''Stock Disponible'' en SAP Business One?', 'Disponible = En Stock (físico actual) - Comprometido (vendido no entregado) + Solicitado (comprado en camino).', 9);
INSERT INTO public."QuizQuestions" VALUES (5324, 30, '¿Para qué sirve el documento ''Traslado de Inventario'' entre dos almacenes de la misma empresa?', 'Un traslado reubica físicamente los bienes entre depósitos manteniendo intacto el valor patrimonial total de la compañía.', 10);
INSERT INTO public."QuizQuestions" VALUES (5325, 31, '¿Cuál es la principal ventaja de utilizar Colecciones Automatizadas en Shopify?', 'Las colecciones automatizadas usan condiciones predefinidas (tipo de producto, etiquetas, precio) para clasificar el catálogo dinámicamente.', 1);
INSERT INTO public."QuizQuestions" VALUES (5326, 31, 'Para conectar un dominio web propio (.com) a una tienda de Shopify, ¿qué registros DNS deben configurarse?', 'La configuración técnica oficial de Shopify requiere el Registro A en su IP fija y el CNAME apuntando a shops.myshopify.com.', 2);
INSERT INTO public."QuizQuestions" VALUES (5327, 31, '¿Cómo se denomina la opción en Shopify que permite recibir pedidos mediante Transferencia Bancaria o Pago Móvil sin pasarela de tarjetas?', 'Los Métodos de Pago Manuales permiten al cliente finalizar el pedido y mostrarle los datos de cuenta bancaria para verificación posterior.', 3);
INSERT INTO public."QuizQuestions" VALUES (5328, 31, '¿Qué acción realiza la función de ''Fulfillment'' en el panel de pedidos de Shopify?', 'Fulfillment significa cumplimiento/preparación del despacho, cambiando el estado del pedido a ''Preparado'' y alertando al cliente.', 4);
INSERT INTO public."QuizQuestions" VALUES (5329, 31, '¿Cuál es la estrategia recomendada para recuperar carritos abandonados de manera sistemática en Shopify?', 'Shopify permite configurar envíos automáticos de correos con el enlace directo al checkout, recuperando entre un 10% y 25% de las ventas perdidas.', 5);
INSERT INTO public."QuizQuestions" VALUES (5330, 31, '¿Qué es una variante de producto en Shopify?', 'Las variantes permiten que un mismo producto (ej. Camiseta Polo) ofrezca combinaciones de tallas (S, M, L) y colores con control de inventario independiente.', 6);
INSERT INTO public."QuizQuestions" VALUES (5331, 31, '¿Qué impacto tiene no configurar políticas legales (Privacidad, Reembolsos, Términos) en una tienda online?', 'Las políticas legales son requisito mandatorio de las plataformas publicitarias para verificar la legitimidad del negocio.', 7);
INSERT INTO public."QuizQuestions" VALUES (5332, 31, '¿Qué herramienta del editor de temas de Shopify permite agregar secciones interactivas sin necesidad de tocar código?', 'La arquitectura Online Store 2.0 introdujo secciones y bloques modulares que cualquier usuario puede personalizar visualmente.', 8);
INSERT INTO public."QuizQuestions" VALUES (5333, 31, '¿Qué métrica clave de e-commerce representa el porcentaje de visitantes que completan una compra respecto al total de visitas?', 'La Tasa de Conversión (generalmente entre 1% y 3% en e-commerce) mide la eficacia de la tienda para transformar visitas en ventas reales.', 9);
INSERT INTO public."QuizQuestions" VALUES (5334, 31, '¿Por qué es fundamental asignar un código SKU único a cada producto y variante en Shopify?', 'El SKU (Stock Keeping Unit) es el identificador único indispensable para el control de inventarios, despachos y conciliaciones multicanal.', 10);
INSERT INTO public."QuizQuestions" VALUES (5335, 32, '¿Cuál es el primer paso obligatorio que debe realizar un cajero al recibir el turno de trabajo?', 'Contar el fondo inicial garantiza que el cajero inicie su jornada con el dinero exacto para dar cambio y sin faltantes previos heredados.', 1);
INSERT INTO public."QuizQuestions" VALUES (5336, 32, '¿En qué consiste la técnica comercial de ''Venta Cruzada'' (Cross-Selling)?', 'La venta cruzada eleva el ticket ofreciendo accesorios o insumos directamente vinculados a la necesidad del cliente.', 2);
INSERT INTO public."QuizQuestions" VALUES (5337, 32, '¿Cuál es la forma más profesional y efectiva de disuadir intentos de hurto en el piso de venta sin generar conflictos?', 'La presencia de servicio y el contacto visual le demuestran a la persona que el personal está atento, disuadiendo el hurto de manera cordial.', 3);
INSERT INTO public."QuizQuestions" VALUES (5338, 32, '¿Qué documento emitido por el punto de venta (POS) resume las operaciones de tarjetas de crédito/débito al cerrar el turno?', 'El cierre de lote liquida electrónicamente las transacciones del día y emite el total consolidado para el cuadre contable.', 4);
INSERT INTO public."QuizQuestions" VALUES (5339, 32, '¿Qué se debe verificar antes de procesar una devolución o cambio de producto en tienda?', 'La política de cambios exige constancia legal de compra y que el producto no presente maltrato ni uso indebido para volver al stock.', 5);
INSERT INTO public."QuizQuestions" VALUES (5340, 32, '¿Qué significa hacer un ''Arqueo Ciego'' de caja?', 'El arqueo ciego evita manipulaciones deliberadas para ''cuadrar a la fuerza'' diferencias o faltantes de dinero.', 6);
INSERT INTO public."QuizQuestions" VALUES (5341, 32, 'Si un cliente llega al mostrador furioso porque un artículo que compró no funciona, ¿cuál debe ser la primera reacción del asistente?', 'La contención empática y la escucha activa desarman la hostilidad y canalizan la solución de forma profesional.', 7);
INSERT INTO public."QuizQuestions" VALUES (5342, 32, '¿Por qué es importante realizar ''Retiros de Efectivo'' o remesas periódicas de la caja a lo largo del turno?', 'Mantener montos bajos en la caja minimiza el riesgo financiero y patrimonial del negocio.', 8);
INSERT INTO public."QuizQuestions" VALUES (5343, 32, '¿Qué es el ''Upselling'' en una conversación de venta?', 'El upselling orienta al cliente hacia una alternativa superior que satisface mejor su necesidad a cambio de un valor justo.', 9);
INSERT INTO public."QuizQuestions" VALUES (5344, 32, '¿Qué elemento de seguridad básica en un billete de curso legal suele verificarse con luz ultravioleta o al trasluz?', 'Las marcas de agua, fibras fluorescentes y cintas de seguridad son elementos intrínsecos de alta seguridad imposibles de fotocopiar.', 10);
INSERT INTO public."QuizQuestions" VALUES (5345, 33, '¿Cuál de los siguientes niveles de exhibición en góndola concentra históricamente el mayor volumen de ventas espontáneas?', 'El nivel de los ojos es la primera zona de contacto visual directo y capta la mayor cantidad de decisiones impulsivas.', 1);
INSERT INTO public."QuizQuestions" VALUES (5346, 33, '¿Qué indica el principio de rotación FEFO en la reposición de productos de consumo masivo?', 'FEFO prioriza la fecha de caducidad real del empaque frente al orden de llegada al almacén para impedir que queden productos viejos atrapados al fondo.', 2);
INSERT INTO public."QuizQuestions" VALUES (5347, 33, '¿Qué es un ''Facing'' en el ámbito del trade merchandising?', 'El facing mide la visibilidad horizontal directa del producto hacia el comprador en el anaquel.', 3);
INSERT INTO public."QuizQuestions" VALUES (5348, 33, '¿Qué documento técnico visual detalla con precisión matemática la ubicación, cantidad de caras y orden de los productos en góndola?', 'El planograma es el plano formal diseñado por trade marketing que indica cómo montar exactamente cada sección.', 4);
INSERT INTO public."QuizQuestions" VALUES (5349, 33, '¿Qué acción debe tomar el mercaderista si detecta un lote de productos a menos de 30 días de su fecha de vencimiento en góndola?', 'Reportar a tiempo permite activar promociones comerciales de salida o devoluciones al fabricante antes de que se convierta en pérdida total.', 5);
INSERT INTO public."QuizQuestions" VALUES (5350, 33, '¿Qué es el ''Material POP'' (Point of Purchase)?', 'El material POP busca destacar visualmente una promoción o mensaje de marca en el lugar exacto de compra.', 6);
INSERT INTO public."QuizQuestions" VALUES (5351, 33, '¿Por qué las ''Cabeceras de Góndola'' (puntas de pasillo) son consideradas zonas calientes de venta en un supermercado?', 'El tráfico obligatorio en los extremos de pasillo garantiza que casi la totalidad de los compradores pasen frente a las cabeceras.', 7);
INSERT INTO public."QuizQuestions" VALUES (5352, 33, '¿Qué significa el término ''Agotado'' o ''Quiebre de Stock'' (Out of Stock) en el anaquel?', 'Un quiebre de stock frustra la compra del cliente y entrega la venta directamente a la marca competidora.', 8);
INSERT INTO public."QuizQuestions" VALUES (5353, 33, '¿Cuál es el beneficio de agrupar los productos formando ''Bloques de Marca'' en la góndola?', 'El bloque de marca consolida la presencia de la compañía y genera una mancha visual imposible de ignorar para el consumidor.', 9);
INSERT INTO public."QuizQuestions" VALUES (5354, 33, '¿Por qué los productos pesados o de gran volumen (como bolsas de 15 kg de comida para perros) se ubican en el nivel suelo?', 'La ergonomía y prevención de riesgos laborales y del consumidor exigen ubicar cargas pesadas en las baldas inferiores.', 10);
INSERT INTO public."QuizQuestions" VALUES (5355, 9, '¿Cuál es la principal ventaja de utilizar ''Respuestas Rápidas'' en WhatsApp Business?', 'Las respuestas rápidas estandarizan la calidad de atención y reducen el tiempo de espera drásticamente durante picos de consultas.', 1);
INSERT INTO public."QuizQuestions" VALUES (5356, 9, 'Si un cliente potencial pregunta ''¿Precio?'' por chat, ¿cuál es el error más grave que cometen los vendedores principiantes?', 'Dar solo el número sin propuesta de valor reduce la conversación a una comparación fría de precios y propicia el abandono del chat.', 2);
INSERT INTO public."QuizQuestions" VALUES (5357, 9, '¿Cómo se denomina la métrica que calcula cuánto dinero le cuesta a la empresa conseguir un nuevo cliente comprador?', 'CAC (Customer Acquisition Cost) divide todo el presupuesto de publicidad y ventas entre el número total de nuevos clientes logrados.', 3);
INSERT INTO public."QuizQuestions" VALUES (5358, 9, '¿Por qué es crucial responder preguntas en Marketplaces (como Mercado Libre) en menos de 10 minutos?', 'La inmediatez en marketplaces es el factor determinante de cierre antes de que el usuario haga clic en la publicación del competidor.', 4);
INSERT INTO public."QuizQuestions" VALUES (5359, 9, '¿Qué representa la métrica LTV (Customer Lifetime Value)?', 'LTV mide los ingresos proyectados que un cliente repetitivo generará en el tiempo, justificando la inversión para captarlo.', 5);
INSERT INTO public."QuizQuestions" VALUES (5360, 9, '¿Qué técnica de cierre por chat consiste en ofrecer dos opciones afirmativas en lugar de una pregunta abierta que admita un ''no''?', 'La alternativa doble asume la compra y le facilita al comprador decidir únicamente sobre la logística o el color.', 6);
INSERT INTO public."QuizQuestions" VALUES (5361, 9, '¿Para qué sirve el sistema de ''Etiquetas'' en WhatsApp Business?', 'Las etiquetas funcionan como un CRM ágil para hacer seguimiento ordenado y no olvidar pedidos pendientes de pago o despacho.', 7);
INSERT INTO public."QuizQuestions" VALUES (5362, 9, 'Si invertiste $100 en publicidad digital y esa campaña generó directamente $500 en ventas, ¿cuál fue tu ROAS?', 'ROAS = Ingresos / Inversión ($500 / $100 = 5x). Por cada dólar gastado en anuncios, volvieron 5 dólares en ventas.', 8);
INSERT INTO public."QuizQuestions" VALUES (5363, 9, '¿Cuál es la estructura recomendada para el título de un producto en un Marketplace para ganar visibilidad orgánica?', 'Los motores de búsqueda interna de los marketplaces indexan palabras clave precisas que los usuarios escriben en la barra de búsqueda.', 9);
INSERT INTO public."QuizQuestions" VALUES (5364, 9, '¿Cuál es la relación saludable recomendada entre LTV (Valor de Vida) y CAC (Costo de Adquisición)?', 'Una relación 3:1 o superior garantiza que el modelo de captación sea rentable y deje margen operativo suficiente para crecer.', 10);
INSERT INTO public."QuizQuestions" VALUES (5365, 35, '¿Cuál de los siguientes niveles organizacionales es responsable de definir la visión, misión y estrategia de largo plazo de una corporación?', 'El nivel estratégico establece el rumbo maestro de la empresa a 3-5 años y fija los objetivos corporativos prioritarios.', 1);
INSERT INTO public."QuizQuestions" VALUES (5366, 35, '¿Qué documento formal emite el departamento de compras al proveedor seleccionado para confirmar un pedido con precios acordados?', 'La Orden de Compra es el compromiso formal de adquisición que detalla cantidades, precios pactados, plazos y condiciones de entrega.', 2);
INSERT INTO public."QuizQuestions" VALUES (5367, 35, '¿Por qué es una buena práctica de control interno exigir al menos 3 cotizaciones antes de hacer una compra significativa?', 'El cuadro comparativo de cotizaciones garantiza transparencia, economía y optimización del uso de los recursos de la empresa.', 3);
INSERT INTO public."QuizQuestions" VALUES (5368, 35, '¿Qué mide un ''Reporte de Antigüedad de Saldos'' (Aging Report) en el área de cobranzas?', 'El aging report organiza los saldos adeudados por los clientes según su retraso para priorizar las acciones de cobranza crítica.', 4);
INSERT INTO public."QuizQuestions" VALUES (5369, 35, '¿Cuál es el propósito del ''Resumen Ejecutivo'' (Executive Summary) en un informe administrativo gerencial?', 'Los altos ejecutivos requieren síntesis inmediata con métricas clave antes de profundizar en anexos técnicos detallados.', 5);
INSERT INTO public."QuizQuestions" VALUES (5370, 35, 'En la interacción departamental, ¿cuál es la relación funcional habitual entre Ventas y Almacén/Despachos?', 'La orden de venta aprobada es el gatillo administrativo que autoriza la preparación y entrega formal de inventarios.', 6);
INSERT INTO public."QuizQuestions" VALUES (5371, 35, '¿Qué significa el concepto de ''Flujo de Caja'' (Cash Flow) en la gestión financiera básica de una pyme?', 'El flujo de caja refleja la disponibilidad real de liquidez para operar, pagar sueldos y cubrir proveedores sin depender de cobranzas futuras.', 7);
INSERT INTO public."QuizQuestions" VALUES (5372, 35, '¿Qué área organizacional suele encargarse de la nómina de sueldos, el clima laboral y el cumplimiento de las leyes del trabajo?', 'Recursos Humanos gestiona la contratación, bienestar, nómina y relaciones laborales del capital humano.', 8);
INSERT INTO public."QuizQuestions" VALUES (5373, 35, '¿Qué elemento es fundamental que acompañe a una gráfica de desempeño cuando una meta no se cumple en un reporte gerencial?', 'Los informes de gestión profesionales analizan las causas de los desvíos y formulan soluciones accionables.', 9);
INSERT INTO public."QuizQuestions" VALUES (5374, 35, '¿Por qué es riesgoso otorgar créditos comerciales sin consultar el historial crediticio previo del cliente?', 'La evaluación de riesgo crediticio previa asegura que la empresa otorgue líneas de crédito sostenibles a clientes con solvencia demostrada.', 10);
INSERT INTO public."QuizQuestions" VALUES (5375, 8, 'En la clasificación ABC de inventarios, ¿qué característica principal define a los artículos de ''Categoría A''?', 'La regla de Pareto identifica que una minoría de productos de alto valor o alta rotación monetaria concentra la mayor inversión financiera.', 1);
INSERT INTO public."QuizQuestions" VALUES (5376, 8, '¿Cuál es la función primordial del ''Stock de Seguridad'' (Safety Stock) en un almacén?', 'El colchón de seguridad amortigua la variabilidad del mercado e impide roturas de stock durante el lead time de reposición.', 2);
INSERT INTO public."QuizQuestions" VALUES (5377, 8, '¿Qué indica el ''Punto de Reorden'' (ROP) en la gestión de abastecimiento?', 'Cuando el saldo en almacén cae al valor del ROP, se dispara el pedido para que la nueva mercancía arribe antes de agotar el stock de seguridad.', 3);
INSERT INTO public."QuizQuestions" VALUES (5378, 8, 'Si un producto tiene una demanda diaria de 10 unidades, el proveedor tarda 5 días en entregar y el stock de seguridad es de 20 unidades, ¿cuál es el ROP?', 'ROP = (10 unidades/día * 5 días) + 20 unidades de seguridad = 50 + 20 = 70 unidades.', 4);
INSERT INTO public."QuizQuestions" VALUES (5379, 8, '¿Cuál de los siguientes es un costo típico de ''Mantenimiento de Inventario'' (Carrying Cost)?', 'Mantener inventario genera costos de espacio físico, seguros, depreciación, obsolescencia y costo de oportunidad del capital invertido.', 5);
INSERT INTO public."QuizQuestions" VALUES (5380, 8, '¿Por qué son preferibles los ''Conteos Cíclicos'' continuos frente a los inventarios físicos anuales con parada de planta?', 'El conteo cíclico distribuye la auditoría durante los 365 días, mejorando la exactitud y evitando cierres comerciales traumáticos.', 6);
INSERT INTO public."QuizQuestions" VALUES (5381, 8, '¿Qué significa el indicador ERI (Exactitud de Registro de Inventario)?', 'Un ERI alto (ej. >98%) garantiza que el personal de ventas y compras tome decisiones sobre datos confiables sin sorpresas de desabastecimiento.', 7);
INSERT INTO public."QuizQuestions" VALUES (5382, 8, '¿Qué busca optimizar la fórmula del Lote Económico de Pedido (EOQ)?', 'El modelo EOQ equilibra los costos fijos de emitir pedidos con los costos variables de almacenamiento, encontrando el tamaño de lote más rentable.', 8);
INSERT INTO public."QuizQuestions" VALUES (5383, 8, 'En una toma física de inventario, ¿qué es un ''Conteo Ciego''?', 'El conteo ciego asegura que el operario cuente de forma imparcial y veraz sin estar condicionado a la cifra del sistema.', 9);
INSERT INTO public."QuizQuestions" VALUES (5384, 8, '¿Qué indica una alta ''Rotación de Inventarios'' en una empresa comercial?', 'Una rotación elevada es señal de dinamismo comercial, eficiencia operativa y menor capital ocioso inmovilizado en depósitos.', 10);
INSERT INTO public."QuizQuestions" VALUES (5385, 38, '¿Cuál es la función del proceso de ''Picking'' en las operaciones de un almacén logístico?', 'El picking es la actividad de recolección de productos individuales o cajas para consolidar pedidos de despacho.', 1);
INSERT INTO public."QuizQuestions" VALUES (5386, 38, '¿Cuál es la técnica ergonómica correcta para levantar una caja pesada del suelo?', 'Doblar las rodillas y mantener la espalda recta utiliza la musculatura de las piernas, previniendo lesiones discales y hernias en la columna vertebral.', 2);
INSERT INTO public."QuizQuestions" VALUES (5387, 38, '¿Qué equipo de protección personal (EPP) es obligatorio para ingresar a un almacén de carga y estanterías de altura?', 'Las botas con puntera protegen contra aplastamientos por caída de objetos y el chaleco reflectante asegura visibilidad frente a montacargas.', 3);
INSERT INTO public."QuizQuestions" VALUES (5388, 38, '¿Por qué es peligroso que las cajas sobresalgan del borde perimetral del pallet de madera (voladizo)?', 'El voladizo debilita las esquinas portantes de las cajas de cartón, propiciando el colapso del bulto y caídas de mercancía.', 4);
INSERT INTO public."QuizQuestions" VALUES (5389, 38, 'En la metodología japonesa de las 5S, ¿qué significa la fase ''Seiton'' (Ordenar)?', 'Seiton busca ubicar los objetos de manera lógica y visible para encontrarlos y devolverlos sin pérdidas de tiempo.', 5);
INSERT INTO public."QuizQuestions" VALUES (5390, 38, '¿Para qué se utiliza el ''Film Stretch'' (plástico extensible) al finalizar el armado de un pallet de mercancía?', 'El film envuelve y compacta las cajas en una sola unidad de carga estable y resistente a vibraciones de tránsito.', 6);
INSERT INTO public."QuizQuestions" VALUES (5391, 38, '¿Cuál es el propósito del área de ''Staging'' o Expedición en un centro de distribución?', 'La zona de expedición o staging asegura que cada ruta de transporte reciba los bultos exactos correspondientes a su manifiesto de carga.', 7);
INSERT INTO public."QuizQuestions" VALUES (5392, 38, '¿Qué debe hacer un auxiliar de almacén si detecta un derrame de aceite o líquido en un pasillo por donde transitan personas o montacargas?', 'Los derrames de líquidos son la principal causa de resbalones graves y pérdidas de tracción en montacargas; su limpieza inmediata es prioritaria.', 8);
INSERT INTO public."QuizQuestions" VALUES (5393, 38, '¿Qué herramienta portátil electrónica suele utilizar el auxiliar de almacén para escanear ubicaciones y registrar el picking en el sistema WMS?', 'Los colectores de datos por radiofrecuencia leen códigos de barras y actualizan el inventario en el software WMS en tiempo real.', 9);
INSERT INTO public."QuizQuestions" VALUES (5394, 38, '¿Por qué es fundamental respetar los pasos peatonales demarcados en el suelo de una nave logística?', 'La segregación peatón-máquina es la regla básica de seguridad para evitar colisiones catastróficas en centros de distribución.', 10);
INSERT INTO public."QuizQuestions" VALUES (5395, 6, '¿Cuál de las siguientes afirmaciones refleja uno de los valores esenciales del Manifiesto Ágil?', 'El Manifiesto Ágil valora el producto funcional y tangible entregado al usuario por encima de voluminosos manuales teóricos sin implementar.', 1);
INSERT INTO public."QuizQuestions" VALUES (5396, 6, 'En el marco de trabajo Scrum, ¿quién es el único responsable de gestionar y priorizar el Product Backlog?', 'El Product Owner representa la voz del negocio y tiene la autoridad exclusiva para decidir qué elementos se construyen primero.', 2);
INSERT INTO public."QuizQuestions" VALUES (5397, 6, '¿Cuál es el rol primordial del Scrum Master dentro del equipo?', 'El Scrum Master no es un jefe tradicional; es un facilitador y coach que remueve obstáculos para que el equipo pueda trabajar sin trabas.', 3);
INSERT INTO public."QuizQuestions" VALUES (5398, 6, '¿Cuánto tiempo debe durar idealmente la reunión diaria de sincronización (Daily Scrum)?', 'El Daily Scrum es una reunión breve y dinámica enfocada exclusivamente en sincronizar el plan diario y detectar bloqueos inmediatos.', 4);
INSERT INTO public."QuizQuestions" VALUES (5399, 6, '¿En qué evento de Scrum el equipo se reúne específicamente para reflexionar sobre su forma de trabajar y proponer mejoras para el siguiente Sprint?', 'La Retrospectiva es el espacio sagrado de inspección y adaptación interna donde el equipo evalúa personas, relaciones, procesos y herramientas.', 5);
INSERT INTO public."QuizQuestions" VALUES (5400, 6, '¿Qué significa el límite de ''WIP'' (Work In Progress) en un tablero Kanban?', 'Limitar el WIP evita la multitarea caótica, reduce los cuellos de botella y asegura que las tareas se terminen antes de abrir otras nuevas.', 6);
INSERT INTO public."QuizQuestions" VALUES (5401, 6, '¿Qué es el ''Incremento'' en Scrum?', 'El Incremento es el resultado concreto y utilizable que aporta valor inmediato a los usuarios o a la organización.', 7);
INSERT INTO public."QuizQuestions" VALUES (5402, 6, '¿Cuál es el propósito del evento ''Sprint Review''?', 'La Revisión del Sprint es un evento de demostración y retroalimentación abierta con el negocio y los clientes.', 8);
INSERT INTO public."QuizQuestions" VALUES (5403, 6, '¿Qué es una ''Historia de Usuario'' en el desarrollo ágil?', 'Las Historias de Usuario capturan el valor de negocio de forma empática y concisa usando la estructura ''Como usuario, quiero X para lograr Y''.', 9);
INSERT INTO public."QuizQuestions" VALUES (5404, 6, '¿Por qué un Sprint en Scrum tiene una duración fija (típicamente entre 1 y 4 semanas)?', 'El timebox fijo crea una cadencia predecible, reduce el riesgo de desvío y asegura entregas frecuentes de valor al cliente.', 10);
INSERT INTO public."QuizQuestions" VALUES (5405, 10, 'En la matriz FODA, ¿cuál de los siguientes cuadrantes agrupa factores sobre los cuales la empresa tiene control interno directo?', 'Las fortalezas y debilidades corresponden al entorno interno de la organización (recursos, procesos, talento, tecnología), por lo que son directamente controlables.', 1);
INSERT INTO public."QuizQuestions" VALUES (5406, 10, '¿Qué factores macroambientales evalúa el modelo PESTEL en la planificación estratégica?', 'El análisis PESTEL diagnostica las fuerzas externas del macroentorno que escapan al control de la firma pero condicionan su futuro.', 2);
INSERT INTO public."QuizQuestions" VALUES (5407, 10, 'Según el modelo de las 5 Fuerzas de Michael Porter, ¿qué situación reduce el poder de negociación de los proveedores?', 'La abundancia de proveedores con ofertas homogéneas le otorga a la empresa compradora el poder de negociar mejores precios y condiciones.', 3);
INSERT INTO public."QuizQuestions" VALUES (5408, 10, '¿Cuál es la característica principal de un ''Resultado Clave'' (Key Result) dentro de la metodología OKR?', 'Un Resultado Clave debe tener métricas numéricas concretas (de X a Y) para evitar ambigüedades sobre si se alcanzó o no.', 4);
INSERT INTO public."QuizQuestions" VALUES (5409, 10, '¿Cuáles son las 4 perspectivas fundamentales que integran el Cuadro de Mando Integral (Balanced Scorecard)?', 'El BSC de Kaplan y Norton estructura la gestión balanceada conectando la perspectiva de personas/tecnología con procesos, clientes y resultados financieros.', 5);
INSERT INTO public."QuizQuestions" VALUES (5410, 10, '¿En qué consiste una estrategia defensiva ''FA'' en una matriz cruzada FODA?', 'Las estrategias FA aprovechan la solidez interna (ej. marca reconocida, liquidez) para amortiguar crisis del mercado o embates de competidores.', 6);
INSERT INTO public."QuizQuestions" VALUES (5411, 10, '¿Por qué es riesgoso que una empresa dependa exclusivamente de un solo cliente que genera más del 70% de sus ingresos?', 'La alta concentración de ingresos en un único cliente anula el poder de la empresa y representa un riesgo existencial crítico.', 7);
INSERT INTO public."QuizQuestions" VALUES (5412, 10, '¿Cuál es la diferencia primordial entre la ''Visión'' y la ''Misión'' corporativa?', 'La misión responde al ''¿quiénes somos y qué hacemos hoy?'', mientras que la visión inspira el estado deseado en el horizonte futuro.', 8);
INSERT INTO public."QuizQuestions" VALUES (5413, 10, 'En la perspectiva de ''Procesos Internos'' del Balanced Scorecard, ¿qué se busca medir principalmente?', 'Esta perspectiva asegura la excelencia en las actividades operativas internas que impactan directamente en la satisfacción del cliente y el costo.', 9);
INSERT INTO public."QuizQuestions" VALUES (5414, 10, '¿Cuál es el ritmo de cadencia temporal más habitual y recomendado para evaluar los OKRs en empresas ágiles?', 'La cadencia trimestral permite tener la flexibilidad suficiente para adaptarse a cambios sin perder el foco en la ejecución de metas de impacto.', 10);
INSERT INTO public."QuizQuestions" VALUES (5415, 36, '¿Cuál es la principal diferencia entre la Misión y los Valores de una empresa?', 'La misión responde al propósito operativo (qué hace la empresa), mientras los valores rigen cómo se comporta la organización para lograrlo.', 1);
INSERT INTO public."QuizQuestions" VALUES (5416, 36, '¿Qué constituye un ''Conflicto de Interés'' en el puesto de trabajo?', 'El conflicto de interés compromete la objetividad y lealtad hacia la compañía en favor de un beneficio particular.', 2);
INSERT INTO public."QuizQuestions" VALUES (5417, 36, 'Si un proveedor habitual envía un regalo costoso de fin de año (ej. un teléfono móvil de última generación) al encargado de compras, ¿cuál es la conducta ética correcta?', 'Los regalos costosos comprometen la imparcialidad del comprador; deben declararse y canalizarse bajo la política oficial de regalos.', 3);
INSERT INTO public."QuizQuestions" VALUES (5418, 36, '¿Cuál es el propósito fundamental de una ''Línea Ética'' o canal de denuncias anónimo (Whistleblowing) en una corporación?', 'La línea ética garantiza confidencialidad y no represalias, permitiendo detectar irregularidades a tiempo para corregirlas.', 4);
INSERT INTO public."QuizQuestions" VALUES (5419, 36, '¿Qué implica la firma de un ''Acuerdo de Confidencialidad'' (NDA - Non-Disclosure Agreement)?', 'El NDA protege los activos intangibles y datos privados de la organización ante divulgaciones no autorizadas.', 5);
INSERT INTO public."QuizQuestions" VALUES (5420, 36, 'En el marco de la Responsabilidad Social Empresarial, ¿a qué se refiere el enfoque de ''Triple Impacto''?', 'El triple impacto evalúa el éxito corporativo integrando beneficios financieros, bienestar de la comunidad y protección ecológica.', 6);
INSERT INTO public."QuizQuestions" VALUES (5421, 36, '¿Qué es el ''Compliance'' (Cumplimiento Normativo) en una organización?', 'Compliance asegura que todas las actividades de la compañía se apeguen estrictamente al marco legal vigente y a estándares éticos internacionales.', 7);
INSERT INTO public."QuizQuestions" VALUES (5422, 36, 'Si un colaborador presencia una conducta reiterada de acoso laboral (mobbing) hacia un compañero, ¿cuál debe ser su postura según la ética profesional?', 'La pasividad ante el acoso vulnera la dignidad humana; el deber ético es reportar los hechos por las vías institucionales establecidas.', 8);
INSERT INTO public."QuizQuestions" VALUES (5423, 36, '¿Por qué la ''Transparencia'' es considerada un valor estratégico fundamental para las empresas modernas?', 'La transparencia informativa y contable genera credibilidad, lealtad de marca y facilita el acceso a financiamiento internacional.', 9);
INSERT INTO public."QuizQuestions" VALUES (5424, 36, '¿Qué acción representa una violación directa al uso ético de los recursos materiales de la empresa?', 'Los activos y suministros de la empresa están destinados exclusivamente para las actividades laborales asignadas.', 10);
INSERT INTO public."QuizQuestions" VALUES (5425, 37, '¿Cuál es la recomendación clave sobre el contacto visual durante una atención presencial con un cliente?', 'Un contacto visual equilibrado transmite calidez y escucha atenta sin incomodar al interlocutor.', 1);
INSERT INTO public."QuizQuestions" VALUES (5426, 37, 'En el método LAST para gestionar clientes difíciles, ¿qué significa la letra ''A'' (Apologize)?', 'La disculpa institucional valida las emociones del cliente y desarma la hostilidad inicial.', 2);
INSERT INTO public."QuizQuestions" VALUES (5427, 37, '¿Por qué la frase ''¡Cálmese!'' suele empeorar el enojo de un cliente molesto?', 'Decirle ''cálmese'' a una persona enfadada invalida su frustración y suele desatar mayor agresividad verbal.', 3);
INSERT INTO public."QuizQuestions" VALUES (5428, 37, '¿Qué es el ''Parafraseo'' en la técnica de escucha activa?', 'El parafraseo demuestra que se estaba prestando atención y alinea las expectativas de solución de forma cristalina.', 4);
INSERT INTO public."QuizQuestions" VALUES (5429, 37, 'En la métrica de Net Promoter Score (NPS), ¿cómo se clasifican los clientes que califican con puntuación 9 o 10?', 'Las puntuaciones 9 y 10 corresponden a Promotores: clientes altamente satisfechos que impulsan el crecimiento recomendando la marca.', 5);
INSERT INTO public."QuizQuestions" VALUES (5430, 37, '¿Qué postura corporal transmite desinterés o rechazo hacia un cliente que se acerca al mostrador?', 'Los brazos cruzados y la distracción con el móvil emiten una señal tajante de desinterés y mala educación.', 6);
INSERT INTO public."QuizQuestions" VALUES (5431, 37, '¿Por qué es fundamental dejar que un cliente enojado hable sin interrupciones durante los primeros 45 segundos?', 'Interrumpir en pleno pico emocional aumenta la furia; escuchar en silencio drena la energía de confrontación.', 7);
INSERT INTO public."QuizQuestions" VALUES (5432, 37, '¿Qué alternativa asertiva reemplaza profesionalmente a la frase ''Ese no es mi problema ni mi departamento''?', 'La orientación y el acompañamiento proactivo demuestran espíritu de servicio y compromiso con la solución.', 8);
INSERT INTO public."QuizQuestions" VALUES (5433, 37, '¿Qué significa el concepto de ''Efecto WOW'' en la experiencia del cliente?', 'El efecto WOW va más allá de cumplir el servicio básico: añade un toque humano o de valor que deja una huella emocional positiva.', 9);
INSERT INTO public."QuizQuestions" VALUES (5434, 37, '¿Por qué retener a un cliente existente es considerablemente más rentable que captar uno nuevo?', 'La fidelización maximiza el valor de vida del cliente (LTV) y reduce drásticamente los gastos de captación comercial.', 10);
INSERT INTO public."QuizQuestions" VALUES (5435, 16, '¿Qué es la ''Paradoja de Recuperación del Servicio'' (Service Recovery Paradox)?', 'Una resolución brillante transforma una crisis en una demostración indiscutible de compromiso que forja fidelidad a largo plazo.', 1);
INSERT INTO public."QuizQuestions" VALUES (5436, 16, '¿Qué significa el indicador FCR (First Contact Resolution) en un centro de atención o soporte?', 'FCR es la métrica más ligada a la satisfacción del cliente, ya que a nadie le gusta llamar múltiples veces por el mismo problema.', 2);
INSERT INTO public."QuizQuestions" VALUES (5437, 16, '¿En qué consiste una ''Transferencia Cálida'' de llamada telefónica?', 'La transferencia cálida traspasa el contexto del problema al colega, evitando que el cliente deba narrar su queja desde el inicio.', 3);
INSERT INTO public."QuizQuestions" VALUES (5438, 16, '¿Qué mide el indicador CES (Customer Effort Score)?', 'El esfuerzo del cliente es el predictor principal de deserción: entre más fácil y fluido sea resolver un trámite, más fiel es el cliente.', 4);
INSERT INTO public."QuizQuestions" VALUES (5439, 16, '¿Qué define un Acuerdo de Nivel de Servicio (SLA - Service Level Agreement)?', 'El SLA formaliza los plazos máximos tolerados para atender y resolver tickets según su nivel de severidad e impacto.', 5);
INSERT INTO public."QuizQuestions" VALUES (5440, 16, '¿Por qué es una mala práctica debatir o confrontar públicamente a un cliente que deja una queja en redes sociales abiertas?', 'Pelear en público arruina la imagen corporativa; la contención debe ser rápida para luego gestionar la solución de forma privada y documentada.', 6);
INSERT INTO public."QuizQuestions" VALUES (5441, 16, '¿Qué efecto produce la ''Sonrisa Telefónica'' al atender una llamada de un cliente?', 'La biomecánica facial altera el timbre y resonancia vocal, permitiendo que el cerebro humano detecte la amabilidad auditivamente.', 7);
INSERT INTO public."QuizQuestions" VALUES (5442, 16, '¿Cuál es la forma correcta de redactar una respuesta por correo electrónico a un cliente que reporta un error?', 'La correspondencia profesional exige estructura limpia, claridad de pasos y cortesía formal para proyectar seriedad y confiabilidad.', 8);
INSERT INTO public."QuizQuestions" VALUES (5443, 16, 'En la métrica CSAT (Customer Satisfaction), ¿cómo se calcula habitualmente el porcentaje final de satisfacción?', 'CSAT expresa el porcentaje directo de clientes que calificaron su experiencia como buena o excelente.', 9);
INSERT INTO public."QuizQuestions" VALUES (5444, 16, '¿Cuál es el tiempo máximo prudente para mantener a un cliente en ''Música de Espera'' (Hold) sin retomar la llamada para informarle el avance?', 'Dejar al cliente en silencio o música prolongada genera angustia y sensación de abandono; debe refrescarse el contacto periódicamente.', 10);
INSERT INTO public."QuizQuestions" VALUES (5445, 39, 'Según la investigación de Daniel Goleman, ¿qué componente de la Inteligencia Emocional permite resistir impulsos destructivos y mantener la compostura en crisis?', 'La autorregulación permite frenar reacciones viscerales y canalizar las emociones de forma productiva y serena.', 1);
INSERT INTO public."QuizQuestions" VALUES (5446, 39, 'En el Proyecto Aristóteles de Google, ¿cuál fue el factor número uno que distinguió a los equipos de trabajo más exitosos y de alto rendimiento?', 'La seguridad psicológica desata la innovación, la honestidad y el aprendizaje acelerado en los equipos colaborativos.', 2);
INSERT INTO public."QuizQuestions" VALUES (5447, 39, '¿Qué estructura sigue el modelo de retroalimentación profesional SBI?', 'El modelo SBI (Situation-Behavior-Impact) despersonaliza la crítica basándose en conductas objetivas y resultados verificables.', 3);
INSERT INTO public."QuizQuestions" VALUES (5448, 39, '¿Cuál de las siguientes afirmaciones describe la metodología de Roles de Equipo de Meredith Belbin?', 'La complementariedad de talentos (ej. generadores de ideas, impulsores de acción y finalizadores detallistas) genera equilibrio operativo.', 4);
INSERT INTO public."QuizQuestions" VALUES (5449, 39, '¿Qué establece la ''Regla de los 2 Minutos'' para vencer la procrastinación en el trabajo?', 'Ejecutar al instante tareas diminutas evita la acumulación de pendientes que saturan la memoria de trabajo y generan estrés.', 5);
INSERT INTO public."QuizQuestions" VALUES (5450, 39, '¿Cuál es el error más común al momento de brindar retroalimentación constructiva a un compañero?', 'Los juicios sobre la identidad generan actitudes defensivas y hostilidad; el feedback eficaz se enfoca en conductas modificables.', 6);
INSERT INTO public."QuizQuestions" VALUES (5451, 39, '¿Qué es el ''Secuestro de la Amígdala'' (Amygdala Hijack)?', 'La amígdala cerebral reacciona con impulsos de lucha o huida ante el estrés; la inteligencia emocional permite respirar y pausar la respuesta.', 7);
INSERT INTO public."QuizQuestions" VALUES (5452, 39, 'En la Comunicación No Violenta (CNV), ¿cuál es el paso que sigue a la observación objetiva de los hechos?', 'La CNV busca conectar con las necesidades humanas universales subyacentes antes de realizar una petición concreta y negociable.', 8);
INSERT INTO public."QuizQuestions" VALUES (5453, 39, '¿Por qué un equipo de trabajo compuesto únicamente por perfiles creativos y visionarios suele tener problemas en la práctica?', 'Sin perfiles metódicos y enfocados en el detalle y los plazos, las ideas visionarias se disipan sin materializarse en resultados.', 9);
INSERT INTO public."QuizQuestions" VALUES (5454, 39, '¿Cuál es la premisa central del libro ''Hábitos Atómicos'' de James Clear?', 'El efecto compuesto de los microhábitos diarios transforma la identidad y la productividad personal de manera perdurable.', 10);
INSERT INTO public."QuizQuestions" VALUES (5455, 11, 'En el modelo de Liderazgo Situacional de Hersey y Blanchard, ¿qué estilo de liderazgo corresponde aplicar con un colaborador recién contratado que tiene mucho entusiasmo pero escasa competencia técnica (M1)?', 'El colaborador novato pero motivado necesita dirección clara y parámetros técnicos precisos para aprender con seguridad.', 1);
INSERT INTO public."QuizQuestions" VALUES (5456, 11, '¿Cuál es el propósito central de una reunión individual ''One-on-One'' (1 a 1) entre un líder y su colaborador?', 'Los One-on-Ones priorizan la escucha y el crecimiento del colaborador, fortaleciendo el vínculo de confianza con su líder.', 2);
INSERT INTO public."QuizQuestions" VALUES (5457, 11, '¿Qué es el ''Micromanagement'' y qué efecto negativo produce en los equipos?', 'El micromanagement transmite desconfianza y satura al líder con tareas menores, atrofiando la iniciativa del equipo.', 3);
INSERT INTO public."QuizQuestions" VALUES (5458, 11, '¿Cuál es la diferencia fundamental entre ''Delegar'' y simplemente ''Desentenderse'' (abdicar) de una tarea?', 'Delegar mantiene la responsabilidad última en el líder y provee el marco y los recursos para que el colaborador tenga éxito.', 4);
INSERT INTO public."QuizQuestions" VALUES (5459, 11, '¿Qué principio describe la ''Paradoja de Stockdale'' aplicada al liderazgo en crisis?', 'Equilibra el realismo radical ante las dificultades con el optimismo firme en la capacidad del equipo para salir adelante.', 5);
INSERT INTO public."QuizQuestions" VALUES (5460, 11, '¿Qué actitud debe asumir un líder cuando un colaborador autónomo y experimentado comete un error no intencional?', 'Fomentar una cultura donde los errores honestos se conviertan en mejoras sistémicas consolida la seguridad psicológica del equipo.', 6);
INSERT INTO public."QuizQuestions" VALUES (5461, 11, '¿Por qué el estilo de ''Liderazgo Autoritario'' (hacer las cosas únicamente porque yo lo mando) es insostenible en el mercado laboral contemporáneo?', 'El talento actual exige propósito, autonomía y respeto; el autoritarismo anula el compromiso e incrementa la rotación de personal.', 7);
INSERT INTO public."QuizQuestions" VALUES (5462, 11, '¿Qué pregunta abierta es ideal para que un líder solicite retroalimentación sobre su propia gestión en un One-on-One?', 'Invitar genuinamente a la crítica constructiva modela la vulnerabilidad y abre la puerta a un crecimiento bidireccional.', 8);
INSERT INTO public."QuizQuestions" VALUES (5463, 11, 'En la delegación por niveles, ¿qué caracteriza al nivel de ''Autonomía Completa''?', 'Se reserva para colaboradores de probada competencia y alineación de criterio con los objetivos estratégicos.', 9);
INSERT INTO public."QuizQuestions" VALUES (5464, 11, '¿Por qué un líder efectivo debe ser el primero en asumir la responsabilidad cuando su equipo falla frente a terceros o a la junta directiva?', 'Un líder que culpa a sus subordinados pierde el respeto al instante; asumir el escudo exterior forja una lealtad indestructible.', 10);
INSERT INTO public."QuizQuestions" VALUES (5465, 14, 'En el Método de Negociación de Harvard, ¿cuál es la diferencia fundamental entre una ''Posición'' y un ''Interés''?', 'Explorar los intereses reales permite encontrar soluciones creativas que satisfagan a ambas partes más allá de posturas inflexibles.', 1);
INSERT INTO public."QuizQuestions" VALUES (5466, 14, '¿Qué significan las siglas MAAN (o BATNA en inglés) en una negociación?', 'El MAAN es el plan B o curso de acción alternativo que ejecutarás si la negociación actual fracasa sin acuerdo.', 2);
INSERT INTO public."QuizQuestions" VALUES (5467, 14, '¿Por qué contar con un MAAN (BATNA) sólido otorga gran poder al negociador?', 'Tener una alternativa atractiva evita negociar desde la desesperación o aceptar condiciones ruinosas.', 3);
INSERT INTO public."QuizQuestions" VALUES (5468, 14, '¿Qué es la ZOPA (Zona de Posible Acuerdo)?', 'Si existe ZOPA positiva, existe un espacio financiero o de valor donde ambas partes quedan mejor que acudiendo a sus alternativas.', 4);
INSERT INTO public."QuizQuestions" VALUES (5469, 14, '¿Qué establece el principio de Harvard de ''Separar a las personas del problema''?', 'Ser suave con las personas y duro con el problema evita que los roces de ego o susceptibilidades arruinen una solución mutuamente beneficiosa.', 5);
INSERT INTO public."QuizQuestions" VALUES (5470, 14, '¿Por qué es un error grave en negociación conceder un descuento o rebaja unilateral sin pedir nada a cambio?', 'Toda concesión debe ser condicionada (''Si tú aceptas X, yo puedo otorgar Y'') para preservar el valor de la oferta.', 6);
INSERT INTO public."QuizQuestions" VALUES (5471, 14, '¿Qué es el ''Efecto de Anclaje'' en una conversación de negociación de precios?', 'La primera oferta fijada con argumentos sólidos ejerce un tirón magnético sobre el rango de contraofertas posibles.', 7);
INSERT INTO public."QuizQuestions" VALUES (5472, 14, '¿Qué táctica psicológica se está empleando cuando un negociador se muestra excesivamente agresivo e inflexible mientras su colega interviene fingiendo ser conciliador y amigable?', 'Busca que la víctima ceda ante el ''policía bueno'' por alivio de escapar a la hostilidad del ''policía malo''.', 8);
INSERT INTO public."QuizQuestions" VALUES (5473, 14, '¿Cómo se neutraliza eficazmente una táctica de presión del tipo ''Tómalo o déjalo ahora mismo''?', 'Nombrar la táctica o solicitar una pausa estratégica desarma la presión psicológica del ultimátum.', 9);
INSERT INTO public."QuizQuestions" VALUES (5474, 14, '¿Cuál es el rol de los ''Criterios Objetivos'' en el método Harvard?', 'Los criterios externos objetivos protegen la legitimidad del acuerdo y evitan que la negociación se degrade a una guerra de voluntades de poder.', 10);
INSERT INTO public."QuizQuestions" VALUES (5475, 15, 'En la Matriz de Eisenhower, ¿qué acción corresponde a las tareas ubicadas en el Cuadrante 2 (Importantes pero NO Urgentes)?', 'El Cuadrante 2 agrupa la planificación, la prevención y la estrategia; si no se programan proactivamente, terminan devoradas por las urgencias del día a día.', 1);
INSERT INTO public."QuizQuestions" VALUES (5476, 15, '¿Cuál es la duración clásica de una sesión de trabajo de hiperenfoque en la Técnica Pomodoro tradicional?', 'La técnica Pomodoro utiliza bloques de 25 minutos para maximizar la concentración sostenida sin provocar agotamiento mental.', 2);
INSERT INTO public."QuizQuestions" VALUES (5477, 15, '¿Qué establece la famosa ''Ley de Parkinson'' en la gestión de tareas?', 'Si te das dos semanas para hacer un informe que toma dos horas, el informe tardará dos semanas en completarse.', 3);
INSERT INTO public."QuizQuestions" VALUES (5478, 15, '¿En qué consiste la técnica de productividad de ''Timeblocking'' (bloques de tiempo)?', 'Timeblocking asigna un espacio físico y mental en el calendario, protegiendo las horas clave contra interrupciones espontáneas.', 4);
INSERT INTO public."QuizQuestions" VALUES (5479, 15, '¿Qué fenómeno cognitivo perjudicial ocurre cuando una persona salta constantemente entre múltiples tareas (multitarea)?', 'El cambio constante de contexto fatiga el cerebro y deja un ''residuo cognitivo'' que degrada la velocidad y precisión mental.', 5);
INSERT INTO public."QuizQuestions" VALUES (5480, 15, '¿En qué consiste la técnica de ''Batching'' (procesamiento por lotes) aplicada a los correos electrónicos?', 'Procesar en lotes reduce las interrupciones recurrentes y optimiza la concentración para tareas de mayor valor.', 6);
INSERT INTO public."QuizQuestions" VALUES (5481, 15, 'Según Cal Newport en su libro ''Deep Work'', ¿qué es el ''Trabajo Superficial'' (Shallow Work)?', 'El trabajo superficial es necesario pero no genera ventaja competitiva ni innovación significativa.', 7);
INSERT INTO public."QuizQuestions" VALUES (5482, 15, '¿Cuál de las siguientes actividades pertenece típicamente al Cuadrante 4 de Eisenhower (Ni urgente ni importante)?', 'El Cuadrante 4 constituye puro desperdicio de tiempo que debe ser eliminado para recuperar energía productiva.', 8);
INSERT INTO public."QuizQuestions" VALUES (5483, 15, '¿Qué se recomienda hacer durante el descanso de 5 minutos entre bloques de Pomodoro para que sea realmente restaurativo?', 'Desconectar la mirada de pantallas y mover el cuerpo alivia la fatiga ocular y recarga la atención voluntaria.', 9);
INSERT INTO public."QuizQuestions" VALUES (5484, 15, '¿Por qué la habilidad de ''Saber Decir NO'' de forma asertiva es indispensable para una gestión del tiempo exitosa?', 'Proteger el tiempo propio requiere poner límites claros y corteses a solicitudes que no se alinean con las responsabilidades centrales.', 10);
INSERT INTO public."QuizQuestions" VALUES (5485, 17, 'En la secuencia de emergencia PAS de primeros auxilios, ¿cuál es el significado correcto de las siglas y su orden estricto de aplicación?', 'Proteger el lugar evita nuevos accidentes; avisar a los servicios profesionales garantiza la ambulancia; y socorrer estabiliza al herido.', 1);
INSERT INTO public."QuizQuestions" VALUES (5486, 17, '¿Cuál es la frecuencia de compresiones torácicas recomendada por las guías internacionales para una RCP de alta calidad en un adulto?', 'El ritmo de 100-120 lpm (al compás de Stayin'' Alive) mantiene la perfusión cerebral y coronaria indispensable.', 2);
INSERT INTO public."QuizQuestions" VALUES (5487, 17, '¿En qué posición anatómica exacta se deben colocar las manos para iniciar las compresiones de RCP en un adulto?', 'El centro del esternón comprime el corazón directamente contra la columna vertebral generando flujo sanguíneo eficiente.', 3);
INSERT INTO public."QuizQuestions" VALUES (5488, 17, 'Si una persona se está atragantando con comida pero tose con fuerza y emite sonidos, ¿qué debe hacer el socorrista?', 'La tos espontánea es el mecanismo más potente y natural para desalojar cuerpos extraños; interferir puede encajar aún más la obstrucción.', 4);
INSERT INTO public."QuizQuestions" VALUES (5489, 17, '¿Cómo se ejecuta correctamente la Maniobra de Heimlich en una persona consciente con atragantamiento total que no puede toser ni hablar?', 'El empuje abdominal ascendente eleva el diafragma y comprime los pulmones, expulsando el objeto como un tapón a presión.', 5);
INSERT INTO public."QuizQuestions" VALUES (5490, 17, '¿Cuál es la primera acción recomendada ante una quemadura térmica por calor en la piel de un empleado?', 'El agua a temperatura ambiente drena el calor residual de los tejidos dérmicos; el hielo y remedios caseros causan quemaduras químicas e infecciones severas.', 6);
INSERT INTO public."QuizQuestions" VALUES (5491, 17, 'Si una herida en el brazo sangra de forma abundante y empapa por completo la primera gasa de tela colocada, ¿qué se debe hacer?', 'Retirar la primera gasa rompe el coágulo plaquetario que el cuerpo está formando, reactivando la hemorragia profusa.', 7);
INSERT INTO public."QuizQuestions" VALUES (5492, 17, '¿Qué es un DEA (Desfibrilador Externo Automático) y quién puede utilizarlo en una emergencia?', 'Los DEAs están diseñados para ser operados por legos con instrucciones audibles claras; solo aplican descarga si detectan un ritmo desfibrilable.', 8);
INSERT INTO public."QuizQuestions" VALUES (5493, 17, 'Si se sospecha que una persona accidentada sufrió una caída grave de altura con posible lesión en la columna vertebral o cuello, ¿cómo debe procederse?', 'Cualquier movimiento indebido en una fractura de columna puede seccionar la médula espinal y provocar parálisis permanente o la muerte.', 9);
INSERT INTO public."QuizQuestions" VALUES (5494, 17, '¿Por qué NO se debe aplicar alcohol o agua oxigenada directamente dentro de una herida abierta profunda?', 'El alcohol y agua oxigenada queman las células vivas; las heridas abiertas se limpian con agua limpia y jabón neutro o suero fisiológico estéril.', 10);


--
-- Data for Name: Quizzes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Quizzes" VALUES (6, 6, 'Gestión de Proyectos con Agile y Scrum: Sprints, Roles y Tableros Kanban - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (16, 16, 'Atención al Cliente: Excelencia Omnicanal, Protocolos y Resolución de Quejas - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (34, 35, 'Servicio Técnico Informático y Soporte a Sistemas: Hardware, Redes y Mantenimiento - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (30, 31, 'SAP Business One (SAP B1): Gestión Operativa de Ventas, Compras e Inventarios - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (3, 3, 'Excel Avanzado: Modelado Financiero, Fórmulas Anidadas, Tablas Dinámicas y Macros - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (33, 34, 'Mercaderista y Trade Merchandising: Exhibición, Rotación y Gestión en Punto de Venta - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (15, 15, 'Gestión del Tiempo y Productividad: Eisenhower, Pomodoro y Trabajo Profundo - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (35, 36, 'Administración Empresarial Básica: Estructura, Compras, Ventas y Reportes - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (38, 39, 'Auxiliar de Almacén, Control de Inventarios y Logística Básica - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (36, 37, 'Filosofía Empresarial, Cultura Organizacional y Ética Laboral - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (18, 19, 'Microsoft Office Básico: Word, Excel y PowerPoint para el Entorno Laboral - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (2, 2, 'Power BI: Modelado de Datos, DAX y Construcción de Dashboards Ejecutivos - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (5, 5, 'Ciencia y Análisis de Datos con Python y SQL: De Consultas a Machine Learning - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (19, 20, 'Microsoft Office Intermedio: Gestión Documental, Fórmulas de Análisis y Presentaciones Avanzadas - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (12, 12, 'Introducción a la Ciberseguridad: Defensa contra Phishing, Ransomware y Gestión de Redes Corporativas - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (39, 40, 'Trabajo en Equipo, Liderazgo Personal y Productividad Laboral - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (14, 14, 'Tácticas de Negociación Efectiva: El Método Harvard y Acuerdos Ganar-Ganar - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (7, 7, 'Tecnología de la Información para el Éxito Empresarial: Transformación Digital y Sistemas Corporativos - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (10, 10, 'Planificación Estratégica: De la Visión a la Ejecución con OKRs y Cuadro de Mando - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (31, 32, 'Shopify Básico: Creación, Configuración y Gestión de Tiendas Online - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (13, 13, 'Evaluación Sumativa: Inglés A1 (Curso Completo)', 'Evaluación integral de gramática, tiempos verbales y vocabulario de nivel A1 basado en el temario de AulaFácil. Calificación mínima aprobatoria: 70%.', 70.00, 20);
INSERT INTO public."Quizzes" VALUES (1, 1, 'Domina la IA con Gemini y ChatGPT: Prompt Engineering Avanzado y Productividad Empresarial - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (17, 17, 'Primeros Auxilios Laborales y Emergencias: Protocolo PAS, RCP y Bioseguridad - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (9, 9, 'Ventas en Línea: Estrategia Digital, Social Selling y Embudos de Conversión - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (8, 8, 'Administración y Control de Inventarios: Modelos ABC, Stocks de Seguridad y Auditoría - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (11, 11, 'Liderazgo Efectivo: Inteligencia Emocional, Coaching y Gestión de Equipos - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (32, 33, 'Asistente de Ventas Comercial: Gestión Administrativa, Atención y Supervisión en Piso - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);
INSERT INTO public."Quizzes" VALUES (37, 38, 'Atención al Cliente Presencial, Comunicación Asertiva y Fidelización - Evaluación Sumativa de Validación', 'Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.', 70.00, 25);


--
-- Data for Name: SystemSettings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."SystemSettings" VALUES (2, 'Site_Name', 'Nombre Principal del Sitio', 'CURSOS GLOBALES', '2026-10-18 02:58:08.405996-04');
INSERT INTO public."SystemSettings" VALUES (3, 'Site_Name_Highlight', 'Resaltado de Marca', 'JP', '2026-10-18 02:58:08.456917-04');
INSERT INTO public."SystemSettings" VALUES (4, 'Site_Slogan', 'Eslogan del Sitio', 'Aprende Gratis · Certifícate por $1 USD', '2026-10-18 02:58:08.46198-04');
INSERT INTO public."SystemSettings" VALUES (5, 'Site_Logo_Url', 'URL o Ruta del Logo', '/images/logo-jp.png', '2026-10-18 02:58:08.464145-04');
INSERT INTO public."SystemSettings" VALUES (6, 'Footer_Description', 'Descripción en Pie de Página', 'Democratizando la formación técnica, digital y empresarial. Conocimiento libre sin barreras y certificación oficial verificable por solo 1 dólar.', '2026-10-18 02:58:08.466691-04');
INSERT INTO public."SystemSettings" VALUES (7, 'Footer_Company_Info', 'Razón Social y RIF', 'Inversiones Globales JP 1968, C.A. • RIF: J-41102463-5', '2026-10-18 02:58:08.468993-04');
INSERT INTO public."SystemSettings" VALUES (8, 'Footer_Contact_Email', 'Correo de Soporte', 'soporte@globalesjp.net', '2026-10-18 02:58:08.471331-04');
INSERT INTO public."SystemSettings" VALUES (9, 'Footer_Website_Url', 'Sitio Web Institucional', 'https://globalesjp.net', '2026-10-18 02:58:08.47406-04');
INSERT INTO public."SystemSettings" VALUES (10, 'Footer_Copyright', 'Texto de Copyright', 'Cursos Globales JP (globalesjp.net). Plataforma de Certificación Profesional. Todos los derechos reservados.', '2026-10-18 02:58:08.476996-04');
INSERT INTO public."SystemSettings" VALUES (11, 'Footer_Payment_Methods', 'Métodos de Pago', 'Pago Móvil, Transferencia Bancaria, Binance Pay, USDT', '2026-10-18 02:58:08.479769-04');
INSERT INTO public."SystemSettings" VALUES (12, 'Footer_Payment_Note', 'Nota de Pago / Tasa', 'Pagos en bolívares a la tasa oficial del BCV', '2026-10-18 02:58:08.482194-04');
INSERT INTO public."SystemSettings" VALUES (13, 'Social_Instagram', 'Instagram', '@globalesjp', '2026-10-18 02:58:08.485218-04');
INSERT INTO public."SystemSettings" VALUES (14, 'Social_Whatsapp', 'WhatsApp', '+584125884084', '2026-10-18 02:58:08.488631-04');
INSERT INTO public."SystemSettings" VALUES (1, 'TermsAndConditions', 'Términos y Condiciones Generales de Uso, Formación y Certificación', '<h3>1. Identificación Legal de la Empresa Responsable</h3>
<p>Los presentes Términos y Condiciones Generales regulan el acceso, navegación, uso y contratación de servicios en la plataforma digital <strong>Cursos Globales JP</strong> (en adelante, ''la Plataforma''), operada, administrada y de propiedad legal exclusiva de <strong>Inversiones Globales JP 1968, C.A.</strong>, sociedad mercantil domiciliada en la República Bolivariana de Venezuela, inscrita en el Registro de Información Fiscal bajo el número <strong>RIF: J-41102463-5</strong>.</p>

<h3>2. Modalidad de Capacitación y Estudio 100% Libre</h3>
<p>La plataforma ofrece acceso gratuito y abierto a su catálogo de programas de formación técnica y profesional. Todo usuario registrado tiene el derecho de acceder a los contenidos interactivos, lecturas guiadas y materiales didácticos a su propio ritmo sin costo de matrícula.</p>

<h3>3. Requisito Indispensable de Culminación del Curso para Certificación</h3>
<p>Para tener derecho a solicitar, tramitar y descargar un certificado oficial acreditativo, el estudiante <strong>debe cursar y completar de manera obligatoria el 100% de las lecturas y módulos formativos que componen el curso</strong>, y posteriormente presentar y aprobar la evaluación sumativa correspondiente con una calificación igual o superior al puntaje mínimo exigido.</p>

<h3>4. Política Estricta de Titularidad Bancaria y Validación de Pagos</h3>
<div class="alert alert-warning border-0 p-3 rounded-3 my-3">
  <strong><i class="bi bi-shield-exclamation me-1"></i> Cláusula Fundamental de Validación Financiera:</strong>
  <p class="mb-1 mt-1">Todo pago o transferencia bancaria por concepto de emisión de certificado oficial ($1.00 USD) o membresía anual de formador/creador ($10.00 USD) realizado a través de Transferencia Bancaria (Banco de Venezuela) o Pago Móvil <strong>DEBE provenir exclusivamente de una cuenta bancaria cuyo titular coincida de manera exacta y comprobable con el Nombre Completo y Documento de Identidad (Cédula / RIF / DNI) registrados en la cuenta del estudiante</strong>.</p>
  <p class="mb-0 fw-bold text-danger"><i class="bi bi-exclamation-triangle-fill me-1"></i> Inversiones Globales JP 1968, C.A. NO SE HACE RESPONSABLE ni procesará solicitudes, validaciones ni reintegros por pagos efectuados desde cuentas bancarias de terceras personas no titulares o con inconsistencias de identidad.</p>
</div>

<h3>5. Liquidación en Bolívares y Aplicación de la Tasa Oficial del BCV</h3>
<p>De conformidad con la legislación cambiaria de la República Bolivariana de Venezuela y el artículo 128 de la Ley del Banco Central de Venezuela, todos los montos fijados en Dólares Estadounidenses ($ USD) que sean cancelados en Bolívares (Bs.) se liquidarán y calcularán única y exclusivamente con base en la <strong>tasa oficial de cambio del Banco Central de Venezuela (BCV)</strong> vigente para la fecha valor de la operación bancaria, consultable públicamente en <a href="https://www.bcv.org.ve/" target="_blank">www.bcv.org.ve</a>. No se aceptan liquidaciones bajo cotizaciones no oficiales o del mercado paralelo.</p>

<h3>6. Emisión, Verificación Criptográfica y Código QR de Diplomas</h3>
<p>Cada certificado emitido por Cursos Globales JP constituye un documento digital probatorio dotado de un código alfanumérico único de registro institucional y un código QR dinámico que enlaza al sistema de validación pública en tiempo real (<code>/Certificados/Verificar</code>). Se prohíbe terminantemente la adulteración, modificación, falsificación o reproducción engañosa de estos diplomas oficiales.</p>

<h3>7. Membresía de Creadores, Fijación de Precios y Retribución del 80%</h3>
<p>Los usuarios que contraten la Membresía de Creador ($10.00 USD/año) gozan del derecho a estructurar y publicar formaciones propias en la plataforma. Los creadores y administradores tienen la facultad de fijar de manera libre y autónoma el precio de emisión del certificado oficial de su programa (con un valor mínimo establecido de $1.00 USD o su equivalente en Bolívares a la tasa oficial del BCV).</p>
<p>Por cada certificado oficial emitido y efectivamente recaudado, <strong>el creador percibirá de forma garantizada el 80% del precio total fijado</strong>, mientras que la plataforma retiene un <strong>20% de comisión operativa</strong> destinada a solventar la infraestructura tecnológica, emisión criptográfica y verificación mediante código QR en tiempo real.</p>
<p><em>Ejemplo de liquidación:</em> Si el precio del certificado se mantiene en la tarifa base de $1.00 USD, al creador le corresponden $0.80 USD y a la plataforma $0.20 USD. Si el creador establece un precio de $5.00 USD, al creador le corresponden $4.00 USD y a la plataforma $1.00 USD. El creador garantiza la autoría de sus contenidos y mantendrá indemne a Inversiones Globales JP 1968, C.A. frente a eventuales infracciones de propiedad intelectual.</p>

<h3>8. Modificaciones, Reserva de Derechos y Ley Aplicable</h3>
<p>Inversiones Globales JP 1968, C.A. se reserva el derecho de rechazar comprobantes de pago ilegibles o sospechosos y de actualizar las presentes condiciones para salvaguardar la seguridad jurídica de la comunidad educativa. Las presentes condiciones se rigen e interpretan bajo el marco legal de la República Bolivariana de Venezuela.</p><h3>8. Canales Oficiales de Soporte y Atención al Cliente</h3>
<p>Para solicitudes de asistencia técnica, reporte de pagos, soporte en el aula virtual o consultas corporativas, el canal oficial directo es el correo electrónico: <a href="mailto:soporte@globalesjp.net"><strong>soporte@globalesjp.net</strong></a> y el sitio web institucional <a href="https://globalesjp.net" target="_blank"><strong>https://globalesjp.net</strong></a>.</p>', '2026-10-19 02:09:51.314902-04');
INSERT INTO public."SystemSettings" VALUES (16, 'Popup_IsEnabled', 'Popup Activado', 'false', '2026-10-19 15:31:16.249341-04');
INSERT INTO public."SystemSettings" VALUES (17, 'Popup_Title', 'Título del Popup', 'Mantenimiento Programado del Sistema', '2026-10-19 15:31:16.251978-04');
INSERT INTO public."SystemSettings" VALUES (18, 'Popup_Message', 'Mensaje del Popup', 'Estimados usuarios y estudiantes:

Nos encontramos realizando labores de mantenimiento técnico y actualización en los servidores de la plataforma.

Durante este breve período algunos accesos podrían experimentar demoras temporales. El servicio volverá a operar con total normalidad a la brevedad.

Agradecemos su valiosa comprensión.', '2026-10-19 15:31:16.253462-04');
INSERT INTO public."SystemSettings" VALUES (19, 'Popup_Type', 'Estilo Visual del Popup', 'warning', '2026-10-19 15:31:16.25461-04');
INSERT INTO public."SystemSettings" VALUES (20, 'Popup_ButtonText', 'Texto del Botón', 'Entendido', '2026-10-19 15:31:16.25639-04');
INSERT INTO public."SystemSettings" VALUES (21, 'Popup_ActionUrl', 'Enlace Opcional de Acción', '', '2026-10-19 15:31:16.257768-04');
INSERT INTO public."SystemSettings" VALUES (22, 'Popup_ActionText', 'Texto del Enlace Opcional', '', '2026-10-19 15:31:16.259335-04');
INSERT INTO public."SystemSettings" VALUES (23, 'Popup_ShowOnce', 'Mostrar Solo Primera Vez', 'false', '2026-10-19 15:31:16.26057-04');
INSERT INTO public."SystemSettings" VALUES (24, 'Popup_Version', 'Versión del Popup', '20261019193116', '2026-10-19 15:31:16.262122-04');


--
-- Data for Name: UserCvs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: UserNotifications; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Users" VALUES (5, 'Administrador Master', 'master@globalesjp.net', '3O7OTOJgZNBeMN9epNzIs0TkzTealwwFZfV7rsKH/fM=', 'V-00000000', 'Admin', '2026-10-18 02:05:14.116625-04', NULL, '', '', NULL, NULL);


--
-- Name: Categories_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Categories_Id_seq"', 22, true);


--
-- Name: CourseEnrollments_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CourseEnrollments_Id_seq"', 13, true);


--
-- Name: CourseModules_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CourseModules_Id_seq"', 266, true);


--
-- Name: Courses_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Courses_Id_seq"', 40, true);


--
-- Name: LessonProgresses_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."LessonProgresses_Id_seq"', 35, true);


--
-- Name: Lessons_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Lessons_Id_seq"', 266, true);


--
-- Name: Payments_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Payments_Id_seq"', 5, true);


--
-- Name: QuizAttempts_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."QuizAttempts_Id_seq"', 15, true);


--
-- Name: QuizOptions_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."QuizOptions_Id_seq"', 28576, true);


--
-- Name: QuizQuestions_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."QuizQuestions_Id_seq"', 7144, true);


--
-- Name: Quizzes_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Quizzes_Id_seq"', 39, true);


--
-- Name: SystemSettings_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."SystemSettings_Id_seq"', 24, true);


--
-- Name: UserCvs_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."UserCvs_Id_seq"', 2, true);


--
-- Name: UserNotifications_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."UserNotifications_Id_seq"', 2, true);


--
-- Name: Users_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Users_Id_seq"', 8, true);


--
-- Name: Categories PK_Categories; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "PK_Categories" PRIMARY KEY ("Id");


--
-- Name: Certificates PK_Certificates; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Certificates"
    ADD CONSTRAINT "PK_Certificates" PRIMARY KEY ("Id");


--
-- Name: CourseEnrollments PK_CourseEnrollments; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CourseEnrollments"
    ADD CONSTRAINT "PK_CourseEnrollments" PRIMARY KEY ("Id");


--
-- Name: CourseModules PK_CourseModules; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CourseModules"
    ADD CONSTRAINT "PK_CourseModules" PRIMARY KEY ("Id");


--
-- Name: Courses PK_Courses; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "PK_Courses" PRIMARY KEY ("Id");


--
-- Name: LessonProgresses PK_LessonProgresses; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LessonProgresses"
    ADD CONSTRAINT "PK_LessonProgresses" PRIMARY KEY ("Id");


--
-- Name: Lessons PK_Lessons; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Lessons"
    ADD CONSTRAINT "PK_Lessons" PRIMARY KEY ("Id");


--
-- Name: Payments PK_Payments; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "PK_Payments" PRIMARY KEY ("Id");


--
-- Name: QuizAttempts PK_QuizAttempts; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizAttempts"
    ADD CONSTRAINT "PK_QuizAttempts" PRIMARY KEY ("Id");


--
-- Name: QuizOptions PK_QuizOptions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizOptions"
    ADD CONSTRAINT "PK_QuizOptions" PRIMARY KEY ("Id");


--
-- Name: QuizQuestions PK_QuizQuestions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizQuestions"
    ADD CONSTRAINT "PK_QuizQuestions" PRIMARY KEY ("Id");


--
-- Name: Quizzes PK_Quizzes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Quizzes"
    ADD CONSTRAINT "PK_Quizzes" PRIMARY KEY ("Id");


--
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- Name: SystemSettings SystemSettings_Key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings"
    ADD CONSTRAINT "SystemSettings_Key_key" UNIQUE ("Key");


--
-- Name: SystemSettings SystemSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings"
    ADD CONSTRAINT "SystemSettings_pkey" PRIMARY KEY ("Id");


--
-- Name: UserCvs UserCvs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCvs"
    ADD CONSTRAINT "UserCvs_pkey" PRIMARY KEY ("Id");


--
-- Name: UserNotifications UserNotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserNotifications"
    ADD CONSTRAINT "UserNotifications_pkey" PRIMARY KEY ("Id");


--
-- Name: IX_Categories_Slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Categories_Slug" ON public."Categories" USING btree ("Slug");


--
-- Name: IX_Certificates_CourseId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Certificates_CourseId" ON public."Certificates" USING btree ("CourseId");


--
-- Name: IX_Certificates_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Certificates_UserId" ON public."Certificates" USING btree ("UserId");


--
-- Name: IX_Certificates_VerificationCode; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Certificates_VerificationCode" ON public."Certificates" USING btree ("VerificationCode");


--
-- Name: IX_CourseEnrollments_CourseId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CourseEnrollments_CourseId" ON public."CourseEnrollments" USING btree ("CourseId");


--
-- Name: IX_CourseEnrollments_UserId_CourseId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_CourseEnrollments_UserId_CourseId" ON public."CourseEnrollments" USING btree ("UserId", "CourseId");


--
-- Name: IX_CourseModules_CourseId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CourseModules_CourseId" ON public."CourseModules" USING btree ("CourseId");


--
-- Name: IX_Courses_CategoryId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Courses_CategoryId" ON public."Courses" USING btree ("CategoryId");


--
-- Name: IX_Courses_Slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Courses_Slug" ON public."Courses" USING btree ("Slug");


--
-- Name: IX_LessonProgresses_EnrollmentId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_LessonProgresses_EnrollmentId" ON public."LessonProgresses" USING btree ("EnrollmentId");


--
-- Name: IX_LessonProgresses_LessonId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_LessonProgresses_LessonId" ON public."LessonProgresses" USING btree ("LessonId");


--
-- Name: IX_Lessons_ModuleId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Lessons_ModuleId" ON public."Lessons" USING btree ("ModuleId");


--
-- Name: IX_Payments_CertificateId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Payments_CertificateId" ON public."Payments" USING btree ("CertificateId");


--
-- Name: IX_Payments_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Payments_UserId" ON public."Payments" USING btree ("UserId");


--
-- Name: IX_QuizAttempts_QuizId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_QuizAttempts_QuizId" ON public."QuizAttempts" USING btree ("QuizId");


--
-- Name: IX_QuizAttempts_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_QuizAttempts_UserId" ON public."QuizAttempts" USING btree ("UserId");


--
-- Name: IX_QuizOptions_QuestionId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_QuizOptions_QuestionId" ON public."QuizOptions" USING btree ("QuestionId");


--
-- Name: IX_QuizQuestions_QuizId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_QuizQuestions_QuizId" ON public."QuizQuestions" USING btree ("QuizId");


--
-- Name: IX_Quizzes_CourseId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Quizzes_CourseId" ON public."Quizzes" USING btree ("CourseId");


--
-- Name: IX_UserCvs_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserCvs_UserId" ON public."UserCvs" USING btree ("UserId");


--
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- Name: Certificates FK_Certificates_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Certificates"
    ADD CONSTRAINT "FK_Certificates_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE RESTRICT;


--
-- Name: Certificates FK_Certificates_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Certificates"
    ADD CONSTRAINT "FK_Certificates_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE RESTRICT;


--
-- Name: CourseEnrollments FK_CourseEnrollments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CourseEnrollments"
    ADD CONSTRAINT "FK_CourseEnrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- Name: CourseEnrollments FK_CourseEnrollments_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CourseEnrollments"
    ADD CONSTRAINT "FK_CourseEnrollments_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: CourseModules FK_CourseModules_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CourseModules"
    ADD CONSTRAINT "FK_CourseModules_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- Name: Courses FK_Courses_Categories_CategoryId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "FK_Courses_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES public."Categories"("Id") ON DELETE CASCADE;


--
-- Name: LessonProgresses FK_LessonProgresses_CourseEnrollments_EnrollmentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LessonProgresses"
    ADD CONSTRAINT "FK_LessonProgresses_CourseEnrollments_EnrollmentId" FOREIGN KEY ("EnrollmentId") REFERENCES public."CourseEnrollments"("Id") ON DELETE CASCADE;


--
-- Name: LessonProgresses FK_LessonProgresses_Lessons_LessonId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LessonProgresses"
    ADD CONSTRAINT "FK_LessonProgresses_Lessons_LessonId" FOREIGN KEY ("LessonId") REFERENCES public."Lessons"("Id") ON DELETE RESTRICT;


--
-- Name: Lessons FK_Lessons_CourseModules_ModuleId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Lessons"
    ADD CONSTRAINT "FK_Lessons_CourseModules_ModuleId" FOREIGN KEY ("ModuleId") REFERENCES public."CourseModules"("Id") ON DELETE CASCADE;


--
-- Name: Payments FK_Payments_Certificates_CertificateId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "FK_Payments_Certificates_CertificateId" FOREIGN KEY ("CertificateId") REFERENCES public."Certificates"("Id") ON DELETE CASCADE;


--
-- Name: Payments FK_Payments_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "FK_Payments_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE RESTRICT;


--
-- Name: QuizAttempts FK_QuizAttempts_Quizzes_QuizId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizAttempts"
    ADD CONSTRAINT "FK_QuizAttempts_Quizzes_QuizId" FOREIGN KEY ("QuizId") REFERENCES public."Quizzes"("Id") ON DELETE CASCADE;


--
-- Name: QuizAttempts FK_QuizAttempts_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizAttempts"
    ADD CONSTRAINT "FK_QuizAttempts_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: QuizOptions FK_QuizOptions_QuizQuestions_QuestionId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizOptions"
    ADD CONSTRAINT "FK_QuizOptions_QuizQuestions_QuestionId" FOREIGN KEY ("QuestionId") REFERENCES public."QuizQuestions"("Id") ON DELETE CASCADE;


--
-- Name: QuizQuestions FK_QuizQuestions_Quizzes_QuizId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuizQuestions"
    ADD CONSTRAINT "FK_QuizQuestions_Quizzes_QuizId" FOREIGN KEY ("QuizId") REFERENCES public."Quizzes"("Id") ON DELETE CASCADE;


--
-- Name: Quizzes FK_Quizzes_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Quizzes"
    ADD CONSTRAINT "FK_Quizzes_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- Name: UserCvs FK_UserCvs_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCvs"
    ADD CONSTRAINT "FK_UserCvs_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: UserNotifications UserNotifications_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserNotifications"
    ADD CONSTRAINT "UserNotifications_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


