## Module Specific Environment Variables

### javelin-admin

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`DB_USERNAME` | Postgres username | nil
`DB_PASSWORD` | Postgres password | nil
`DB_HOST` | Postgres host | nil
`DB_NAME` | Postgres database | nil
`REDIS_HOST` | Redis host | nil
`REDIS_USER` | Redis username | nil
`REDIS_PASS` | Redis password | nil
`AWS_KMS_KEY` | AWS KMS Key for secret manager enc (optional) | nil
`AWS_SECRET_REPLICATION_REGION` | AWS replication region (optional) | nil
`AWS_REPLICATION_KMS_KEY` | AWS KMS Key for secret manager enc in replication region (optional) | nil
`REDIS_PORT` | Redis port | `6379`
`K8S_NAMESPACE` | Kubernetes namespace | `Deployed K8s namespace`
`DB_PORT` | Postgres port | `5432`
`REDTEAM_DB_NAME` | Postgres database | `javelin_redteam`
`SSL_MODE` | Postgres sslmode | `disable`
`JAVELIN_FF_URL` | Javelin flag url | `http://javelin-flag:1031/`
`JAVELIN_REDTEAM_URL` | Javelin redteam url | `http://javelin-redteam:8001/v1`

### javelin-core

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`LLAMA_GUARD_URL` | Llama gaurd url | nil
`LLAMA_GUARD_API_KEY` | Llama gaurd api key | nil
`REDIS_HOST` | Redis host | nil
`REDIS_USER` | Redis username | nil
`REDIS_PASS` | Redis password | nil
`UNKEY_ROOT_KEY` | Unkey Root Key | nil
`UNKEY_API_ID` | Unkey api id | nil
`REDIS_PORT` | Redis port | `6379`
`DEPLOY_TYPE` | Deploy type - dev or prod | `dev`
`K8S_NAMESPACE` | Kubernetes namespace | `Deployed K8s namespace`
`JAVELIN_ADMIN_URL` | Javelin admin url | `http://javelin-admin:8040`
`JAVELIN_EVAL_URL` | Javelin eval url | `http://javelin-eval:8009`
`JAVELIN_DLP_URL` | Javelin dlp url | `http://javelin-dlp:8888`
`JAVELIN_FF_URL` | Javelin flag url | `http://javelin-flag:1031/`
`JAVELIN_GUARD_URL` | Javelin guard url | `http://javelin-guard:8013`
`JAVELIN_GUARD_CM_URL` | Javelin guard cm url | `http://javelin-guard-cm:8014`
`JAVELIN_GUARD_HALLUCINATION_URL` | Javelin guard hallucination url | `http://javelin-guard-hallucination:8015`
`JAVELIN_GUARD_PLI_URL` | Javelin guard pli url | `http://javelin-guard-pli:8016`
`JAVELIN_GUARD_LANGUAGE_URL` | Javelin guard language url | `http://javelin-guard-lang:8020`
`JAVELIN_GUARD_FACTCHECK_URL` | Javelin guard factual url | `http://javelin-guard-fact:8018`
`JAVELIN_GUARD_SENTIMENT_URL` | Javelin guard sentiment url | `http://javelin-guard-sentiment:8021`
`REFRESH_SECRETS_ON_401` | Refresh secrets on 401 | `true`
`JAVELIN_CHECKPHISH_BUCKET_NAME` | Javelin checkphish bucket name | `javelin-saas-bloom-filter-store`
`JAVELIN_CHECKPHISH_OBJECT_NAME` | Javelin checkphish object name | `bloom_filter_url.gob`
`BYPASS_GUARDRAILS` | Bypass guardrails for streaming | `true`
`AUTO_PROVISION_APPLICATION` | Auto provision the application | `true`
`GOOGLE_CLOUD_PROJECT` | GCP project id | `javelin-saas`
`GOOGLE_APPLICATION_CREDENTIALS` | GCP json cred path | `/app/config/javelin-gcpjson.json`
`AWS_ACCESS_KEY_ID` | AWS Access Key | `""`
`AWS_SECRET_ACCESS_KEY` | AWS Secret Key | `""`
`AWS_REGION` | AWS Region | `""`
`ENABLE_SENTRY` | Sentry dsn | `false`
`SENTRY_DSN` | Sentry dsn | `""`

