// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract TaskManager {
    // Enum to represent task status
    enum Status { NotStarted, InProgress, Completed, Cancelled }

    // Struct to represent a Task
    struct Task {
        uint id;
        string name;
        string description;
        Status status;
        address createdBy;
    }

    // Mapping to store tasks by their ID
    mapping(uint => Task) public tasks;
    uint public nextTaskId;

    // Event to emit when a task is created
    event TaskCreated(uint id, string name, Status status, address createdBy);

    // Event to emit when a task status is updated
    event TaskStatusUpdated(uint id, Status newStatus);

    // Function to create a new task
    function createTask(string memory _name, string memory _description) public {
        tasks[nextTaskId] = Task({
            id: nextTaskId,
            name: _name,
            description: _description,
            status: Status.NotStarted,
            createdBy: msg.sender
        });
        
        emit TaskCreated(nextTaskId, _name, Status.NotStarted, msg.sender);
        nextTaskId++;
    }

    // Function to update the status of a task, taking Status enum as a parameter
    function updateTaskStatus(uint _taskId, Status _status) public {
        Task storage task = tasks[_taskId];
        require(task.createdBy == msg.sender, "Only the creator can update the task status");
        task.status = _status;
        
        emit TaskStatusUpdated(_taskId, _status);
    }

    // Function to get task details
    function getTask(uint _taskId) public view returns (string memory, string memory, Status, address) {
        Task storage task = tasks[_taskId];
        return (task.name, task.description, task.status, task.createdBy);
    }
}