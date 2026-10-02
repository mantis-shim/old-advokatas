from dataclasses import dataclass
from datetime import datetime

@dataclass
class Article:
    id: int=0
    header: str= ""
    content: str= ""
    date: datetime =""
    description: str= ""
    type: str=""
    photosrc: str=""
