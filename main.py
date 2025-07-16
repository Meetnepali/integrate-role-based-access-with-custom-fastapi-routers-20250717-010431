from fastapi import FastAPI, APIRouter, Depends, HTTPException, status
from fastapi.responses import JSONResponse
from typing import Optional

# Simulate a simple user with roles for demonstration purposes
def get_current_user_role():
    # In a real system, this would use authentication
    # For demonstration, return a hardcoded role
    return "user"

app = FastAPI()

router = APIRouter()

@router.get("/data", tags=["data"])
def get_data(role: str = Depends(get_current_user_role)):
    if role != "user":
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Forbidden")
    return {"message": "Hello, this is your secured data!"}

app.include_router(router, prefix="/api")

@app.get("/")
def read_root():
    return {"hello": "world"}
