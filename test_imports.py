#!/usr/bin/env python3
"""
Test script to check if problematic imports are available
"""

def test_composio():
    try:
        from composio import Action
        print("✅ composio.Action import successful")
        return True
    except ImportError as e:
        print(f"❌ composio.Action import failed: {e}")
        return False

def test_cohere():
    try:
        from cohere.types import ChatResponse
        print("✅ cohere.types.ChatResponse import successful")
        return True
    except ImportError as e:
        print(f"❌ cohere.types.ChatResponse import failed: {e}")
        return False

def test_elasticsearch():
    try:
        import elasticsearch
        print("✅ elasticsearch import successful")
        return True
    except ImportError as e:
        print(f"❌ elasticsearch import failed: {e}")
        return False

def test_composio_alternatives():
    try:
        import composio
        print(f"Available in composio: {dir(composio)}")
    except ImportError as e:
        print(f"composio not available: {e}")

def test_cohere_alternatives():
    try:
        import cohere.types
        print(f"Available in cohere.types: {dir(cohere.types)}")
    except ImportError as e:
        print(f"cohere.types not available: {e}")

if __name__ == "__main__":
    print("Testing problematic imports...")
    
    test_composio()
    test_cohere()
    test_elasticsearch()
    
    print("\nChecking alternatives...")
    test_composio_alternatives()
    test_cohere_alternatives() 