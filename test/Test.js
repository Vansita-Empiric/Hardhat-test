// const { expect } = require("chai");
import * as chai from "chai";
const { assert, expect } = chai;

describe("TaskManager contract", function () {
    let contract;
    let owner;

    beforeEach(async function () {
        // Create the smart contract object to test from
        [owner] = await ethers.getSigners();
        const TestContract = await ethers.getContractFactory("TaskManager");
        contract = await TestContract.deploy();
        await contract.deployed();
    });

    it("Create task should work", async function () {
        // Get output from functions
        const createTaskTest = await contract.createTask("Task1", "Task1 created");
        await createTaskTest.wait();

        // const task = await contract.getTask(0);
        // expect(task[0]).to.equal("Task1");           
        // expect(task[1]).to.equal("Task1 created");   
        // expect(task[2]).to.equal(0);
    });

    it("Get task should work", async function() {
       await contract.createTask("Task1", "Task1 created");

        const task = await contract.getTask(0);
        expect(task[0]).to.equal("Task1");           
        expect(task[1]).to.equal("Task1 created");   
        expect(task[2]).to.equal(0); 
        expect(task[3]).to.equal(owner.address); 
    }); 

    it("Update task status should work", async function () {
        await contract.createTask("Task1", "Task1 created");

        const updateTask = await contract.updateTaskStatus(0, 1); 
        await updateTask.wait();

        const task = await contract.getTask(0);
    });

});