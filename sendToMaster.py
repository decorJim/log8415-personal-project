import argparse
import requests

"""
python3 sendToMaster.py --ip1=ipdestinationmachine --ip2=10.0.0.2 --ip3=10.0.0.3 --ip4=10.0.0.4 --ip5=10.0.0.5
command for testing
"""

def runCommand(ipurl,ip1, ip2, ip3, ip4, ip5):
    url = f"http://{ipurl}/run_command"

    # Payload to be sent in the POST request
    payload = {
        "ip1": ip1,
        "ip2": ip2,
        "ip3": ip3,
        "ip4": ip4,
        "ip5": ip5
    }

    print(ip1,ip2,ip3,ip4,ip5)

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
    parser.add_argument("--ip2", required=True, help="IP address of the first slave node")
    parser.add_argument("--ip3", required=True, help="IP address of the second slave node")
    parser.add_argument("--ip4", required=True, help="IP address of the third slave node")
    parser.add_argument("--ip5", required=True, help="IP address of the fourth slave node")

    args = parser.parse_args()

    # Run the command using the provided IP addresses
    runCommand(args.ipurl,args.ip1, args.ip2, args.ip3, args.ip4, args.ip5)
