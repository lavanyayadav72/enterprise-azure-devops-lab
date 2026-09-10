from app import app


def test_health():
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"


def test_accounts():
    client = app.test_client()

    response = client.get("/accounts")

    assert response.status_code == 200
    assert len(response.get_json()) == 2