from io import BytesIO

from numpy import nan
from pandas import DataFrame, read_csv
from requests import get


def fetchCsvDataFromGoogleSheet(sheetId: str, subSheetId: str) -> DataFrame:
    request = get(f'https://docs.google.com/spreadsheets/d/{sheetId}/export?gid=0&format=csv')
    dataFrame = read_csv(BytesIO(request.content))
    dataFrame.replace(to_replace=nan, value=None, inplace=True)
    return dataFrame
