import argparse
import requests

"""
python3 sendToMaster.py --ipurl=ipdestinationmachine --ip1=10.0.0.2  
command for testing
"""

def runCommand(ipurl,ip1):
    url = f"http://{ipurl}/run_command"

    # Payload to be sent in the POST request
    payload = {
        "ip1": ip1,
    }

    print(ip1)

    try:
        # Send a POST request to the /run_command route
        response = requests.post(url, data=payload)
        
        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            print("Command executed successfully.")
            print("Response from server:", response.text)
        else:
            print(f"Command execution failed. Status code: {response.status_code}")
            print("Response from server:", response.text)
    except requests.RequestException as e:
        print(f"Error encountered while making the HTTP request to {url}: {e}")

if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Script to run a command on the master node.")
    parser.add_argument("--ipurl", required=True, help="IP public address of the master node")
    parser.add_argument("--ip1", required=True, help="IP address of the master node")

    args = parser.parse_args()

    # Run the command using the provided IP addresses
    runCommand(args.ipurl,args.ip1)