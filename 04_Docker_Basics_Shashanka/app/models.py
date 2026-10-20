from typing import Literal

from pydantic import BaseModel, Field


class ServiceCreate(BaseModel):
    name: str = Field(min_length=2, max_length=100)
    owner: str = Field(min_length=2, max_length=100)


class ReleaseCreate(BaseModel):
    service_id: int = Field(gt=0)
    version: str = Field(min_length=1, max_length=50)
    environment: Literal["development", "staging", "production"]
