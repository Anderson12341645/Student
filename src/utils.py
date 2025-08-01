import os
import sys
import dill
import numpy as np
import pandas as pd

from src.exception import CustomException
from sklearn.metrics import r2_score
from sklearn.model_selection import GridSearchCV


def save_object(file_path, obj):
    try:
        dir_path = os.path.dirname(file_path)
        os.makedirs(dir_path, exist_ok=True)

        with open(file_path, "wb") as file_obj:
            dill.dump(obj, file_obj)
            
    except Exception as e:  # Added missing except block
        raise CustomException(e, sys) from e


def evaluate_models(X_train, y_train, X_test, y_test, models, param):
    try:
        report = {}
        
        for name, model in models.items():
            para = param[name]
            
            # Only perform GridSearch if parameters are provided
            if para:
                gs = GridSearchCV(model, para, cv=3)
                gs.fit(X_train, y_train)
                model = gs.best_estimator_
            
            # Train model
            model.fit(X_train, y_train)
            
            # Make predictions
            y_train_pred = model.predict(X_train)
            y_test_pred = model.predict(X_test)
            
            # Calculate scores
            train_model_score = r2_score(y_train, y_train_pred)
            test_model_score = r2_score(y_test, y_test_pred)
            
            report[name] = test_model_score
        
        return report
    
    except Exception as e:
        raise CustomException(e, sys) from e
    
def load_object(file_path):
    try:
        with open(file_path, "rb") as file_obj:
            return dill.load(file_obj)
    except Exception as e:
        raise CustomException(e, sys) from e