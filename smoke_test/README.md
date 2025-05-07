# Smoke Test Setup & Usage

Follow these steps to set up and run the smoke test:

## 1. Create and Activate a Python Virtual Environment

**Windows:**
```sh
python -m venv venv
venv\Scripts\activate
```

**macOS/Linux:**
```sh
python3 -m venv venv
source venv/bin/activate
```

## 2. Install Dependencies

With your virtual environment activated, run:
```sh
pip install -r requirements.txt
```

## 3. Configure API Keys

Edit the `config.json` file and set your API keys:
```json
{
    "x-api-key": "<your-javelin-api-key>",
    "openai_api_key": "<your-openai-api-key>"
}
```

## 4. Run the Smoke Test

With your virtual environment activated and dependencies installed, run:
```sh
python smoke_test.py
```

---

## Troubleshooting
- Ensure your Python version is compatible (Python 3.8+ recommended).
- Double-check that your API keys are valid and correctly set in `config.json`.

---

## Gateway Processor Chain Configuration (for New Gateway Testing)

If you are testing on a new gateway, ensure you have set up the correct processors in both the request and response chains.

### Request Chain Example
```json
{
  "name": "sys-preprod-reqchain",
  "path": "request_chain",
  "version": "1.1.2",
  "workflow": {
    "exec_mode": "sequential",
    "processors": [
      {
        "exec_mode": "parallel",
        "processors": [
          {
            "name": "Rate Limiter",
            "reference": "ratelimit",
            "will_block": true
          },
          {
            "name": "Sensitive Data Protection",
            "reference": "dlp_gcp",
            "will_block": true
          },
          {
            "name": "Prompt Injection Detection",
            "inputs": {
              "engine": "javelin"
            },
            "reference": "promptinjectiondetection",
            "will_block": true
          },
          {
            "name": "Trust & Safety",
            "scope": "system",
            "inputs": {
              "engine": "javelin"
            },
            "reference": "trustsafety",
            "will_block": true
          }
        ]
      },
      {
        "exec_mode": "parallel",
        "processors": [
          {
            "name": "Archive",
            "reference": "archive",
            "will_block": false
          },
          {
            "name": "Secrets",
            "reference": "secrets",
            "will_block": true
          }
        ]
      }
    ]
  },
  "description": "Pre-production request processor chain"
}
```

### Response Chain Example
```json
{
  "name": "sys-preprod-respchain",
  "path": "response_chain",
  "version": "1.1.2",
  "workflow": {
    "exec_mode": "sequential",
    "processors": [
      {
        "name": "Trust & Safety",
        "reference": "trustsafety",
        "will_block": true,
        "inputs": {
          "engine": "lakera"
        }
      },
      {
        "name": "Security Filters Code Detection",
        "reference": "securityfilters",
        "will_block": true
      },
      {
        "name": "Response Telemetry",
        "reference": "response",
        "will_block": true
      },
      {
        "name": "Archive",
        "reference": "archive",
        "will_block": false
      }
    ]
  },
  "description": "Pre-production response processor chain"
}
```

---

**Note:**
- Adjust processor configurations as needed for your environment.
- Ensure both chains are properly set up before running the smoke test on a new gateway.