### javelin-webapp

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`CLERK_SECRET_KEY` | Clerk secret key | nil
`NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` | Clerk publishable key | nil
`NEXT_PUBLIC_POSTHOG_KEY` | Posthog key | nil
`NEXT_PUBLIC_BUID_MAX_GATEWAYS` | Max number of gateway | nil
`NEXT_PUBLIC_CLERK_SIGNUP` | Enable clerk sign up | nil
`NEXT_PUBLIC_DEFAULT_USAGE_PLAN_ID` | Javelin usage plan id | nil
`NEXT_PUBLIC_DEFAULT_USER_ROLE` | Default user role | nil
`NEXT_PUBLIC_DEPLOYED_TARGET` | Deployed target env | nil
`NEXT_PUBLIC_FEATURE_FLAG_URL` | GoProxy feature flag url | nil
`NEXT_PUBLIC_ONBOARDING_ENABLED` | Enable Onboarding | nil
`NEXT_PUBLIC_PRESTRINGS` | Filter prestrings for user roles | nil
`NEXT_PUBLIC_REDIRECT_URI` | Redirect url | nil
`NEXT_PUBLIC_USER_ROLES` | json formatted user roles | nil
`REDIRECT_URI` | Redirect url | nil
`NEXT_PUBLIC_BUID_CLUSTER_MAP` | json formatted buid cluser map | nil
`NEXT_PUBLIC_HA_PAIRS` | json formatted HA pair | nil
`NEXT_PUBLIC_SECRET_STORE` | Secret Store | `kubernetes` # `kubernetes`, `aws`, `gcp`
`NEXT_PUBLIC_CORE_INT_URL` | Javelin core internal url | `http://javelin-core:8000/`
`NEXT_PUBLIC_CLERK_SIGN_IN_URL` | Clerk sign in url | `/sign-in`
`NEXT_PUBLIC_CLERK_SIGN_UP_URL` | Clerk sign up url | `/signup`
`NEXT_PUBLIC_POSTHOG_HOST` | Posthog url | `https://app.posthog.com`
`SUPPORT_SMTP_FROM_EMAIL` | SMTP from mail | `noreply@getjavelin.io`
`SUPPORT_SMTP_PASSKEY` | SMTP Credential | ``
`SUPPORT_SMTP_SERVICE` | SMTP Service type | `Gmail`
`NEXT_PUBLIC_SUPPORT_SMTP_TO_EMAIL` | SMTP to mail | `support@getjavelin.io`
`NEXT_PUBLIC_SAAS_SERVICE` | Showcase the SaaS services in the UI | `FALSE`

### javelin-eval

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`CORS_ALLOWED_ORIGINS` | CORS allowed origins | `*`
`CORS_ALLOWED_METHODS` | CORS allowed methods | `POST,GET,OPTIONS`
`CORS_ALLOWED_HEADERS` | CORS allowed headers | `Authorization,Content-Type,x-api-key,x-javelin-user,x-javelin-userrole`

### javelin-dlp

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`CORS_ALLOWED_ORIGINS` | CORS allowed origins | `*`
`CORS_ALLOWED_METHODS` | CORS allowed methods | `POST,GET,OPTIONS`
`CORS_ALLOWED_HEADERS` | CORS allowed headers | `Authorization,Content-Type,x-api-key,x-javelin-user,x-javelin-userrole`

### javelin-redteam / javelin-redteam-worker / javelin-redteam-seeder

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`REDTEAM_MODULE` | Redteam module name | nil `api/queue/seeder`
`REDTEAM_SEEDER_DATASET` | Redteam seeder dataset name | nil `javelin-redteam-seeder specific`
`REDTEAM_SEEDER_DATASET_VER` | Redteam seeder dataset version | nil `javelin-redteam-seeder specific`
`REDTEAM_SEEDER_ARGS` | Redteam seeder command args | nil `javelin-redteam-seeder specific`
`HF_TOKEN` | HF token | nil
`OPENAI_API_KEY` | OpenAI api key | nil
`DB_USERNAME` | Postgres username | nil
`DB_PASSWORD` | Postgres password | nil
`DB_HOST` | Postgres host | nil
`XAI_API_KEY` | Xai api key | nil
`REDIS_CONN_STR` | Redis connection string | nil
`AZURE_API_KEY` | Azure OpenAI api key | nil
`AZURE_API_BASE` | Azure OpenAI API base | nil
`AZURE_API_VERSION` | Azure OpenAI version | nil
`GROK_MODEL_NAME` | Grok model name | nil
`DB_PORT` | Postgres port | `5432`
`REDTEAM_DB_NAME` | Postgres database | `javelin_redteam`
`JAVELIN_ADMIN_URL` | Javelin admin url | `http://javelin-admin:8040`

### ramparts-server

Variable Name | Variable Value | Default Value
--------------|--------------|--------------
`LLM_PROVIDER` | Provider name | nil
`LLM_MODEL` | Model name | nil
`LLM_URL` | LLM complete URL | nil
`LLM_API_KEY` | LLM API Key | nil